import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class add extends StatelessWidget {
  final String label;
  TextEditingController textEditingController=TextEditingController();
   add({Key key, this.label}) : super(key: key);
   GlobalKey<ScaffoldState> _key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children:[
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: label
            ),
          ),
          RaisedButton(child: Text("Add"),onPressed:()async{
            try{
              await FirebaseFirestore.instance.collection(label).add({
                  "name":textEditingController.text,
                  
              }).then((value) => 
            
              value.update({
                "id":value.id
              })).then((value) =>_key.currentState.showSnackBar(SnackBar(content: Text("Added"),)));
            }on FirebaseException catch(e){
            _key.currentState.showSnackBar(SnackBar(content: Text(e.message),));
            }
          })
        ]
      ),
    );
  }
}