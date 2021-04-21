import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class TeacherDetails extends StatefulWidget {
  @override
  _TeacherDetailsState createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  List<String> list1 = [];
  List<String> list2 = [];
  List<String> list3 = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Teacher Detail" ,style: TextStyle(fontSize: 20,),),
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
                      leading: Image.asset('images/class.png', height: 30,color: Colors.pinkAccent,),
                      //alignment: Alignment(200,200),
                      title: Center(
                        child: Text(
                          "Teacher Details",
                          // textAlign: TextAlign.center,
                          textScaleFactor: 1.4,

                        ),
                      ),
                    ),
                    SizedBox(height:20.0),
                    ExpansionTile(
                        childrenPadding: EdgeInsets.only(top:10),
                        title: Text(
                          "CSE Stream",
                          style: TextStyle(
                              fontSize: 18.0,
                          ),
                        ),

                        children: <Widget>[
                          if(list1.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(list1.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("SR")),
                                  DataColumn(label: Text("Teacher ID")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Post")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0,j=1;i<list1.length;i+=4,j++)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(j.toString())),
                                        DataCell(Text(list1[i])),
                                        DataCell(Text(list1[i+1])),
                                        DataCell(Text(list1[i+2])),
                                        DataCell(Text(list1[i+3])),
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
                          "ECE Stream",
                          style: TextStyle(
                              fontSize: 18.0,
                          ),
                        ),

                        children: <Widget>[
                          if(list2.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(list2.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("SR")),
                                  DataColumn(label: Text("Teacher ID")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Post")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0,j=1;i<list2.length;i+=4,j++)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(j.toString())),
                                        DataCell(Text(list2[i])),
                                        DataCell(Text(list2[i+1])),
                                        DataCell(Text(list2[i+2])),
                                        DataCell(Text(list2[i+3])),
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
                          "HSS Stream",
                          style: TextStyle(
                              fontSize: 18.0,
                          ),
                        ),

                        children: <Widget>[
                          if(list3.isEmpty == true)
                            ListTile(
                              title: Text(
                                  'No data available'
                              ),
                            ),

                          if(list3.isNotEmpty == true)
                            SingleChildScrollView(// Op
                              scrollDirection: Axis.horizontal,// tional
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(label: Text("SR")),
                                  DataColumn(label: Text("Teacher ID")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Post")),

                                ],
                                rows: <DataRow>[
                                  for(int i=0,j=1;i<list3.length;i+=4,j++)
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(j.toString())),
                                        DataCell(Text(list3[i])),
                                        DataCell(Text(list3[i+1])),
                                        DataCell(Text(list3[i+2])),
                                        DataCell(Text(list3[i+3])),
                                      ],
                                    ),
                                ],),
                            ),
                        ]
                    ),
                    SizedBox(height:10.0),
                  ],
                ),
              );
            }
        ),
      ),

    );
  }

  _fetchcourseDetail() async{

    await Firestore.instance
          .collection('Student')
          .where("Role",isEqualTo: "teacher")
          .getDocuments()
          .then((value){
              list1.clear();
              list2.clear();
              list3.clear();
            value.documents.forEach((element) {
               if(element.data["Stream"] == "CSE"){
                 list1.add(element.data["Teacher ID"]);
                 list1.add(element.data["Name"]);
                 list1.add(element.data["Email"]);
                 list1.add(element.data["Post"]);
               }else if(element.data["Stream" == "ECE"]){
                 list2.add(element.data["Teacher ID"]);
                 list2.add(element.data["Name"]);
                 list2.add(element.data["Email"]);
                 list2.add(element.data["Post"]);
               }else if(element.data["Stream" == "HSS"]){
                 list3.add(element.data["Teacher ID"]);
                 list3.add(element.data["Name"]);
                 list3.add(element.data["Email"]);
                 list3.add(element.data["Post"]);
               }else{

               }
            });
      }).catchError((e){
        print(e);
      });
  }
}
