import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/logic/router.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/providers/route.dart';
import 'package:united_library/providers/user.dart';
import 'package:united_library/screens/loading.dart';
import 'package:united_library/screens/wrong.dart';
import 'package:united_library/widgets/app_name.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<UserProvider>(
                // ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
              ChangeNotifierProxyProvider<UserProvider, RouteProvider>(
                create: (context) => RouteProvider(isLoggedIn: false),
                update: (context, userProvider, child) =>
                    RouteProvider(isLoggedIn: userProvider.user != null),
              ),
            ],
            // child: const AppNavigator(),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return MaterialApp.router(
                  title: AppName.fullName,
                  theme: ThemeData.dark(),
                  routeInformationParser: AppRouteInformationParser(
                    user: userProvider.user,
                  ),
                  routerDelegate: AppRouterDelegate(
                      Provider.of<RouteProvider>(context)),
                );
              },
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Container(); //const Loading();
      },
    );
  }
}
