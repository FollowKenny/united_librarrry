import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/providers/route.dart';

class LoggedOut extends StatelessWidget {
  const LoggedOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/splash.png'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Provider.of<RouteProvider>(context, listen: false).updateRoute(AppRoutePath.auth('login')),
                child: const Text('LOG IN'),
              ),
              ElevatedButton(
                onPressed: () => Provider.of<RouteProvider>(context, listen: false).updateRoute(AppRoutePath.auth('register')),
                child: const Text('REGISTER'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary,
                  onPrimary: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
