import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Add_Student.dart';
import 'DeleteStudent.dart';

class StudentHomeScreen extends StatefulWidget{
  @override
  _StudentHomeScreen createState()=> _StudentHomeScreen();
}

class _StudentHomeScreen extends State<StudentHomeScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Manage Students" ,style: TextStyle(fontSize: 20,),),

      ),

      body:Stack(


        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top:170),
            color: Colors.white,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              //childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height/2.5),
              primary: false,

              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ADDStudentHomeScreen()),
                      );
                    });
                  },

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.pinkAccent,
                    margin: EdgeInsets.only(left:15,right:15,bottom: 25,top:25),

                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height:15,
                        ),
                        Image.asset("images/graduated.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Add Student', style: TextStyle(fontSize: 20,),),

                      ],

                    ),

                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeleteStudentScreen()),
                      );
                    });
                  },


                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    shadowColor: Colors.pinkAccent,
                    color: Colors.white,
                    margin: EdgeInsets.only(left:15,right:15,bottom: 25,top:25),

                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height:15,
                        ),
                        Image.asset("images/graduated.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Delete Student', style: TextStyle(fontSize: 20,),),

                      ],),
                  ),),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: Colors.pinkAccent,
                  margin: EdgeInsets.only(left:15,right:15,bottom:25,top:30),
                  child: Column(
                    children: <Widget>[
                      Image.asset("images/graduated.png",height: 80 ,width:40,color: Colors.pinkAccent,),
                      Text('Student Details',style: TextStyle(fontSize:20),),
                    ],
                  ),
                ),
              ],

            ),
          ),
        ],
      ),

    );
  }
}