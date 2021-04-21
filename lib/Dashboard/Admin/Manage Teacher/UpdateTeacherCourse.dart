import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Auth/Database.dart';
import 'dart:async';

class UpdateTeacherCourse extends StatefulWidget {
  @override
  _UpdateTeacherCourseState createState() => _UpdateTeacherCourseState();
}

class _UpdateTeacherCourseState extends State<UpdateTeacherCourse> {


  List<dynamic> list = [];
  List<dynamic> list1 = [];
  DatabaseManager database = new DatabaseManager();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _tidController = TextEditingController();
  TextEditingController _streamController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _semController = TextEditingController();
  final _key = GlobalKey<FormState>();
  List<String> Course_list = [];

  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.pinkAccent,
        elevation: 8,
        shadowColor: Colors.black12,
        title: Text("Update Teacher Course" ,style: TextStyle(fontSize: 18,),),
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
                      "Update Teacher Course",
                      style: TextStyle(fontSize: 22,color: Colors.black54),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _tidController,
                        maxLength: 7,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Teacher ID cannot be empty';
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
                          labelText: 'Teacher ID',
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
                        controller: _courseController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Course Code cannot be empty';
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
                          labelText: 'Course Code',
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
                        controller: _streamController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Stream cannot be empty';
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
                          labelText: 'Stream',
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
                        controller: _branchController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Branch cannot be empty';
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
                          labelText: 'Branch',
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
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Sem cannot be empty';
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
                          labelText: 'Semester',
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
                            bool value = await database.UpdateTeacherCourse(_tidController.text,l, _streamController.text, _branchController.text, _semController.text);
                            if(value){
                              _showMyDialog();
                            }
                            else{
                              _showMyErrorDialog();
                            }
                          }
                          _courseController.clear();
                          _tidController.clear();
                          _streamController.clear();
                          _branchController.clear();
                          _semController.clear();
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
                              for (var row in excel.tables[table].rows){

                                if(j==0){
                                  j++;
                                }
                                else{
                                  bool value;
                                      if(j == 1){
                                        j++;
                                      list = List<dynamic>.from(row);
                                      Course_list.clear();
                                      for(int i=5;i<row.length;i++){
                                        Course_list.add(list[i].toString());
                                      }
                                      value = await database.UpdateTeacherCourse(list[1].toString(),Course_list,list[2].toString(),list[3].toString(),list[4].toString());

                                      }else{
                                        Timer(Duration(seconds: 5), () async{
                                          list = List<dynamic>.from(row);
                                          Course_list.clear();
                                          for(int i=5;i<row.length;i++){
                                            Course_list.add(list[i].toString());}
                                          value = await database.UpdateTeacherCourse(list[1].toString(),Course_list,list[2].toString(),list[3].toString(),list[4].toString());
                                        });
                                      }

                                  if(value){
                                    _showMyDialog();
                                  }
                                  else{
                                    _showMyErrorDialog();
                                  }
                                }
                              }
                            }
                          }
                          //pickerFile.close();
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
                              Text('Teacher ID',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Stream',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Branch',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Semester',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Course 1',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('..Course X',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                            ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("12345",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("btech/mtech",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("cse/ece",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Sem 1/Sem 2/..Sem x',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('CSXXX',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('..CSXXX',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

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
                Text('your Data Successfully updated'),
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
                Text('Please check Your input and try again'),
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
