import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:d_chart/d_chart.dart';
import 'package:homework_tracker/chartModel.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final UID = user.uid;

class ChartProgress extends StatefulWidget {
  const ChartProgress({Key? key}) : super(key: key);

  @override
  State<ChartProgress> createState() => _ChartProgressState();
}

class _ChartProgressState extends State<ChartProgress> {
  List <Map <String, dynamic>> chartData = [];
  late Future<ChartModel> data;

  int countNS = 0;
  int countIP = 0;
  int countDN = 0;

  //Get data from SQLyog via READ API
  Future getSubject() async {
    //String url = 'http://10.0.2.2/hwTracker/public/api/subject'; //android emulator
    String url = 'http://192.168.132.47/hwTracker/public/api/subject'; //real device (ip address changed based on tenet connection)

    var response = await http.get(Uri.parse(url));
    return (json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(
        title: Text('[ HWT ]              PROGRESS CHART'),
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

        body: FutureBuilder(
          future: getSubject(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (int i=0; i<snapshot.data['data'].length;i++) {
                if (UID == snapshot.data['data'][i]['user_id']) {
                  if (snapshot.data['data'][i]['sub_status'] == "Not Started") {
                    countNS++;
                  }
                  if (snapshot.data['data'][i]['sub_status'] == "In Progress") {
                    countIP++;
                  }
                  if (snapshot.data['data'][i]['sub_status'] == "Done") {
                    countDN++;
                  }
                }
              }
              return DChartPie(
                data: [
                  {'domain': 'Not Started', 'measure': countNS},
                  {'domain': 'In Progress', 'measure': countIP},
                  {'domain': 'Done', 'measure': countDN},
                ],
                fillColor: (pieData, index){
                  switch (pieData['domain']){
                    case 'Not Started':
                      return Colors.redAccent;
                    case 'In Progress':
                      return Colors.blueAccent;
                    default:
                      return Colors.green;
                  }
                },
                labelColor: Colors.black87,
                labelFontSize: 15,
                labelLinelength: 19.5,
                pieLabel: (Map<dynamic, dynamic> pieData, int? index){
                  return pieData['domain'] + ':\n' + pieData['measure'].toString();
                },
              );
            }else {
              return Text('Error: Data cannot be read from the database');
            }
            },
        )
    );
  }
}
