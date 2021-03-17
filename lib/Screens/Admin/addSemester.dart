import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addSemester extends StatefulWidget {
  @override
  _addSemesterState createState() => _addSemesterState();
}

class _addSemesterState extends State<addSemester> {
  String uniId;
  String courseId;
  String value;
  String secondValue;

  TextEditingController textEditingController = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: dropDown(),
          ),
          if (value != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: courseDropDown(),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                labelText: "Add Semester",
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
                      .collection("Semester")
                      .add({
                        "name": textEditingController.text,
                        "uniId": uniId,
                        "courseId": courseId
                      })
                      .then((value) => value.update({"id": value.id}))
                      .then((value) => _key.currentState.showSnackBar(SnackBar(
                            content: Text("Added"),
                          )));
                } on FirebaseException catch (e) {
                  _key.currentState.showSnackBar(SnackBar(
                    content: Text(e.message),
                    duration: Duration(seconds: 1),
                  ));
                  Navigator.pop(context);
                }
              })
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget dropDown() => StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("University").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFf7ddbc), width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            hint: Text(
              "Selcect University",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            dropdownColor: Colors.white,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Color(0xFFe79a37),
            ),
            iconSize: 25,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: Colors.grey, fontSize: 16),
            value: value,
            onChanged: (newValue) {
              var temp = snapshot.data.docs
                  .singleWhere((element) => element.data()["name"] == newValue);
              uniId = temp.data()["id"];
              setState(() {
                value = newValue;
              });
            },
            items:
                snapshot.data.docs.map<DropdownMenuItem<String>>((valueItem) {
              return DropdownMenuItem(
                  value: valueItem.data()["name"],
                  child: Text(valueItem.data()["name"]));
            }).toList(),
          ),
        );
      });

  Widget courseDropDown() => StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Course")
          .where("uniId", isEqualTo: uniId)
          .snapshots(),
      builder: (context, snapshot) {
        print(value);
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFf7ddbc), width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            hint: Text(
              "Selcect Course",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            dropdownColor: Colors.white,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Color(0xFFe79a37),
            ),
            iconSize: 25,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: Colors.grey, fontSize: 16),
            value: secondValue,
            onChanged: (newValue) {
              var temp = snapshot.data.docs
                  .singleWhere((element) => element.data()["name"] == newValue);
              courseId = temp.data()["id"];
              setState(() {
                secondValue = newValue;
              });
            },
            items:
                snapshot.data.docs.map<DropdownMenuItem<String>>((valueItem) {
              return DropdownMenuItem(
                  value: valueItem.data()["name"],
                  child: Text(valueItem.data()["name"]));
            }).toList(),
          ),
        );
      });
}
