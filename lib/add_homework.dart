import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_tracker/screen/home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AddHomework extends StatefulWidget {
  const AddHomework({Key? key}) : super(key: key);

  @override
  State<AddHomework> createState() => _AddHomeworkState();
}

class _AddHomeworkState extends State<AddHomework> {

  //text controller
  TextEditingController  _titleController = TextEditingController();
  TextEditingController  _descriptionController = TextEditingController();

  //Post data from SQLyog via CREATE API
  Future saveSubject() async {
    //String url = 'http://10.0.2.2/hwTracker/public/api/subject'; //android emulator
    String url = 'http://192.168.132.47/hwTracker/public/api/subject';//real device

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final UID = user.uid;

    var response = await http.post(Uri.parse(url),body: {
      "sub_name":_titleController.text,
      "sub_details":_descriptionController.text,
      "sub_status":_currentStatus,
      "user_id":UID.toString(),
    });
    return(json.decode(response.body));
  }

  final status = ['Not Started', 'In Progress', 'Done'];
  String? _currentStatus = 'Not Started';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('[ HWT ]             ADD NEW SUBJECT'),
        //elevation: 0,
        backgroundColor: Color(0xFF355070),
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
      //Title text field
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFDFBF1),
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //Description text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFDFBF1),
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            constraints: BoxConstraints.tightFor(width: 400, height: 100),
                            border: InputBorder.none,
                            hintText: 'Desciption',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),

                  //Status text field
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 360.0,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFDFBF1),
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton(
                        hint: Text("Status: "),
                        dropdownColor: Color(0xFFFDFBF1),
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14.5,
                        ),
                        value: _currentStatus,
                        onChanged: (val) => setState(() => _currentStatus = val),
                        items: status.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text('$status '),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //Button 'Add'
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          saveSubject();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(360, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color(0xFF355070)),
                      child: Text(
                        'ADD' ,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
          )
      ),

    );
  }
}
