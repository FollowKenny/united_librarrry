import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:united_library/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    init();
  }

  AppUser? _user;
  AppUser? get user => _user;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _user = AppUser(
          uid: user.uid,
          email: user.email!,
        );
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email!,);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> registerAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email!,);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
