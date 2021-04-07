import 'dart:collection';

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Previous_Sem_Result extends StatefulWidget{
  @override
  _Previous_Sem_Result createState()=>_Previous_Sem_Result();

}

class _Previous_Sem_Result extends State<Previous_Sem_Result>{


  LinkedHashMap<String,dynamic> map = new LinkedHashMap();
  List<Map<String,dynamic>> list = [];
  List<String> list3 = [];
  List<String> list4 = [];
  List<String> courses = [];
  String branch;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Semester Result" ,style: TextStyle(fontSize: 20,),),
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
    ]),

      body: SingleChildScrollView(

        child: FutureBuilder(
          future: _fetchresult1(),
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
                    contentPadding: EdgeInsets.only(bottom: 20),
                    leading: Image.asset('images/notepad.png', height: 30,color: Colors.pinkAccent,),
                  title: Center(
                    child: Text(
                      "Result Summery",
                      textAlign: TextAlign.center,
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

                      if(list3.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list3.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,// tional
                       child: Table(
                            border: TableBorder.all(),
                           defaultColumnWidth: FixedColumnWidth(120.0),
                           children: [
                              TableRow(children :[
                                Text('Course Name',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                                Text('Course Code',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text('credit',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text('grade',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              ]),
                             for(num i=0;i<list3.length;i+=4)
                                 TableRow(children :[
                                  Text(list3[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(list3[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(list3[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                   Text(list3[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                 ]),
                            ]
                        ),
                     ),
                    ],
                  ),
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

                      if(list4.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list4.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,// tional
                          child: Table(
                              border: TableBorder.all(),
                              defaultColumnWidth: FixedColumnWidth(120.0),
                              children: [
                                TableRow(children :[
                                  Text('Course Name',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                                  Text('Course Code',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text('credit',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text('grade',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                                for(num i=0;i<list4.length;i+=4)
                                  TableRow(children :[
                                    Text(list4[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list4[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list4[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list4[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 3",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 4",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 5",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 6",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 7",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      "Semester 8",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            'No data available'
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),

    );
    //throw UnimplementedError();
  }

_fetchresult1() async{
  final firebaseuser = await FirebaseAuth.instance.currentUser();

  if(firebaseuser!=null){
    await Firestore.instance
        .collection('Student')
        .document(firebaseuser.uid)
        .get()
        .then((ds){
      branch = ds.data['Branch'];
    }).catchError((e){
      print(e);
    });

    await Firestore.instance
        .collection('Student')
        .document(firebaseuser.uid)
        .collection('Sem 1')
        .document(firebaseuser.uid)
        .get()
        .then((ds){
         courses = List.from(ds["Result"].keys);
         list3.clear();
         for(int i=0;i<ds["Result"].length;i++){
           list3.add(ds["Result"][courses[i]]["Course_name"]);
           list3.add(ds["Result"][courses[i]]["Course_code"]);
           list3.add(ds["Result"][courses[i]]["Course_credit"]);
           list3.add(ds["Result"][courses[i]]["Course_grade"]);
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
      list4.clear();
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list4.add(ds["Result"][courses[i]]["Course_name"]);
          list4.add(ds["Result"][courses[i]]["Course_code"]);
          list4.add(ds["Result"][courses[i]]["Course_credit"]);
          list4.add(ds["Result"][courses[i]]["Course_grade"]);
        }
      }
    }).catchError((e){
      print(e);
    });
  }
}
}
