import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_tracker/screen/home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class EditHomework extends StatefulWidget {
  //const EditHomework({Key? key}) : super(key: key);

  final Map subject;

  EditHomework({required this.subject});

  @override
  State<EditHomework> createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {

  //text controller
  TextEditingController  _titleController = TextEditingController();
  TextEditingController  _descriptionController = TextEditingController();

  final status = ['Not Started', 'In Progress', 'Done'];
  String? _currentStatus = 'Not Started';

  //Update data from SQLyog via UPDATE API
  Future updateSubject() async {
    //String url = 'http://10.0.2.2/hwTracker/public/api/subject/' + widget.subject['id'].toString(); //android emulator
    String url = 'http://localhost/hwTracker/public/api/subject/' + widget.subject['id'].toString(); //real device

    var response = await http.put(Uri.parse(url),body: {
      "sub_name":_titleController.text,
      "sub_details":_descriptionController.text,
      "sub_status":_currentStatus,
    });
    return(json.decode(response.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('              UPDATE SUBJECT'),
        leading: IconButton(onPressed: (){Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen()));}, icon: Icon(Icons.arrow_back_rounded)),
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
                        color:Color(0xFFFDFBF1),
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _titleController..text = widget.subject['sub_name'],
                          decoration: InputDecoration(
                            border: InputBorder.none,
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
                          controller: _descriptionController..text = widget.subject['sub_details'],
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            constraints: BoxConstraints.tightFor(width: 400, height: 100),
                            border: InputBorder.none,
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
                           color: Colors.black,
                           fontSize: 15,
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

                  //Button 'Update'
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          updateSubject();
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
                        'UPDATE' ,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16
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