import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupadmin/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context,snap){
                if(snap.hasError){
                  print("Error Occured");
              }
              if(snap.connectionState==ConnectionState.done){
                
                return Wrapper();
              }
              return Center(child:CircularProgressIndicator());
              },
      ),
    );
  }
}