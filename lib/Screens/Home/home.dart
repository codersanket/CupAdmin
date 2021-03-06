import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupadmin/Screens/Notes/addNotes.dart';
import 'package:cupadmin/Screens/addUniversity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Admin/admin.dart';

class home extends StatelessWidget {
  TextEditingController _university = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _sem = TextEditingController();
  TextEditingController _course = TextEditingController();
  DocumentSnapshot Unisnapshot;
  DocumentSnapshot Subsnapshot;
  DocumentSnapshot CourseSnapShot;
  DocumentSnapshot semesterSnapshot;
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
              child: Column(children: [
        Card(
          child: ListTile(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .get()
                    .then((value) {
                  if (value.data()["role"] == 'admin') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AdminHome()));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("You Don't Have a Permission"),
                    ));
                  }
                });
              },
              title: Text("Admin"),
              trailing: Icon(Icons.arrow_forward_ios)),
        ),
        Card(
          child: ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ),
      ]))),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
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
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
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
                      CourseSnapShot = await showSearch(
                          context: context,
                          delegate: courseSerach(Unisnapshot.data()["id"]));
                      if (CourseSnapShot != null)
                        _course.text = CourseSnapShot["name"] ?? "";
                    },
                    controller: _course,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Course",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
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
                      semesterSnapshot = await showSearch(
                          context: context,
                          delegate: semesterSerach(Unisnapshot.data()["id"],
                              CourseSnapShot.data()["id"]));
                      if (semesterSnapshot != null)
                        _sem.text = semesterSnapshot["name"] ?? "";
                    },
                    controller: _sem,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Semester",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
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
                          context: context,
                          delegate: subjectSerach(
                              Unisnapshot.data()["id"],
                              CourseSnapShot.data()["id"],
                              semesterSnapshot.data()["id"]));
                      if (Subsnapshot != null)
                        _subject.text = Subsnapshot["name"] ?? "";
                    },
                    controller: _subject,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: "Subject",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
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
                      if (_university.text.isNotEmpty ||
                          _subject.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addNotes(
                                      university: Unisnapshot["id"],
                                      subject: Subsnapshot["id"],
                                      course: CourseSnapShot["id"],
                                      semester: semesterSnapshot["id"],
                                    )));
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("Complete All Fields"),
                        //   duration: Duration(milliseconds: 500),
                        // ));
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
        ),
      ),
    );
  }
}

class subjectSerach extends SearchDelegate<DocumentSnapshot> {
  final String university;
  final String course;
  final String sem;

  subjectSerach(this.university, this.course, this.sem);
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
            .where("uniId", isEqualTo: university)
            .where("courseId", isEqualTo: course)
            .where("semId", isEqualTo: sem)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
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
            .where("uniId", isEqualTo: university)
            .where("courseId", isEqualTo: course)
            .where("semId", isEqualTo: sem)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
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
        stream: FirebaseFirestore.instance.collection("University").snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("University").snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }
}

class semesterSerach extends SearchDelegate<DocumentSnapshot> {
  final String uniId;
  final String course;

  semesterSerach(this.uniId, this.course);
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
            .collection("Semester")
            .where("uniId", isEqualTo: uniId)
            .where("courseId", isEqualTo: course)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
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
            .collection("Semester")
            .where("uniId", isEqualTo: uniId)
            .where("courseId", isEqualTo: course)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No Subject Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }
}

class courseSerach extends SearchDelegate<DocumentSnapshot> {
  final String uniId;

  courseSerach(this.uniId);
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
            .collection("Course")
            .where("uniId", isEqualTo: uniId)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
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
            .collection("Course")
            .where("uniId", isEqualTo: uniId)
            .snapshots(),
        builder: (context, snap) {
          List<DocumentSnapshot> list;
          if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.data.docs.isEmpty) {
            return Center(child: Text("No University Found"));
          }
          if (snap.hasData) {
            list = snap.data.docs
                .where((element) => element.data()["name"].startsWith(query))
                .toList();
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context, snap.data.docs[i]);
                },
                title: Text(list[i].data()["name"]),
                trailing: Icon(Icons.arrow_forward_ios),
              );
            },
          );
        });
  }
}
