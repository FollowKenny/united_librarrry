import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/providers/user.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Image.asset('assets/splash.png'),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('My profile'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () => userProvider.signOut(),
              ),
            ],
          ),
        );
      },
    );
  }
}
