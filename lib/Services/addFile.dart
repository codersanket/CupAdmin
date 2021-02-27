import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addFile extends StatefulWidget {
  final String universityId;
  final String subjectId;
  final String path;

  const addFile({Key key, this.universityId, this.subjectId,this.path}) : super(key: key);
  @override
  _addFileState createState() => _addFileState();
}

class _addFileState extends State<addFile> {
  File pdfFile;
  String path='';
 bool isLoading=false;

  selecteFile()async{
    FilePickerResult result=await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowCompression: true,
      allowedExtensions: ['pdf'],);
      if(result!=null){
        path=result.files.single.path;
        pdfFile=File(result.files.single.path);
      }
      setState(() {
        
      });
    
  }

    addToStorage(BuildContext context)async{
      isLoading=true;
      if(path.isNotEmpty){
      Reference ref= FirebaseStorage.instance.ref().child('uploads/${path.split('/').last}}');
      UploadTask upload= ref.putFile(pdfFile);
       TaskSnapshot taskSnapshot = await upload.snapshot;
    taskSnapshot.ref.getDownloadURL().then(
          (value) {FirebaseFirestore.instance.collection(widget.path).add({
            "universityId":widget.universityId,
            "subjectId":widget.subjectId,
            "file":value,
            "topic":topic.text.trim()
          });

          isLoading=false;
          path='';
          pdfFile=File('');
          setState(() {});
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Uploaded Sucessfully"),));
          }
        );
        }
    }
    TextEditingController topic=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Upload File"),
      ),
      body: Column(
        children:[ 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: topic,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                labelText: "Topic"
              ),
              
            ),
          ),
                    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: topic,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                labelText: "Topic"
              ),
              
            ),
          ),
          
          path.length==0?Container():Container(
            padding: EdgeInsets.all(20),
            child: Text(path.split('/').last,textAlign: TextAlign.center,)),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(16)
            ),
            color: Colors.blue,
          onPressed: (){
            selecteFile();
          },
          child: Text("Select File",style: TextStyle(
                color:Colors.white,
                fontSize:14
              ),),
        ),
        SizedBox(height: 150,),
        Container(
          height: MediaQuery.of(context).size.height*0.08,
          width:MediaQuery.of(context).size.width*0.7 ,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(16)
            ),
            color: Colors.blue,
              onPressed: (){
                addToStorage(context);
              },
              child:isLoading?CircularProgressIndicator(backgroundColor: Colors.white,):Text("Upload File",style: TextStyle(
                color:Colors.white,
                fontSize:18
              ),),
            ),
        ),
        

        
        ],

        mainAxisAlignment: MainAxisAlignment.center,
        
      ),
    );
  }
}