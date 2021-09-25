import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/services/auth.dart';
import 'package:united_library/screens/sign_in.dart';
import 'package:united_library/screens/welcome.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  SignInMethod _selectedMethod = SignInMethod.none;

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.loginState == ApplicationLoginState.loggedOut) {
          return Navigator(
            pages: [
              MaterialPage(
                child: SignIn(
                  didSelectMethod: (method) {
                    setState(() => _selectedMethod = method);
                  },
                ),
              ),
              if (_selectedMethod == SignInMethod.email)
                MaterialPage(
                  child: EmailForm(),
                )
            ],
            onPopPage: (route, result) {
              _selectedMethod = SignInMethod.none;
              return route.didPop(result);
            },
          );
        } else if (auth.loginState == ApplicationLoginState.loggedIn) {
          return Welcome();
        } else {
          return Container(
            child: Text('Boy!'),
          );
        }
      },
    );
  }
}
