import 'package:cupadmin/Screens/Admin/AddCourse.dart';
import 'package:cupadmin/Screens/Admin/add.dart';
import 'package:cupadmin/Screens/Admin/addSemester.dart';
import 'package:cupadmin/Screens/Admin/addSubject.dart';
import 'package:cupadmin/Screens/Admin/createUser.dart';
import 'package:flutter/material.dart';
import 'package:cupadmin/Screens/Admin/addButtons.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AddButtons("University", "Add University", () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (contex) => add()));
              }),
              SizedBox(
                height: 10,
              ),
              AddButtons("Course", "Add Course", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => AddCourse()));
              }),
              SizedBox(
                height: 10,
              ),
              AddButtons("Semester", "Add Semester", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => addSemester()));
              }),
              SizedBox(
                height: 10,
              ),
              AddButtons("Subjects", "Add Subjects", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => addSubject()));
              }),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: double.infinity,
                child: RaisedButton(
                  color: Color(0XFFecb063),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => createUser()));
                  },
                  child: Text(
                    "Creat Users",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
