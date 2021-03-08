import 'package:cupadmin/Screens/Notes/ExamNotes/examNotes.dart';
import 'package:cupadmin/Screens/Notes/ShortNotes/shortNotes.dart';
import 'package:cupadmin/Screens/addUniversity.dart';
import 'package:flutter/material.dart';

class addNotes extends StatelessWidget {
  final String subject;
  final String university;
  final String semester;
  final String course;

  const addNotes({Key key, this.subject, this.university,this.course,this.semester}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Short Note",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // drawer: Drawer(
      //   child: SafeArea(
      //     child: Column(
      //       children: [
      //         DrawerHeader(child: Container()),
      //         ListTile(
      //           title: Text("Add University"),
      //           onTap: () {
      //             Navigator.of(context).push(
      //                 MaterialPageRoute(builder: (context) => addUniversity()));
      //           },
      //           trailing: Icon(Icons.arrow_forward_ios),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            child: OutlineButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => shortNotes(
                       uniId: university,
                      subjectId: subject,
                      semId:semester,
                      courseId:course
                    )));
              },
              borderSide: BorderSide(color: Color(0xFFe9a54d), width: 2),
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Text(
                    "Short Notes",
                    style: TextStyle(fontSize: 16,color: Colors.grey),
                  ),
                  Icon(Icons.add,color: Color(0xFFe9a54d),),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            child: OutlineButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => examNotes(
                      uniId: university,
                      subjectId: subject,
                      semId:semester,
                      courseId:course
                    ),
                  ),
                );
              },
              borderSide: BorderSide(color: Color(0xFFe9a54d), width: 2),
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Text(
                    "Exam Notes",
                    style: TextStyle(fontSize: 16,color: Colors.grey),
                  ),
                  Icon(Icons.add,color: Color(0xFFe9a54d),),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
