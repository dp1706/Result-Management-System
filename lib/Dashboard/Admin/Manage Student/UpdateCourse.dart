import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'dart:async';

import 'package:result_management_system/Auth/Database.dart';

class UpdateCourse extends StatefulWidget {
  @override
  _UpdateCourseState createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {

  DatabaseManager database = DatabaseManager();
  File file;
  final _key = GlobalKey<FormState>();
  TextEditingController _rollController = TextEditingController();
  TextEditingController _semController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  List<dynamic> list = [];
  List<dynamic> list1 = [];
  List<String> Course_list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Update Course" ,style: TextStyle(fontSize: 20,),),
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
                      "Update Course",
                      style: TextStyle(fontSize: 22,color: Colors.black54),
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
                          prefixIcon: Icon(Icons.list_alt),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Roll Number',
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
                        controller: _semController,
                        maxLength: 5,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Semester cannot be empty';
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
                          labelText: 'Semester',
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
                        controller: _courseController,
                        maxLength: 5,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Course Code cannot be empty';
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
                          labelText: 'Course Code',
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
                            List<String> l = [_courseController.text];
                            bool value = await database.UpdateCourse(_rollController.text, _semController.text, l);

                            if(value){
                              _showMyDialog();
                            }else{
                              _showMyErrorDialog();
                            }
                          }
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
                              int j=0;
                              for (var row in excel.tables[table].rows) {
                                if(j==0){
                                  j++;
                                }
                                else{
                                  bool value = false;
                                  if(j == 1){
                                    j++;
                                  Course_list.clear();
                                  list = List<dynamic>.from(row);
                                  for(int i=3;i<row.length;i++){
                                    Course_list.add(list[i].toString());
                                  }
                                  value = await database.UpdateCourse(list[1].toString(), list[2].toString(), Course_list);}

                                  else{
                                    Timer(Duration(seconds: 5), () async{
                                      print("hii");
                                      list = List<dynamic>.from(row);
                                      Course_list.clear();
                                      for(int i=3;i<row.length;i++){
                                        Course_list.add(list[i].toString());}
                                      print(Course_list);
                                       value = await database.UpdateCourse(list[1].toString(), list[2].toString(), Course_list);
                                      print(value);
                                    });
                                  }
                                  if(value){
                                    _showMyDialog();
                                  }else{
                                    _showMyErrorDialog();
                                  }
                                }
                              }
                            }
                           // _showMyDialog();
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
                              Text('Roll Number',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Semester',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Course 1',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Course 2',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Course x..',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),


                            ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("xxxxxxx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("Sem 1/Sem 2..",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("CSXXX",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('ECXXX',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('....',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                Text('Course Updated successfully.\n(NOTE: in case wrong course code please update again)'),
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
          title: Text('Alert'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Check Roll Number or semester and try again.'),
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
