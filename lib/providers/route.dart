import 'package:flutter/material.dart';
import 'package:united_library/model/path.dart';

class RouteProvider extends ChangeNotifier {
  RouteProvider({required this.isLoggedIn}) : _route = AppRoutePath.home(isLoggedIn);

  bool isLoggedIn;
  AppRoutePath get route => _route;
  AppRoutePath _route;


  updateRoute(AppRoutePath route) {
    _route = route;
    notifyListeners();
  }
}
