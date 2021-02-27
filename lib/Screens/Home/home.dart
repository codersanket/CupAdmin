import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupadmin/Screens/Notes/addNotes.dart';
import 'package:cupadmin/Screens/addUniversity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home extends StatelessWidget {
  TextEditingController _university = TextEditingController();
  TextEditingController _subject = TextEditingController();
  DocumentSnapshot Unisnapshot;
  DocumentSnapshot Subsnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcf3e8),
      appBar: AppBar(
        title: Text(
          "Short Note",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(child: Container()),
              ListTile(
                title: Text("Add University"),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => addUniversity()));
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                  title: Text("Sign Out"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  })
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onTap: () async {
                  Unisnapshot = await showSearch(
                      context: context, delegate: universitySearch());
                  if (Unisnapshot != null)
                    _university.text = Unisnapshot["name"] ?? "";
                },
                readOnly: true,
                controller: _university,
                decoration: InputDecoration(
                    labelText: "University",
                    contentPadding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), 
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onTap: () async {
                  Subsnapshot = await showSearch(
                      context: context, delegate: subjectSerach());
                  if (Subsnapshot != null)
                    _subject.text = Subsnapshot["name"] ?? "";
                },
                controller: _subject,
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Subject",
                    contentPadding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), 
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_university.text.isNotEmpty || _subject.text.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addNotes(
                                  university: Unisnapshot["id"],
                                  subject: Subsnapshot["id"],
                                )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Complete All Fields"),
                      duration: Duration(milliseconds: 500),
                    ));
                  }
                },
               color: Color(0XFFecb063),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Next",
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

class subjectSerach extends SearchDelegate<DocumentSnapshot> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Subjects")
            .where("name", isEqualTo: query)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          return ListView.builder(
            itemCount: snap.data.docs.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(snap.data.docs[i]["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Subjects")
            .where("name", isLessThanOrEqualTo: query)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          return ListView.builder(
            itemCount: snap.data.docs.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(snap.data.docs[i]["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }
}

class universitySearch extends SearchDelegate<DocumentSnapshot> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("University")
            .where("name", isLessThanOrEqualTo: query)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          return ListView.builder(
            itemCount: snap.data.docs.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(snap.data.docs[i]["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("University")
            .where("name", isLessThanOrEqualTo: query)
            .snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          return ListView.builder(
            itemCount: snap.data.docs.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(snap.data.docs[i]["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }
}
