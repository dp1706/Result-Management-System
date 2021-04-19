import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../Auth/Database.dart';

class DeleteTeacherScreen extends StatefulWidget {
  @override
  _DeleteTeacherScreenState createState() => _DeleteTeacherScreenState();
}

class _DeleteTeacherScreenState extends State<DeleteTeacherScreen> {
  DatabaseManager database = DatabaseManager();
  final _key = GlobalKey<FormState>();
  TextEditingController _tidController = TextEditingController();

  File file;
  List<dynamic> list = [];
  List<dynamic> list1 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Delete Teacher" ,style: TextStyle(fontSize: 20,),),
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
                      "Delete Teacher",
                      style: TextStyle(fontSize: 22,color: Colors.pinkAccent),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _tidController,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Teacher ID cannot be empty';
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
                          labelText: 'Teacher ID',
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
                          if (_key.currentState.validate()) {
                            bool value = await database.DeleteTeacher(_tidController.text);
                            if(value){
                              _showMyDialog();
                            }else{
                              _showMyErrorDialog();
                            }
                          }
                          _tidController.clear();
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
                                  bool value = await database.DeleteTeacher(list[1].toString());
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
                            ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("xxxxx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                            ]),

                            TableRow(children :[
                              Text("2",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("xxxxx",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
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
                Text('Succcessfully deleted.'),
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
                Text('Teacher ID not found.\nPlease try again.'),
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
