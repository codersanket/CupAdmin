import 'package:cupadmin/Screens/Auth/login.dart';
import 'package:cupadmin/Screens/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snap){
          return !snap.hasData?Login():home();
        },
    );
  }
}