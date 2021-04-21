import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class TeacherCourseDetails extends StatefulWidget {
  @override
  _TeacherCourseDetailsState createState() => _TeacherCourseDetailsState();
}

class _TeacherCourseDetailsState extends State<TeacherCourseDetails> {
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Course Detail" ,style: TextStyle(fontSize: 20,),),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Comment Icon',
                iconSize: 26,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                }),
          ]
      ),


      body: SingleChildScrollView(

        child: FutureBuilder(
            future: _fetchcourseDetail(),
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done)
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Column(
                        children: <Widget>[
                          CupertinoActivityIndicator(
                            radius:10,
                          ),
                          Text("Loading Data....",style:TextStyle(fontSize: 16)),
                        ]),
                  ),
                );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    children: <Widget>[
                      SizedBox(height:20.0),
                      ListTile(
                        contentPadding: EdgeInsets.only(bottom: 20),
                        leading: Image.asset('images/book.png', height: 30,color: Colors.pinkAccent,),
                        title: Center(
                          child: Text(
                            "Course Assigned",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.4,

                          ),
                        ),
                      ),
                      SingleChildScrollView(// Op
                        scrollDirection: Axis.horizontal,// tional
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(label: Text("SR No.")),
                            DataColumn(label: Text("Semester")),
                            DataColumn(label: Text("Course Code")),
                            DataColumn(label: Text("Course Name")),
                            DataColumn(label: Text("Course Credit")),
                            DataColumn(label: Text("Stream")),

                          ],
                          rows: <DataRow>[
                            for(int i=0,j=1;i<list.length;i+=5,j++)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(j.toString())),
                                  DataCell(Text(list[i])),
                                  DataCell(Text(list[i+1])),
                                  DataCell(Text(list[i+2])),
                                  DataCell(Text(list[i+3])),
                                  DataCell(Text(list[i+4])),
                                ],
                              ),
                          ],),
                      ),
                    ]),
              );
            }
        ),
      ),

    );
  }

  _fetchcourseDetail() async{
    final firebaseuser = await FirebaseAuth.instance.currentUser();

    if(firebaseuser!=null){
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .get()
          .then((ds){
        list.clear();
        for(num i=0;i<ds.data['Course'].length;i++) {
            list.add(ds.data['Course'][i]["Semester"]);
            list.add(ds.data['Course'][i]["Course_code"]);
            list.add(ds.data['Course'][i]["Name"]);
            list.add(ds.data['Course'][i]["Credit"]);
            list.add(ds.data['Course'][i]["Stream"]);
        }
      }).catchError((e){
        print(e);
      });
    }
  }
}
