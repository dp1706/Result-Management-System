import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddResult extends StatefulWidget {
  @override
  _AddResultState createState() => _AddResultState();
}

class _AddResultState extends State<AddResult> {

  List<dynamic> list = [];
  List<dynamic> list1 = [];
  TextEditingController _courseController = TextEditingController();
  TextEditingController _rollController = TextEditingController();
  TextEditingController _examController = TextEditingController();
  TextEditingController _marksController = TextEditingController();
  TextEditingController _totalController = TextEditingController();
  final _key = GlobalKey<FormState>();

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.pinkAccent,
        elevation: 8,
        shadowColor: Colors.black12,
        title: Text("Add Current Sem Result" ,style: TextStyle(fontSize: 18,),),
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
                      "Update Result",
                      style: TextStyle(fontSize: 22,color: Colors.black54),
                    ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                    child: TextFormField(
                      controller: _courseController,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Course cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.list_alt),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Course',
                        labelStyle: TextStyle(color: Colors.black54),),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                    child: TextFormField(
                      controller: _rollController,
                      maxLength: 7,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Roll Number cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.format_list_numbered),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                    child: TextFormField(
                      controller: _examController,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Exam cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.event_note),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Exam',
                        labelStyle: TextStyle(color: Colors.black54),),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                    child: TextFormField(
                      controller: _marksController,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Marks cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pending_actions),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Marks Obtained',
                        labelStyle: TextStyle(color: Colors.black54),),
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                    child: TextFormField(
                      controller: _totalController,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Marks cannot be empty';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.pending_actions),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Total Marks',
                        labelStyle: TextStyle(color: Colors.black54),),
                      style: TextStyle(color: Colors.black54),
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
                          if (_key.currentState.validate()) {
                            bool value = false;
                            CollectionReference users = Firestore.instance.collection('Student');
                            try {
                              await users
                                  .where("Roll Number",
                                  isEqualTo: _rollController.text)
                                  .getDocuments()
                                  .then((value) {
                                    value.documents.forEach((element) async {
                                  try {
                                    await Firestore.instance
                                        .collection("Student")
                                        .document(element.documentID)
                                        .updateData(
                                        {
                                          'Current': FieldValue.arrayUnion([
                                            {
                                              "Course_code": _courseController
                                                  .text,
                                              "Marks": _marksController.text,
                                              "Total": _totalController.text,
                                              "Type": _examController.text
                                            }
                                          ]),
                                        }
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                });
                              });
                            }catch(e){
                              _showMyErrorDialog();
                              print(e);
                            }
                            _courseController.clear();
                            _marksController.clear();
                            _totalController.clear();
                            _rollController.clear();
                            _examController.clear();
                            _showMyDialog();
                          };
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
                    height: 30,
                  ),

                  Text("OR",
                    style: TextStyle(color: Colors.black,fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () async{
                      File pickerFile = await FilePicker.getFile(
                          allowedExtensions: ['xlsx',],
                          type: FileType.custom
                      );
                      if(pickerFile != null) {
                        file = pickerFile;
                        var bytes = file.readAsBytesSync();
                        var excel = Excel.decodeBytes(bytes);
                        for (var table in excel.tables.keys) {
                          int i=0;
                          for (var row in excel.tables[table].rows) {
                            if(i==0){
                              i++;
                            }
                            else{
                              list = List<dynamic>.from(row);
                              print(list);
                             CollectionReference users = Firestore.instance.collection('Student');
                              await users
                               .where("Roll Number",isEqualTo: list[1].toString())
                               .getDocuments()
                              .then((value){
                                value.documents.forEach((element) async{
                                  if(element.documentID.isNotEmpty){
                                 await Firestore.instance
                                  .collection("Student")
                                  .document(element.documentID)
                                      .updateData(
                                      {
                                        'Current': FieldValue.arrayUnion([{"Course_code":list[5],"Marks":list[3],"Total":list[4],"Type":list[2]}]),
                                      }
                                  );}
                                  else{
                                  }
                                });
                              });
                            }

                          }
                        }
                        _showMyDialog();
                      }
                    },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Select document',
                            style: TextStyle(color: Colors.black38, fontSize: 20),
                          ),
                        ),
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("*Enter file in excel sheet(.xlsx) Format",style: TextStyle(color:Colors.red),),

                  SizedBox(
                    height: 20,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,// tional
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Table(
                        border: TableBorder.all(),
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        children: [
                          TableRow(children :[
                            Text('SR NO.',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                            Text('Course code',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                            Text('Roll Number',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                            Text('Exam',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                            Text('Marks Obtained',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                            Text('Total Marks',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                          ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("CS101",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("18010xx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("quiz",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('x',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('x',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                            ]),

                              TableRow(children :[
                                Text("2",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text("CS101",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text("18010xx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text("quiz",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text('x',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                                Text('x',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                              ]),
                        ]
                    ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                ]),
              ),
            ),
          ),
      ),

      );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('your file Data Successfully updated...'),
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

  Future<void> _showMyErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Password'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check password and retry'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
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
