
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_tracker/update_homework.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final UID = user.uid;

class HomeworkList extends StatefulWidget {
  const HomeworkList({Key? key}) : super(key: key);

  @override
  State<HomeworkList> createState() => _HomeworkListState();
}

class _HomeworkListState extends State<HomeworkList> {

  //Get data from SQLyog via READ API
  Future getSubject() async {
    //String url = 'http://10.0.2.2/hwTracker/public/api/subject'; //android emulator
    String url = 'http://192.168.132.47/hwTracker/public/api/subject'; //real device

    var response = await http.get(Uri.parse(url));
    return (json.decode(response.body));
  }

  //Delete data from SQLyog via DESTROY API
  Future deleteSubject(String subjectId) async {
    //String url = 'http://10.0.2.2/hwTracker/public/api/subject/' + subjectId; //android emulator
    String url = 'http://192.168.132.47/hwTracker/public/api/subject/' + subjectId; //real device

    var response = await http.delete(Uri.parse(url));
    return (json.decode(response.body));
  }

  void refresh(){
    setState(() {
    });
  }

  final statuss = ['Done', 'In Progress', 'Not Started'];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    getSubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
        appBar: AppBar(
          title: Text('[ HWT ]                    HOMEPAGE'),
          //elevation: 0,
          backgroundColor: Color(0xFF355070),
          actions: <Widget>[
            IconButton(onPressed: refresh, icon: Icon(Icons.refresh)),
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: getSubject(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (context, index) {
                    if (UID == snapshot.data['data'][index]['user_id']) {
                      return GestureDetector(
                        child: SingleChildScrollView(
                          child: Card(
                            color: Color(0xFFFDFBF1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data['data'][index]['sub_name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Color(0xFF355070),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        child: Text(
                                          "Status: " + snapshot.data['data'][index]['sub_status'],
                                          maxLines: 3,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blueGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialogFunc(
                                            context,
                                            snapshot.data['data'][index]['sub_name'],
                                            snapshot.data['data'][index]['sub_details'],
                                            snapshot.data['data'][index]['sub_status']);
                                      },
                                      icon: Icon(Icons.remove_red_eye,  color: Colors.blueAccent),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                                            EditHomework(subject: snapshot.data['data'][index])
                                        ));
                                      },
                                      icon: Icon(Icons.edit_rounded, color: Colors.green),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteSubject(snapshot.data['data'][index]['id'].toString());
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("Deleted successfully!"),
                                        ));

                                      },
                                      icon: Icon(Icons.delete_rounded, color: Colors.redAccent),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else {
                      return SizedBox(height: 0,);
                    }
                  });
            } else {
              return Text('Error: Data cannot be read from the database');
            }
          },
        ));
  }

  showDialogFunc(context, homework, decs, status) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFDFBF1),
                ),
                padding: EdgeInsets.all(15),
                //height: 120,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      homework,
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF355070),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Details: \n" + decs,
                            maxLines: null,
                            style: TextStyle(fontSize: 15, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

}