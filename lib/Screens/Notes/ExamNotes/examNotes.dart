import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupadmin/Screens/Notes/addNotes.dart';
import 'package:cupadmin/Screens/pdfViewer.dart';
import 'package:cupadmin/Services/addFile.dart';
import 'package:flutter/material.dart';

class examNotes extends StatelessWidget {
  final String uniId;
  final String subjectId;
  final String semId;
  final String courseId;

  const examNotes({Key key, this.uniId, this.subjectId,this.courseId,this.semId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
          title: Text(
        "Add Exam Notes",
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => addFile(
                    path: "ExamNotes",
                    universityId: uniId,
                    subjectId: subjectId,
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0XFFecb063),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                "Exam Notes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("ExamNotes")
                    .where("universityId", isEqualTo: uniId)
                    .where("subjectId", isEqualTo: subjectId)
                    .snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snap.data.docs.isEmpty) {
                    return Center(child: Text("Add A Notes"));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 50),
                        itemCount: snap.data.docs.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => pdfViewer(
                                        url: snap.data.docs[i]["file"])));
                              },
                              child: GridTile(
                                  header: Container(
                                    padding: EdgeInsets.only(right: 10, top: 5),
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  footer: Container(
                                    height: 40,
                                    color: Colors.black.withOpacity(0.4),
                                    child: Center(
                                        child: Text(
                                      snap.data.docs[i]["topic"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        "https://www.myesr.org/sites/default/files/media-icons/generic/application-pdf.png"),
                                    placeholder: NetworkImage(
                                        "https://www.pngkey.com/png/detail/233-2332677_image-500580-placeholder-transparent.png"),
                                  )));
                        }),
                  );
                }),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      )),
    );
  }
}
