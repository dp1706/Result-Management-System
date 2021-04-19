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
  List<String> list6 = [];
  List<String> list7 = [];
  List<String> list8 = [];
  List<String> list9 = [];
  List<String> list10 = [];
  List<String> courses = [];
  String branch;
  var course_credit = {"AA":10,"AB":9,"BB":8,"BC":7,"CC":6,"CD":5,"DD":4,"F":0,"-":1,"PP":1,"NP":1};
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
                    //contentPadding: EdgeInsets.only(bottom: 20),
                    leading: Image.asset('images/notepad.png', height: 30,color: Colors.pinkAccent,),
                  title: Center(
                    child: Text(
                      "Result Summery",
                      //textAlign: TextAlign.center,
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

                      if(list6.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list6.isNotEmpty)
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
                                for(num i=0;i<list6.length;i+=4)
                                  TableRow(children :[
                                    Text(list6[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list6[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list6[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list6[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list6.isNotEmpty)
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
                                  Text(spi[3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                      "Semester 5",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[

                      if(list7.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list7.isNotEmpty)
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
                                for(num i=0;i<list7.length;i+=4)
                                  TableRow(children :[
                                    Text(list7[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list7[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list7[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list7[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list7.isNotEmpty)
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
                                  Text(spi[4],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[4],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                      "Semester 6",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[

                      if(list8.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list8.isNotEmpty)
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
                                for(num i=0;i<list8.length;i+=4)
                                  TableRow(children :[
                                    Text(list8[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list8[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list8[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list8[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list8.isNotEmpty)
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
                                  Text(spi[5],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[5],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                      "Semester 7",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[

                      if(list9.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list9.isNotEmpty)
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
                                for(num i=0;i<list9.length;i+=4)
                                  TableRow(children :[
                                    Text(list9[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list9[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list9[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list9[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list9.isNotEmpty)
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
                                  Text(spi[6],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[6],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                      "Semester 8",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    children: <Widget>[

                      if(list10.isEmpty)
                        ListTile(
                          title: Text(
                              'No data available'
                          ),
                        ),
                      if(list10.isNotEmpty)
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
                                for(num i=0;i<list10.length;i+=4)
                                  TableRow(children :[
                                    Text(list10[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list10[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list10[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                    Text(list10[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  ]),
                              ]
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),

                      ),

                      if(list10.isNotEmpty)
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
                                  Text(spi[7],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                  Text(cpi[7],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                ]),
                              ]
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
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

 Future _fetchresult1() async{
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
         for(int i=0;i<ds["Result"].length;i++) {
           list3.add(ds["Result"][courses[i]]["Course_name"]);
           list3.add(ds["Result"][courses[i]]["Course_code"]);
           list3.add(ds["Result"][courses[i]]["Course_credit"]);
           list3.add(ds["Result"][courses[i]]["Course_grade"]);
           int val = int.parse(
               ds["Result"][courses[i]]["Course_credit"].toString());
           if (course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1) {
             credit_sum = credit_sum + int.parse(
                 ds["Result"][courses[i]]["Course_credit"].toString());
             un_credit_sum = un_credit_sum + int.parse(
                 ds["Result"][courses[i]]["Course_credit"].toString());
           grades_sum = grades_sum + val * int.parse(
               course_credit[ds["Result"][courses[i]]["Course_grade"]]
                   .toString());
           un_grade_sum = un_grade_sum + val * int.parse(
               course_credit[ds["Result"][courses[i]]["Course_grade"]]
                   .toString());
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
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
             credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
             un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
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

    await Firestore.instance
        .collection('Student')
        .document(firebaseuser.uid)
        .collection('Sem 4')
        .document(firebaseuser.uid)
        .get()
        .then((ds){
      courses = List.from(ds["Result"].keys);
      list6.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list6.add(ds["Result"][courses[i]]["Course_name"]);
          list6.add(ds["Result"][courses[i]]["Course_code"]);
          list6.add(ds["Result"][courses[i]]["Course_credit"]);
          list6.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[3] = calculation.toStringAsFixed(2);
        cpi[3] = cal.toStringAsFixed(2);
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
      list7.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list7.add(ds["Result"][courses[i]]["Course_name"]);
          list7.add(ds["Result"][courses[i]]["Course_code"]);
          list7.add(ds["Result"][courses[i]]["Course_credit"]);
          list7.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[4] = calculation.toStringAsFixed(2);
        cpi[4] = cal.toStringAsFixed(2);
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
      list8.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list8.add(ds["Result"][courses[i]]["Course_name"]);
          list8.add(ds["Result"][courses[i]]["Course_code"]);
          list8.add(ds["Result"][courses[i]]["Course_credit"]);
          list8.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[5] = calculation.toStringAsFixed(2);
        cpi[5] = cal.toStringAsFixed(2);
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
      list9.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list9.add(ds["Result"][courses[i]]["Course_name"]);
          list9.add(ds["Result"][courses[i]]["Course_code"]);
          list9.add(ds["Result"][courses[i]]["Course_credit"]);
          list9.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[6] = calculation.toStringAsFixed(2);
        cpi[6] = cal.toStringAsFixed(2);
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
      list10.clear();
      grades_sum=0;
      credit_sum = 0;
      if(courses.length != null) {
        for (int i = 0; i < ds["Result"].length; i++) {
          list10.add(ds["Result"][courses[i]]["Course_name"]);
          list10.add(ds["Result"][courses[i]]["Course_code"]);
          list10.add(ds["Result"][courses[i]]["Course_credit"]);
          list10.add(ds["Result"][courses[i]]["Course_grade"]);
          int val = int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
          if(course_credit[ds["Result"][courses[i]]["Course_grade"]] != 1){
            credit_sum = credit_sum + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            un_credit_sum = un_credit_sum  + int.parse(ds["Result"][courses[i]]["Course_credit"].toString());
            grades_sum = grades_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
            un_grade_sum = un_grade_sum + val * int.parse(course_credit[ds["Result"][courses[i]]["Course_grade"]].toString());
          }
        }
        double calculation = grades_sum / credit_sum;
        double cal = un_grade_sum/ un_credit_sum;
        spi[7] = calculation.toStringAsFixed(2);
        cpi[7] = cal.toStringAsFixed(2);
      }
    }).catchError((e){
      print(e);
    });
  }
}
}
