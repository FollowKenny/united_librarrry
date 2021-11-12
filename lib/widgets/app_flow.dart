import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/providers/user.dart';
import 'package:united_library/screens/library.dart';
import 'package:united_library/screens/loading.dart';
import 'package:united_library/screens/logged_out.dart';
import 'package:united_library/screens/login.dart';
import 'package:united_library/screens/register.dart';
import 'package:united_library/screens/wrong.dart';
import 'package:united_library/widgets/app_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppName.fullName,
      home: InitApp(),
      theme: ThemeData.dark(),
    );
  }
}

class InitApp extends StatelessWidget {
  InitApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
            child: const HomeSwitch(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}

class HomeSwitch extends StatelessWidget {
  const HomeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.user == null) {
          return const LoggedOutNavigator();
        } else {
          return const MainNavigator();
        }
      },
    );
  }
}

class LoggedOutNavigator extends StatefulWidget {
  const LoggedOutNavigator({Key? key}) : super(key: key);

  @override
  State<LoggedOutNavigator> createState() => _LoggedOutNavigatorState();
}

class _LoggedOutNavigatorState extends State<LoggedOutNavigator> {
  String? _authAction;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          child: LoggedOut(selectAction: _updateAction),
        ),
        if (_authAction == 'register')
          const MaterialPage(
            child: Register(),
          )
        else if (_authAction == 'login')
          const MaterialPage(
            child: Login(),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _updateAction(null);
        return true;
      },
    );
  }

  void _updateAction(String? action) {
    setState(
      () {
        _authAction = action;
      },
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: const [
        MaterialPage(child: Library()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }
}
