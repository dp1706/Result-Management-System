import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ADDTeacherHomeScreen extends StatefulWidget{
  @override
  _ADDTeacherHomeScreen createState()=> _ADDTeacherHomeScreen();
}

class _ADDTeacherHomeScreen extends State<ADDTeacherHomeScreen>{
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

    );
  }
}