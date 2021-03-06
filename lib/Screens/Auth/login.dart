import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isLoading = false;

  Future login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).unfocus();
    try {
      await auth
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      _key.currentState.showSnackBar(SnackBar(content: Text(e.message),duration: Duration(seconds: 1),));
      setState(() {
        isLoading = false;
      });
     
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //drawer: Drawer(),
      key: _key,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    labelText: "Email",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10.0),
                    labelText: "Password",
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
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.08,
                  padding: const EdgeInsets.all(8.0),
                  child:isLoading?Center(child:CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )):MaterialButton(
                    height: 12,
                    onPressed: () => login(context),
                    color: Color(0XFFecb063),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child:  Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                  ),
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
