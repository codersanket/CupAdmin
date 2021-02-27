import 'package:cupadmin/Screens/Admin/add.dart';
import 'package:cupadmin/Screens/Admin/createUser.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children:[
            RaisedButton(
              onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add(label:"University")));
              },
              child: Text("Add University"),
            ),
              RaisedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add(label:"Semester")));
              },
              child: Text("Add Semester"),
            ), RaisedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add(label:"Subjects")));
              },
              child: Text("Add Subject"),
            ), RaisedButton(
              onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>add(label:"Course")));
              },
              child: Text("Add Course"),
            ),
            RaisedButton(onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>createUser()));
            },child: Text("Creat Users"),)
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}