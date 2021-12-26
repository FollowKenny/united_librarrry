import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/model/user.dart';
import 'package:united_library/providers/route.dart';
import 'package:united_library/screens/entry_screen.dart';
import 'package:united_library/screens/libraries_screen.dart';
import 'package:united_library/screens/library_screen.dart';
import 'package:united_library/screens/logged_out_screen.dart';
import 'package:united_library/screens/login_screen.dart';
import 'package:united_library/screens/register_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final RouteProvider _routeProvider;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate(this._routeProvider)
      : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppRoutePath get currentConfiguration {
    return _routeProvider.route;
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routeProvider.updateRoute(configuration);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(
      builder: (context, routeProvider, child) {
        return Navigator(
          key: navigatorKey,
          pages: [
            if (routeProvider.route.isUnknownPage)
              const MaterialPage(
                child: Scaffold(
                  body: Text('404 SIS/BRO/ETC!'),
                ),
              )
            else if (!routeProvider.isLoggedIn)
              const MaterialPage(
                key: ValueKey('loggedOut'),
                child: LoggedOut(),
              )
            else if (routeProvider.isLoggedIn)
              const MaterialPage(
                key: ValueKey('libraries'),
                child: Libraries(),
              ),
            if (routeProvider.route.isRegisterPage)
              const MaterialPage(
                key: ValueKey('register'),
                child: Register(),
              )
            else if (routeProvider.route.isLoginPage)
              const MaterialPage(
                key: ValueKey('login'),
                child: Login(),
              )
            else if (routeProvider.route.isLibraryPage)
              MaterialPage(
                key: const ValueKey('library'),
                child: LibraryScreen(uid: routeProvider.route.libraryUid!),
              ),
            if (routeProvider.route.isDetailsPage)
              const MaterialPage(
                key: ValueKey('details'),
                child: EntryScreen(),
              )
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }

            if (routeProvider.route.isDetailsPage) {
              routeProvider.updateRoute(
                AppRoutePath.library(routeProvider.route.libraryUid),
              );
            } else {
              routeProvider
                  .updateRoute(AppRoutePath.home(routeProvider.route.isLoggedIn));
            }

            notifyListeners();
            return true;
          },
        );
      },
    );
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  AppUser? user;

  AppRouteInformationParser({required this.user});

  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty ||
        uri.pathSegments[0] == 'auth' ||
        uri.pathSegments[0] == 'home') {
      return AppRoutePath.home(user != null);
    }

    if (user == null) {
      if (uri.pathSegments[0] == 'register') {
        return AppRoutePath.auth('register');
      }

      if (uri.pathSegments[0] == 'login') {
        return AppRoutePath.auth('login');
      }
    } else {
      if (uri.pathSegments.length == 2) {
        if (uri.pathSegments[0] == "library") {
          return AppRoutePath.library(uri.pathSegments[1]);
        }
      } else if (uri.pathSegments.length == 4) {
        if (uri.pathSegments[0] == "library" &&
            uri.pathSegments[2] == "entry") {
          return AppRoutePath.entry(uri.pathSegments[1], uri.pathSegments[3]);
        }
      }
    }
    // Handle unknown routes
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isRegisterPage) {
      return const RouteInformation(location: 'register');
    } else if (configuration.isLoginPage) {
      return const RouteInformation(location: 'login');
    } else if (configuration.isLoggedOutPage) {
      return const RouteInformation(location: 'auth');
    } else if (configuration.isLibrariesPage) {
      return const RouteInformation(location: 'home');
    } else if (configuration.isLibraryPage) {
      return RouteInformation(location: 'library/${configuration.libraryUid}');
    } else if (configuration.isDetailsPage) {
      return RouteInformation(
          location:
              'library/${configuration.libraryUid}/entry/${configuration.entryUid}');
    }
  }
}
