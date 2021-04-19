import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../Auth/Database.dart';

class ADDTeacherHomeScreen extends StatefulWidget{
  @override
  _ADDTeacherHomeScreen createState()=> _ADDTeacherHomeScreen();
}

class _ADDTeacherHomeScreen extends State<ADDTeacherHomeScreen>{

  DatabaseManager database = new DatabaseManager();
  final _key = GlobalKey<FormState>();
  File file;
  List<dynamic> list = [];
  List<dynamic> list1 = [];

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _tid = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _post = TextEditingController();
  TextEditingController _stream = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Add Teacher" ,style: TextStyle(fontSize: 20,),),

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
                      "New Teacher",
                      style: TextStyle(fontSize: 22,color: Colors.pinkAccent),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _name,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Name',
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
                        controller: _email,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Email cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Email',
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
                        controller: _tid,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Teacher ID cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.format_list_numbered,color: Colors.pinkAccent,),
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
                        controller: _pass,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Password cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Password',
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
                        controller: _post,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Post cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.details,color: Colors.pinkAccent,),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          labelText: 'Post',
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
                        controller: _stream,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Stream cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.chat_bubble_outline_rounded,color: Colors.pinkAccent,),
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


                    FlatButton(
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            bool value = await database.createNewTeacher(_name.text,_email.text,_tid.text,_post.text,_stream.text,_pass.text);
                            if(value){
                              _showMyDialog();
                            }
                            else{
                              _showMyErrorDialog();
                            }
                          }
                          _name.clear();
                          _email.clear();
                          _tid.clear();
                          _pass.clear();
                          _post.clear();
                          _stream.clear();
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
                                  bool value = await database.createNewTeacher(list[1].toString(), list[2].toString(), list[3].toString(), list[5].toString(), list[4].toString(), list[6].toString());
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
                              Text('Name',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Email',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Teacher ID',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Stream',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Post',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('Password',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),



                            ]),
                            TableRow(children :[
                              Text("1",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("Sample_name",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("abc@gmail.com",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text("123456",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('CSE/ECE/HSS',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('professor/Ass. professor',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text('uthygidnf',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

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
                Text('New Teacher Registration successfully completed.'),
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
                Text('1. Teacher ID already exists or Correct Stream.\n2. Check Your Password Length.\nPlease try again.'),
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