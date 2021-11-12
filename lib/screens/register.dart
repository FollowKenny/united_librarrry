import 'package:flutter/material.dart';
import 'package:united_library/widgets/mail_auth.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MailAuth(action: 'register');
  }
}
