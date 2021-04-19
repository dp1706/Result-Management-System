import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../Auth/Database.dart';

class StudentDetailsScreen extends StatefulWidget {
  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  DatabaseManager database = DatabaseManager();
  final _key = GlobalKey<FormState>();
  TextEditingController _rollController = TextEditingController();
  TextEditingController _batchController = TextEditingController();

  File file;
  List<dynamic> list = [];
  List<dynamic> list1 = [];
  int j=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Student Details" ,style: TextStyle(fontSize: 20,),),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      height: 30,
                    ),

                    Text(
                      "Student Details",
                      style: TextStyle(fontSize: 22,color: Colors.pinkAccent),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _rollController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Roll number cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.list_alt,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Roll Number',
                          labelStyle: TextStyle(color: Colors.black54),),
                        style: TextStyle(color: Colors.black54),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Text("OR",
                      style: TextStyle(color: Colors.black,fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _batchController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Batch cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.list_alt,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Batch',
                          labelStyle: TextStyle(color: Colors.black54),),
                        style: TextStyle(color: Colors.black54),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    FlatButton(
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () async {
                        //  if (_key.currentState.validate()) {
                            bool val=false;
                           if(_rollController.text.isNotEmpty == true) {
                             await Firestore.instance
                                 .collection("Student")
                                 .where(
                                 "Roll Number", isEqualTo: _rollController.text)
                                 .getDocuments()
                                 .then((value) {
                               if (value.documents.isNotEmpty) {
                                 val = true;
                               }
                               list.clear();
                               value.documents.forEach((element) {
                                 setState(() {
                                   list.add(element.data["Roll Number"].toString());
                                   list.add(element.data["Name"].toString());
                                   list.add(element.data["Email"].toString());
                                   list.add(element.data["Branch"].toString());
                                   list.add(element.data["Course"].toString());
                                 });
                               });
                             });
                           }else if(_batchController.text.isNotEmpty == true){
                             await Firestore.instance
                                 .collection("Student")
                                 .where(
                                 "Batch", isEqualTo: _batchController.text)
                                 .getDocuments()
                                 .then((value) {
                               if (value.documents.isNotEmpty) {
                                 val = true;
                               }
                               list.clear();
                               value.documents.forEach((element) {
                                 setState(() {
                                   list.add(element.data["Roll Number"].toString());
                                   list.add(element.data["Name"].toString());
                                   list.add(element.data["Email"].toString());
                                   list.add(element.data["Branch"].toString());
                                   list.add(element.data["Course"].toString());
                                 });
                               });
                             });
                           }
                           else{}
                           if(!val){
                              _showMyErrorDialog();                            }

                          _rollController.clear();
                           _batchController.clear();
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.black38, fontSize: 20),
                            ),
                          ),
                        )
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    if(list.isNotEmpty == true)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,// tional
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Table(
                          border: TableBorder.all(),
                          defaultColumnWidth: FixedColumnWidth(120.0),
                          children: [
                            TableRow(children :[
                              Text('SR No.',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                              Text('Roll Number',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Name',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Email',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Branch',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Stream',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                            ]),
                            for(num i=0,j=1; i<list.length;i+=5,j++)
                              TableRow(children :[
                                Text("$j",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text(list[i],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text(list[i+1],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text(list[i+2],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text(list[i+3],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text(list[i+4],style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              ]),
                          ],
                        ),
                      ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('1. Roll Number Not Found.\n\n2. Batch Not Found .\n\nPlease try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
