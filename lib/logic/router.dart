import 'package:flutter/material.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/model/user.dart';
import 'package:united_library/screens/libraries.dart';
import 'package:united_library/screens/library.dart';
import 'package:united_library/screens/logged_out.dart';
import 'package:united_library/screens/login.dart';
import 'package:united_library/screens/register.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  AppRoutePath _routeState;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate(this._routeState)
      : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppRoutePath get currentConfiguration {
    return _routeState;
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routeState = configuration;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_routeState.isUnknownPage)
          const MaterialPage(
            child: Scaffold(
              body: Text('404 SIS/BRO/ETC!'),
            ),
          )
        else if (_routeState.isLoggedOutStack)
          MaterialPage(
            key: const ValueKey('loggedOut'),
            child: LoggedOut(selectAction: _chooseAuthAction),
          )
        else if (!_routeState.isLoggedOutStack)
          const MaterialPage(
            key: ValueKey('libraries'),
            child: Libraries(),
          ),
        if (_routeState.isRegisterPage)
          const MaterialPage(
            key: ValueKey('register'),
            child: Register(),
          )
        else if (_routeState.isLoginPage)
          const MaterialPage(
            key: ValueKey('login'),
            child: Login(),
          )
        else if (_routeState.isLibraryPage)
          MaterialPage(
            key: const ValueKey('library'),
            child: Library(uid: _routeState.libraryUid!),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _routeState = AppRoutePath.home(_routeState.isLoggedIn);

        notifyListeners();
        return true;
      },
    );
  }

  _chooseAuthAction(String action) {
    _routeState = AppRoutePath.auth(action);
    notifyListeners();
  }

  _chooseLibrary(String uid) {
    _routeState = AppRoutePath.library(uid);
    notifyListeners();
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
    }
  }
}
