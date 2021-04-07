import 'dart:collection';

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';


class Previous_Sem_Result extends StatefulWidget{
  @override
  _Previous_Sem_Result createState()=>_Previous_Sem_Result();

}

class _Previous_Sem_Result extends State<Previous_Sem_Result>{


  LinkedHashMap<String,dynamic> map = new LinkedHashMap();
  List<Map<String,dynamic>> list = [];
  List<String> list3 = [];
  List<String> list4 = [];
  List<String> list5 = [];
  List<String> courses = [];
  String branch;
  var course_credit = {"AA":10,"AB":9,"BB":8,"BC":7,"CC":6,"CD":5,"DD":4,"F":0,"-":0};
  List<String> spi = ["-","-","-","-","-","-","-","-"];
  List<String> cpi = ["-","-","-","-","-","-","-","-"];
  int credit_sum = 0;
  int grades_sum = 0;
  int un_credit_sum = 0;
  int un_grade_sum = 0;
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

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list3.isNotEmpty)
                                SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                  child: Table(
                                    border: TableBorder.all(),
                                    defaultColumnWidth: FixedColumnWidth(120.0),
                                      children: [
                                        TableRow(children :[
                                          Text('SPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                                          Text('CPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                        ]),
                                          TableRow(children :[
                                            Text(spi[0],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                            Text(cpi[0],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                          ]),
                                      ]
                                  ),
                                ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),

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

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list4.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                              border: TableBorder.all(),
                              defaultColumnWidth: FixedColumnWidth(120.0),
                              children: [
                                TableRow(children :[
                                  Text('SPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                                  Text('CPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                                TableRow(children :[
                                  Text(spi[1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),

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

                      if(list5.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list5.isNotEmpty)
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
                                for(num i=0;i<list5.length;i+=4)
                                  TableRow(children :[
                                    Text(list5[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list5[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list5[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list5[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list5.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                              border: TableBorder.all(),
                              defaultColumnWidth: FixedColumnWidth(120.0),
                              children: [
                                TableRow(children :[
                                  Text('SPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                                  Text('CPI',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                                TableRow(children :[
                                  Text(spi[2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),

                      ),
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
         grades_sum=0;
         credit_sum = 0;
         for(int i=0;i<ds["Result"].length;i++){
           list3.add(ds["Result"][courses[i]]["Course_name"]);
           list3.add(ds["Result"][courses[i]]["Course_code"]);
           list3.add(ds["Result"][courses[i]]["Course_credit"]);
           list3.add(ds["Result"][courses[i]]["Course_grade"]);
           int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
           if(ds["Result"][courses[i]]["Course_code"].toString() != "GE101"){
             credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
             un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());

           }
           if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != null ){
           grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
           un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
           }
         }
         double calculation = grades_sum / credit_sum;
         double cal = un_grade_sum/ un_credit_sum;
         spi[0] = calculation.toStringAsFixed(2);
         cpi[0] = cal.toStringAsFixed(2);

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
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list4.add(ds["Result"][courses[i]]["Course_name"]);
          list4.add(ds["Result"][courses[i]]["Course_code"]);
          list4.add(ds["Result"][courses[i]]["Course_credit"]);
          list4.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(ds["Result"][courses[i]]["Course_code"].toString() != "GE101"){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
             un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          }
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != null ){
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[1] = calculation.toStringAsFixed(2);
        cpi[1] = cal.toStringAsFixed(2);
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
      list5.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list5.add(ds["Result"][courses[i]]["Course_name"]);
          list5.add(ds["Result"][courses[i]]["Course_code"]);
          list5.add(ds["Result"][courses[i]]["Course_credit"]);
          list5.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(ds["Result"][courses[i]]["Course_code"].toString() != "GE101"){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          }
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != null ){
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[2] = calculation.toStringAsFixed(2);
        cpi[2] = cal.toStringAsFixed(2);
      }
    }).catchError((e){
      print(e);
    });
  }
}
}
