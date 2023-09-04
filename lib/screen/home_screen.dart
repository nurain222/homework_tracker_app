import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_tracker/add_homework.dart';
import 'package:homework_tracker/chart_progress.dart';
import 'package:homework_tracker/util/homework_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  int myIndex = 1;
  List<Widget> widgetList = const [
    ChartProgress(),
    HomeworkList(),
    AddHomework(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFBF1),
      body: IndexedStack(
        children: widgetList,
        index: myIndex,
      ),
     /* appBar: AppBar(
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
      ), */
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_rounded),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded),
              label: 'New Homework',
            ),
          ],
      ),

    );
  }
}

/*
Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ' + user.email! + ' !'),
            SizedBox(height: 10),
            MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              color: Colors.greenAccent,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
*/
