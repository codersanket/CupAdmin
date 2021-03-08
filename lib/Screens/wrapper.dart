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

          if(snap.connectionState==ConnectionState.waiting){
            return Scaffold(
              backgroundColor: Color(0xFFfcf3e8),
              body: Center(child:CircularProgressIndicator()));
          }
          return AnimatedSwitcher(
            
            duration: Duration(milliseconds:250),
            switchInCurve: Curves.bounceIn,
            switchOutCurve: Curves.bounceInOut,
          child: !snap.hasData?Login():home());
        },
    );
  }
}