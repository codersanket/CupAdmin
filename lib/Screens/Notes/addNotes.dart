import 'package:cupadmin/Screens/Notes/ExamNotes/examNotes.dart';
import 'package:cupadmin/Screens/Notes/ShortNotes/shortNotes.dart';
import 'package:cupadmin/Screens/addUniversity.dart';
import 'package:flutter/material.dart';

class addNotes extends StatelessWidget {
  final String subject;
  final String university;

  const addNotes({Key key, this.subject, this.university}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(subject);
    print(university);

    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Short Note",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(child: Container()),
              ListTile(
                title: Text("Add University"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => addUniversity()));
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            child: OutlineButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => shortNotes()));
              },
              borderSide: BorderSide(color: Colors.black, width: 2),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Short Notes",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.add),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            child: OutlineButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => examNotes(
                      uniId: university,
                      subjectId: subject,
                    ),
                  ),
                );
              },
              borderSide: BorderSide(color: Colors.black, width: 2),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Exam Notes",
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.add),
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
