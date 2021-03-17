import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class add extends StatelessWidget {
  final String label;
  TextEditingController textEditingController = TextEditingController();
  add({Key key, this.label}) : super(key: key);
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      key: _key,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                labelText: label,
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
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 14),
                color: Color(0XFFecb063),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection("University")
                        .add({
                          "name": textEditingController.text,
                        })
                        .then((value) => value.update({"id": value.id}))
                        .then(
                            (value) => _key.currentState.showSnackBar(SnackBar(
                                  content: Text("Added"),
                                )));
                  } on FirebaseException catch (e) {
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text(e.message),
                    ));
                  }
                })
          ]),
        ),
      ),
    );
  }
}
