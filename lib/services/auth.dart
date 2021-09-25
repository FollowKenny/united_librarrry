import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

class Auth extends ChangeNotifier {
  Auth() {
    init();
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedIn; //to change to retrieve login page
  ApplicationLoginState get loginState => _loginState;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loginState = ApplicationLoginState.loggedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void registerAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _loginState = ApplicationLoginState.loggedIn;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _loginState = ApplicationLoginState.loggedOut;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
