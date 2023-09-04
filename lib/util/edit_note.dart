import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homework Tracker - Edit'),
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
    );
  }
}
