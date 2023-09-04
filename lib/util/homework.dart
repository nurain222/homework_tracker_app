import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homework extends StatefulWidget {
  const Homework({Key? key}) : super(key: key);

  @override
  State<Homework> createState() => _HomeworkState();
}

List<String> list = [
  'CSP600',
  'CSP650',
  'ENT600',
  'ITT650',
  'CTU120',
];

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf7f7f1),
      appBar: AppBar(
        title: Text('Homework Tracker'),
        //elevation: 0,
        backgroundColor: Color(0xFF7C9CA2),
        actions: <Widget>[
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
      body: Container(
          color: Color(0xFFf7f7f1),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, pos) {
                return Card(
                    color: Colors.black87,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            list[pos],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    size: 15.0,
                                    //color: Colors.black,
                                  ),
                                  onPressed: (){}
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit_rounded,
                                    size: 15.0,
                                    //color: Colors.black,
                                  ),
                                  onPressed: (){}
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 15.0,
                                    //color: Colors.black,
                                  ),
                                  onPressed: (){}
                              ),
                            ],
                          ),
                        )
                    )
                );
              }),
        ),
    );
  }
}
