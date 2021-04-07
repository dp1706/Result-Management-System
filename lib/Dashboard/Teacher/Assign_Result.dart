import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AssignResult extends StatefulWidget {
  @override
  _AssignResultState createState() => _AssignResultState();
}

class _AssignResultState extends State<AssignResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Result" ,style: TextStyle(fontSize: 20,),),

      ),

      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),title:Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios),title:Text("back")),
        ],
      ),

      body: SingleChildScrollView(
        //controller: controller,
        child : Container(
          height:MediaQuery.of(context).size.height,
          alignment: Alignment.bottomRight,
         )),
    );
  }

/*

  _AssignResult() async {

    CollectionReference users = Firestore.instance.collection('Student');

    var query = await users
        .where('Roll Number', isEqualTo: 1801061)
        .getDocuments()
        .then((value){
          print(value.documents);
          return $value.docu
    });


    }
  }
*/
}