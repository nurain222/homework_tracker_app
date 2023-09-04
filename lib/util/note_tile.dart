import 'package:flutter/material.dart';
import 'package:homework_tracker/util/edit_note.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
        padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFF7C9CA2),

          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              "Learn Flutter",
              style: TextStyle(
                  color: Colors.white,
                fontSize: 20,
              ),
            ),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: IconButton(
                onPressed: () {
                  //Navigator.push(context,
                      //MaterialPageRoute(builder: (context) => EditNote()));
                },
                icon: (Icon(Icons.edit_note_rounded)),
              ),
            ),
          ],
        ),
    ),
      );
  }
}
