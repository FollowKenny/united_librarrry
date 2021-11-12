import 'package:flutter/material.dart';

class LoggedOut extends StatelessWidget {
  const LoggedOut({required this.selectAction, Key? key}) : super(key: key);

  final ValueChanged<String> selectAction;

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
                onPressed: () => selectAction('login'),
                child: const Text('LOG IN'),
              ),
              ElevatedButton(
                onPressed: () => selectAction('register'),
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
