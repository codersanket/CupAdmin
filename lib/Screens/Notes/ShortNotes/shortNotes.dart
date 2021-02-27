import 'package:flutter/material.dart';

class shortNotes extends StatelessWidget {
  const shortNotes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Add Short Notes",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Color(0XFFecb063),
      ),
      body: Container(),
    );
  }
}
