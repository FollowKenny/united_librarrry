import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:united_library/providers/user.dart';

class MailAuth extends StatefulWidget {
  const MailAuth({Key? key, required this.action}) : super(key: key);

  final String action;

  @override
  State<MailAuth> createState() => _MailAuthState();
}

class _MailAuthState extends State<MailAuth> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please ${widget.action}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image.asset('assets/splash.png'),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (val) => (val == '') ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      validator: (val) => (val!.length <= 6)
                          ? 'Enter a password (6 chars minimum)'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Consumer<UserProvider>(
                      builder: (context, user, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (widget.action == 'log in') {
                                user.signInWithEmailAndPassword(email,password,);
                              } else if (widget.action == 'register') {
                                user.registerAccount(email, password,);
                              }
                            }
                          },
                          child: Text(
                            widget.action,
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
