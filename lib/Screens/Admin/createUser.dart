import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class createUser extends StatelessWidget {

  user(email,password)async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) => FirebaseFirestore.instance.collection("Users").doc(value.user.uid).set({
      "role":"Teacher"
    }));
    }on FirebaseAuthException catch(e){
      _key.currentState.showSnackBar(SnackBar(content: Text(e.message),));
    }
  }
  GlobalKey<ScaffoldState> _key=GlobalKey(); 
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(labelText: "Password"),
          ),
          RaisedButton(onPressed: ()=>user(_email.text.trim(), _password.text.trim()),child: Text("Add Teacher"),)
        ],
        
      ),
    );
  }
}