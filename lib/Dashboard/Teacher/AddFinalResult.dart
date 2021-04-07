import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:result_management_system/Auth/Database.dart';

class AddFinalResult extends StatefulWidget {
  @override
  _AddFinalResultState createState() => _AddFinalResultState();
}

class _AddFinalResultState extends State<AddFinalResult> {
  DatabaseManager database = DatabaseManager();
  TextEditingController _rollController = TextEditingController();
  TextEditingController _semController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  final _key = GlobalKey<FormState>();
  List<dynamic> list = [];
  List<dynamic> list1 = [];
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.pinkAccent,
        elevation: 8,
        shadowColor: Colors.black12,
        title: Text("Add final Result" ,style: TextStyle(fontSize: 18,),),
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
                      "Add Final Result",
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

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _gradeController,
                        maxLength: 2,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Grade cannot be empty';
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
                          labelText: 'Final Grade',
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
                            await database.UpdateFinalResult(_rollController.text, _semController.text, _courseController.text, _gradeController.text);
                          }
                          else{

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
                              int i=0;
                              for (var row in excel.tables[table].rows) {
                                if(i==0){
                                  i++;
                                }
                                else{
                                  list = List<dynamic>.from(row);
                                  //print(list);
                                  database.UpdateFinalResult(list[1].toString(), list[2].toString(), list[3].toString(), list[4].toString());
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
                              Text('Course code',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Final Grade',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                            ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("18010xx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("Sem 1/Sem 2..",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("CSXXX",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('XX',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

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
}
