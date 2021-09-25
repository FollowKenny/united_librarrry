import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:united_library/services/auth.dart';
import 'package:united_library/services/app_name.dart';

enum SignInMethod {
  none,
  email,
}

class SignIn extends StatelessWidget {
  final ValueChanged didSelectMethod;

  const SignIn({Key? key, required this.didSelectMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppName.fullAppName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              buttonType: ButtonType.mail,
              onPressed: () {
                didSelectMethod(SignInMethod.email);
              },
            ),
            SizedBox(
              height: 10,
            ),
            SignInButton(
              buttonType: ButtonType.googleDark,
              onPressed: () {
                _showButtonPressDialog(context);
              },
            ),
            SizedBox(
              height: 10,
            ),
            SignInButton(
              buttonType: ButtonType.microsoft,
              onPressed: () {
                _showButtonPressDialog(context);
              },
              btnColor: Colors.deepPurple,
            ),
            SizedBox(
              height: 10,
            ),
            SignInButton(
              buttonType: ButtonType.appleDark,
              onPressed: () {
                _showButtonPressDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showButtonPressDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Incoming feature, try another sign in method. Sorry for the inconvenience!'),
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      duration: Duration(seconds: 3),
    ));
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
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
                SizedBox(
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
                SizedBox(
                  height: 20.0,
                ),
                Consumer<Auth>(
                  builder: (context, auth, child) {
                    return ButtonBar(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green.shade900),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              auth.signInWithEmailAndPassword(
                                email,
                                password,
                              );
                            }
                          },
                          child: Text(
                            'Sign in',
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green.shade900)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              auth.registerAccount(
                                email,
                                password,
                              );
                            }
                          },
                          child: Text(
                            'Sign up',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
