import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/logic/router.dart';
import 'package:united_library/providers/user.dart';
import 'package:united_library/screens/loading.dart';
import 'package:united_library/screens/wrong.dart';
import 'package:united_library/widgets/app_name.dart';


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  final AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => UserProvider(),
            // child: const AppNavigator(),
            child: MaterialApp.router(
                title: AppName.fullName,
                theme: ThemeData.dark(),
                routeInformationParser: _routeInformationParser,
                routerDelegate: _routerDelegate),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}
