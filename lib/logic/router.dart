import 'package:flutter/material.dart';
import 'package:united_library/model/path.dart';
import 'package:united_library/screens/libraries.dart';
import 'package:united_library/screens/library.dart';
import 'package:united_library/screens/logged_out.dart';
import 'package:united_library/screens/login.dart';
import 'package:united_library/screens/register.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  bool _isLoggedOut = true;
  String? _authAction;
  String? _libraryUid;
  bool _isUnknown = false;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppRoutePath get currentConfiguration {
    if (_isUnknown) {
      return AppRoutePath.unknown();
    }

    if (_isLoggedOut) {
      return _authAction == null
          ? AppRoutePath.loggedOut()
          : AppRoutePath.auth(_authAction);
    }

    return _libraryUid == null
        ? AppRoutePath.libraries()
        : AppRoutePath.library(_libraryUid);
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _isLoggedOut = !configuration.isLoggedIn;
    _isUnknown = configuration.isUnknown;
    _authAction = configuration.authAction;
    _isUnknown = configuration.isUnknown;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_isUnknown)
          const MaterialPage(
              child: Scaffold(
            body: Text('404 BRO!'),
          ))
        else if (_isLoggedOut)
          MaterialPage(
            key: const ValueKey('loggedOut'),
            child: LoggedOut(selectAction: _chooseAuthAction),
          )
        else
          const MaterialPage(
            key: ValueKey('libraries'),
            child: Libraries(),
          ),
        if (!_isUnknown && _isLoggedOut && _authAction == 'register')
          const MaterialPage(
            key: ValueKey('register'),
            child: Register(),
          )
        else if (!_isUnknown && _isLoggedOut && _authAction == 'login')
          const MaterialPage(
            key: ValueKey('login'),
            child: Login(),
          )
        else if (!_isUnknown && !_isLoggedOut && _libraryUid != null)
          MaterialPage(
            key: const ValueKey('library'),
            child: Library(uid: _libraryUid!),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (_isUnknown) {
          _isUnknown = false;
        }

        if (_isLoggedOut) {
          _authAction = null;
        } else {
          _libraryUid = null;
        }

        notifyListeners();
        return true;
      },
    );
  }

  _chooseAuthAction(String action) {
    _authAction = action;
    notifyListeners();
  }

  _chooseLibrary(String uid) {
    _libraryUid = uid;
    notifyListeners();
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.loggedOut();
    }

    if (uri.pathSegments[0] == 'auth') {     
      if (uri.pathSegments.length == 2) {
        if (uri.pathSegments[1] == 'login') {
          return AppRoutePath.auth('login');
        } else if (uri.pathSegments[1] == 'register') {
          return AppRoutePath.auth('register');
        }
      }
      return AppRoutePath.loggedOut();
    } 
    else if (uri.pathSegments[0] == 'libraries') {
      if (uri.pathSegments.length == 2) {
        return AppRoutePath.library(uri.pathSegments[1]);
      }
      return AppRoutePath.libraries();
    }

    // Handle unknown routes
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    if (!configuration.isLoggedIn) {
      if (configuration.authAction == 'register') {
        return const RouteInformation(location: '/auth/register');
      }
      else if (configuration.authAction == 'login') {
        return const RouteInformation(location: '/auth/login');
      }
      return const RouteInformation(location: '/auth');
    }
    if (configuration.libraryUid != null) {
      return RouteInformation(location: '/libraries/${configuration.libraryUid}');
    }
    return const RouteInformation(location: '/libraries');
  }
}
