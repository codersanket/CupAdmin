import 'package:flutter/material.dart';

class shortNotes extends StatelessWidget {
  const shortNotes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Short Notes")
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
      body: Container(),
    );
  }
}