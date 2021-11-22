import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  final String uid;

  const Library({required this.uid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Library screen'),
    );
  }
}
