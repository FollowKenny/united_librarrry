import 'package:flutter/material.dart';
import 'package:united_library/flows/status.dart';
import 'package:united_library/services/app_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppName.fullAppName}',
      theme: ThemeData.dark(),
      home: Init(),
    );
  }
}

//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  runApp(MyApp());
//}
//
//class ULibInit extends StatefulWidget {
//  @override
//  _ULibState createState() => _ULibState();
//}
//
//class _ULibState extends State<ULibInit> {
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//  @override
//  Widget build(BuildContext context) {
//    return Directionality(textDirection: TextDirection.ltr,
//      child: FutureBuilder(
//        // Initialize FlutterFire:
//        future: _initialization,
//        builder: (context, snapshot) {
//          // Check for errors
//          if (snapshot.hasError) {
//            return SomethingWentWrong();
//          }
//    
//          // Once complete, show your application
//          if (snapshot.connectionState == ConnectionState.done) {
//            return ULib();
//          }
//    
//          // Otherwise, show something whilst waiting for initialization to complete
//          return Loading();
//        },
//      ),
//    );
//  }
//}
//
//class SomethingWentWrong extends StatelessWidget {
//  const SomethingWentWrong({Key? key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text('Oops we are sorry something went wrong. Try restarting.'),
//    );
//  }
//}
//
//class Loading extends StatelessWidget {
//  const Loading({Key? key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text('Get a cup of tea or something'),
//    );
//  }
//}
