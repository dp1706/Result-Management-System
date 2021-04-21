import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../../../Auth/Database.dart";


class DeleteCourse extends StatefulWidget {
  @override
  _DeleteCourseState createState() => _DeleteCourseState();
}

class _DeleteCourseState extends State<DeleteCourse> {
  final _key = GlobalKey<FormState>();
  DatabaseManager database = DatabaseManager();
  TextEditingController _streamController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _semController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 8,
        shadowColor: Colors.black12,
        title: Text("Add Course" ,style: TextStyle(fontSize: 20,),),
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
                      "Delete Course",
                      style: TextStyle(fontSize: 22,color: Colors.pinkAccent),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
                      child: TextFormField(
                        controller: _streamController,
                        maxLength: 5,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Stream cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.stream,color: Colors.pinkAccent,),
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
                        maxLength: 3,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Branch cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.indeterminate_check_box,color: Colors.pinkAccent),
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
                        maxLength: 5,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Semester cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.all_inbox_outlined,color: Colors.pinkAccent),
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
                        controller: _codeController,
                        maxLength: 5,
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Course Code cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.code,color: Colors.pinkAccent),
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

                            bool value = await database.DeleteCourse(_streamController.text, _branchController.text, _semController.text, _codeController.text);
                            if(value){
                              _showMyDialog();
                            }else{
                              _showMyErrorDialog();
                            }
                          }
                          _streamController.clear();
                          _branchController.clear();
                          _semController.clear();
                          _codeController.clear();
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

                    SizedBox(
                      height: 20,
                    ),
                    Text("*Enter Data in the following format Format.\n\n1.Stream:\t  btech/mtech\n\n2.Branch:\t CSE/ECE\n\n3.Semester:\t Sem 1/Sem 2...\n\n4.Course code:\t CSXXX/ECXXX/HSXXX\n",style: TextStyle(color:Colors.red),),

                    SizedBox(
                      height: 50,
                    ),
                  ]
              ),
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
                Text('Course Deleted successfully.'),
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
                Text('Something went wrong.....Check your data and try again'),
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
