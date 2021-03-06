import 'package:cupadmin/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  const PrimaryColor = const Color(0xFFe9a54d);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snap) {
          if (snap.hasError) {
            print("Error Occured");
          }
          if (snap.connectionState == ConnectionState.done) {
            return Wrapper();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
