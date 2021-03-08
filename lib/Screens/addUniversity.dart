import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addUniversity extends StatefulWidget {
  @override
  _addUniversityState createState() => _addUniversityState();
}

class _addUniversityState extends State<addUniversity> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  add(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    FocusScope.of(context).unfocus();

    try {
      _firestore
          .collection("University")
          .add({"name": controller.text.trim()}).then((value) {
        value.update({"id": value.id});
      });

      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Sanket" + e.message);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(e.message),
      // ));
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Add University",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    labelText: "University Name",
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
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.08,
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    // content: Text("Field is Empty"),
                    // )
                    // );
                  } else {
                    add(context);
                  }
                },
                color: Color(0XFFecb063),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Add University",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
