import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class StudentCourseDetails extends StatefulWidget {
  @override
  _StudentCourseDetailsState createState() => _StudentCourseDetailsState();
}

class _StudentCourseDetailsState extends State<StudentCourseDetails> {
  List<String> course1 = [];
  List<String> course2 = [];
  List<String> course3 = [];
  List<String> course4 = [];
  List<String> course5 = [];
  List<String> course6 = [];
  List<String> course7 = [];
  List<String> course8 = [];
  List<String> courses = [];

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
                // return Center(child:Text("Loading data..."),);
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
                      //contentPadding: EdgeInsets.only(bottom: 20),
                      leading: Image.asset('images/book.png', height: 30,color: Colors.pinkAccent,),
                          //alignment: Alignment(200,200),
                      title: Center(
                        child: Text(
                          "Course Details",
                         // textAlign: TextAlign.center,
                          textScaleFactor: 1.4,

                        ),
                      ),
                    ),

                    ExpansionTile(
                      childrenPadding: EdgeInsets.only(top:10),
                      title: Text(
                        "Semester 1",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      children: <Widget>[
                        if(course1.isEmpty == true)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),

                        if(course1.isNotEmpty == true)
                          SingleChildScrollView(// Op
                            scrollDirection: Axis.horizontal,// tional
                            child: DataTable(
                              columns: <DataColumn>[
                                DataColumn(label: Text("Course Code")),
                                DataColumn(label: Text("Course Name")),
                                DataColumn(label: Text("Course Credit")),

                              ],
                              rows: <DataRow>[
                                for(int i=0;i<course1.length;i+=3)
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(course1[i])),
                                      DataCell(Text(course1[i+1])),
                                      DataCell(Text(course1[i+2])),
                                    ],
                                  ),
                              ],),
                          ),
                      ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 2",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course2.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course2.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course2.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course2[i])),
                                        DataCell(Text(course2[i+1])),
                                        DataCell(Text(course2[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 3",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course3.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course3.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course3.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course3[i])),
                                        DataCell(Text(course3[i+1])),
                                        DataCell(Text(course3[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 4",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course4.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course4.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course4.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course4[i])),
                                        DataCell(Text(course4[i+1])),
                                        DataCell(Text(course4[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 5",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course5.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course5.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course5.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course5[i])),
                                        DataCell(Text(course5[i+1])),
                                        DataCell(Text(course5[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 6",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course6.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course6.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course6.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course6[i])),
                                        DataCell(Text(course6[i+1])),
                                        DataCell(Text(course6[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 7",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course7.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course7.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course7.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course7[i])),
                                        DataCell(Text(course7[i+1])),
                                        DataCell(Text(course7[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "Semester 8",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        children: <Widget>[
                          if(course8.isEmpty)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(course8.isNotEmpty)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("Course Code")),
                                  DataColumn(label: Text("Course Name")),
                                  DataColumn(label: Text("Course Credit")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0;i<course8.length;i+=3)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(course8[i])),
                                        DataCell(Text(course8[i+1])),
                                        DataCell(Text(course8[i+2])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                  ],
                ),
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
          .collection('Sem 1')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course1.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course1.add(ds["Result"][courses[i]]["Course_code"]);
          course1.add(ds["Result"][courses[i]]["Course_name"]);
          course1.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });

      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 2')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course2.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course2.add(ds["Result"][courses[i]]["Course_code"]);
          course2.add(ds["Result"][courses[i]]["Course_name"]);
          course2.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });

      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 3')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course3.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course3.add(ds["Result"][courses[i]]["Course_code"]);
          course3.add(ds["Result"][courses[i]]["Course_name"]);
          course3.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 4')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course4.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course4.add(ds["Result"][courses[i]]["Course_code"]);
          course4.add(ds["Result"][courses[i]]["Course_name"]);
          course4.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 5')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course5.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course5.add(ds["Result"][courses[i]]["Course_code"]);
          course5.add(ds["Result"][courses[i]]["Course_name"]);
          course5.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 6')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course6.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course6.add(ds["Result"][courses[i]]["Course_code"]);
          course6.add(ds["Result"][courses[i]]["Course_name"]);
          course6.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 7')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course7.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course7.add(ds["Result"][courses[i]]["Course_code"]);
          course7.add(ds["Result"][courses[i]]["Course_name"]);
          course7.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .collection('Sem 8')
          .document(firebaseuser.uid)
          .get()
          .then((ds){

        courses = List.from(ds["Result"].keys);
        course8.clear();
        for(int i=0;i<ds["Result"].length;i++){
          course8.add(ds["Result"][courses[i]]["Course_code"]);
          course8.add(ds["Result"][courses[i]]["Course_name"]);
          course8.add(ds["Result"][courses[i]]["Course_credit"]);
        }
      }).catchError((e){
        print(e);
      });
    }
  }
}
