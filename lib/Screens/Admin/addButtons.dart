import 'package:flutter/material.dart';
import 'package:cupadmin/Screens/Admin/add.dart';

class AddButtons extends StatelessWidget {
  final String labelText;
  final String addText;
  final Function onPressed;

  AddButtons(this.labelText, this.addText, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      child: RaisedButton(
        color: Color(0XFFecb063),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(
          addText,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
