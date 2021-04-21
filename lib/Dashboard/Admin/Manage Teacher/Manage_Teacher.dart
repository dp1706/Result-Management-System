import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DeleteTeacher.dart';
import 'TeacherDetails.dart';
import 'Add_Teacher.dart';
import 'UpdateTeacherCourse.dart';

class TeacherHomeScreen extends StatefulWidget{
  @override
  _TeacherHomeScreen createState()=> _TeacherHomeScreen();
}

class _TeacherHomeScreen extends State<TeacherHomeScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Manage Teachers" ,style: TextStyle(fontSize: 20,),),

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
                        MaterialPageRoute(builder: (context) => ADDTeacherHomeScreen()),
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
                        Image.asset("images/class.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Add Teacher', style: TextStyle(fontSize: 20,),),

                      ],

                    ),

                  ),
                ),

                GestureDetector(

                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeleteTeacherScreen()),
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
                        Image.asset("images/class.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Delete Teacher', style: TextStyle(fontSize: 20,),),

                      ],),
                  ),),

                GestureDetector(

                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TeacherDetails()),
                      );
                    });
                  },

                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: Colors.pinkAccent,
                  margin: EdgeInsets.only(left:15,right:15,bottom:25,top:30),
                  child: Column(
                    children: <Widget>[
                      Image.asset("images/class.png",height: 80 ,width:40,color: Colors.pinkAccent,),
                      Text('Teacher Details',style: TextStyle(fontSize:20),),
                    ],
                  ),
                ),
              ),

                GestureDetector(

                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UpdateTeacherCourse()),
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
                        Image.asset("images/book.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Update Course', style: TextStyle(fontSize: 20,),),

                      ],),
                  ),),

              ],

            ),
          ),
        ],
      ),

    );
  }
}