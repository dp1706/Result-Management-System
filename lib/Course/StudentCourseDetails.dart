import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentCourseDetails extends StatefulWidget {
  @override
  _StudentCourseDetailsState createState() => _StudentCourseDetailsState();
}

class _StudentCourseDetailsState extends State<StudentCourseDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Course Detail" ,style: TextStyle(fontSize: 20,),),
      ),

     body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(bottom: 20),
              leading: Image.asset('images/book.png', height: 30,color: Colors.pinkAccent,),
              title: Center(
                child: Text(
                  "Course Details",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.4,

                ),
              ),
            ),
            Divider(thickness: 0.5,),

          ],
        ),
      ),
    );
  }
}
