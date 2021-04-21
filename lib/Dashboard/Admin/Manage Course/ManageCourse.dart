import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'AddCourse.dart';
import 'DeleteCourse.dart';

class ManageCourse extends StatefulWidget {
  @override
  _ManageCourseState createState() => _ManageCourseState();
}

class _ManageCourseState extends State<ManageCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.lightBlueAccent,
          elevation: 8,
          shadowColor: Colors.black12,
          title: Text("Manage Course" ,style: TextStyle(fontSize: 20,),),
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
                        MaterialPageRoute(builder: (context) => AddCourse()),
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
                        Image.asset("images/book.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                        Text('Add Course', style: TextStyle(fontSize: 20,),),

                      ],
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeleteCourse()),
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
                        Text('Delete Course', style: TextStyle(fontSize: 20,),),
                      ],
                    ),
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
