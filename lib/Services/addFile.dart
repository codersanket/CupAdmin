import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addFile extends StatefulWidget {
  final String universityId;
  final String subjectId;
  final String path;
  final String courseId;
  final String semesterId;

  const addFile(
      {Key key,
      this.universityId,
      this.subjectId,
      this.path,
      this.courseId,
      this.semesterId})
      : super(key: key);
  @override
  _addFileState createState() => _addFileState();
}

class _addFileState extends State<addFile> {
  File pdfFile;
  String path = '';
  bool isLoading = false;

  selecteFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowCompression: true,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      path = result.files.single.path;
      pdfFile = File(result.files.single.path);
    }
    setState(() {});
  }

  addToStorage(BuildContext context) async {
    // print(widget.universityId);
    // print(widget.semesterId);
    // print(widget.courseId);
    // print(widget.subjectId);

    isLoading = true;
    setState(() {});
    if (path.isNotEmpty) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('uploads/${path.split('/').last}}');
      UploadTask upload = ref.putFile(pdfFile);
      await upload.whenComplete(() {
        ref.getDownloadURL().then((value) {
          FirebaseFirestore.instance.collection(widget.path).add({
            "universityId": widget.universityId,
            "subjectId": widget.subjectId,
            "courseId": widget.courseId,
            "semesterId": widget.semesterId,
            "file": value,
            "topic": topic.text.trim()
          });
        });

        isLoading = false;
        path = '';
        pdfFile = File('');
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("File Uploaded Sucessfully"),
        ));
      });
    }
  }

  TextEditingController topic = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Upload File",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: topic,
              decoration: InputDecoration(
                labelText: "Topic",
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color(0xFFe9a54d)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Color(0xFFe9a54d)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: TextField(
          //     controller: topic,
          //     decoration: InputDecoration(
          //       labelText: "Topic",
          //       contentPadding:
          //           new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //         borderSide: BorderSide(color: Color(0xFFe9a54d)),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //         borderSide: BorderSide(color: Color(0xFFe9a54d)),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          path.length == 0
              ? Container()
              : Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    path.split('/').last,
                    textAlign: TextAlign.center,
                  )),
          MaterialButton(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Color(0XFFecb063),
            onPressed: () {
              selecteFile();
            },
            child: Text(
              "Select File",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.7,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Color(0XFFecb063),
              onPressed: () {
                addToStorage(context);
              },
              child: isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text(
                      "Upload File",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
