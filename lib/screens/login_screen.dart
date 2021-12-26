import 'package:flutter/material.dart';
import 'package:united_library/widgets/mail_auth.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MailAuth(action: 'log in',);
  }
}
