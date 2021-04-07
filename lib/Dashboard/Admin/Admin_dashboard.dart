import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:result_management_system/Dashboard/Admin/UpdateCourse.dart';
import '../Profile/AdminProfile.dart';
import 'password%20generator/generate_password.dart';
import 'package:result_management_system/set_up/login.dart';
import '../../Auth/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Course/StudentCourseDetails.dart';
import '../../AboutUs/AboutUs.dart';
import '../../Calander/Calander.dart';
import 'Manage_student.dart';
import 'Manage_Teacher.dart';


class AHomeScreen extends StatefulWidget{
  @override
  _AHomeScreenState createState()=> _AHomeScreenState();
}


class _AHomeScreenState extends State<AHomeScreen> {
  final AuthenticationService _auth = AuthenticationService();
  String myEmail;
  String name;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.lightBlueAccent,
          elevation: 8,
          shadowColor: Colors.black12,
          title: Text("Dashboard" ,style: TextStyle(fontSize: 26,),),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  tooltip: 'Comment Icon',
                  iconSize: 26,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calander()),
                    );
                  }),
            ]

        ),

        drawer: Drawer(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context , snapshot){
                if(snapshot.connectionState != ConnectionState.done)
                  return Text("");
                return ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(name,style: TextStyle(fontSize: 20),),
                      accountEmail: Text(myEmail,style: TextStyle(fontSize: 16),),
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage('https://cdn.pixabay.com/photo/2015/12/01/15/43/black-1072366__340.jpg'),
                          )
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          name[0],
                          style: TextStyle(fontSize: 40.0,color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle,color: Colors.pinkAccent,), title: Text("View profile",style: TextStyle(fontSize: 16),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Adminprofile()),
                        );
                      },
                      hoverColor: Colors.purpleAccent,
                      enabled: true,
                      trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),

                    ),
                    Divider(thickness: 0.5,),
                    ListTile(
                      leading: Icon(Icons.vpn_key,color: Colors.pinkAccent,), title: Text("Change Password",style: TextStyle(fontSize: 16),),
                      onTap: () {
                        _showMyDialog();
                      },
                      trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                    ),
                    Divider(thickness: 0.5,),
                    ListTile(
                      leading: Icon(Icons.logout,color: Colors.pinkAccent,), title: Text("Logout",style: TextStyle(fontSize: 16),),
                      onTap: () {
                        _auth.signOut().then((result){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );

                        });
                      },
                      trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),

                    ),
                    Divider(thickness: 0.5,),
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined,color: Colors.pinkAccent,), title: Text("About Us",style: TextStyle(fontSize: 16),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutUs()),
                        );
                      },
                      trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                    ),
                  ],);

              }),

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
                            MaterialPageRoute(builder: (context) => StudentHomeScreen()),
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
                          Text('Manage Students', style: TextStyle(fontSize: 18,),),

                        ],

                      ),

                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherHomeScreen()),
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
                          Text('Manage Teachers', style: TextStyle(fontSize: 18,),),

                        ],

                      ),

                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCourseDetails()),);
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
                          Image.asset("images/results.png",height: 80 ,width:40,color: Colors.pinkAccent),
                          Text('Update Marks',style: TextStyle(fontSize:20),),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateCourse()),
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
                          Text('Update Course', style: TextStyle(fontSize: 18,),),

                        ],

                      ),

                    ),
                  ),


                  GestureDetector(
                    onTap: () {setState(() {Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratePassword()),);});},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.pinkAccent,
                      margin: EdgeInsets.only(left:15,right:15,bottom:25,top:30),
                      child: Column(
                        children: <Widget>[
                          Image.asset("images/key.png",height: 80 ,width:40,color: Colors.pinkAccent),
                          Text('Password',style: TextStyle(fontSize:20),),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    shadowColor: Colors.pinkAccent,
                    margin: EdgeInsets.only(left:15,right:15,bottom:25,top:30),
                    child: Column(
                      children: <Widget>[
                        Image.asset("images/contact.png",height: 80 ,width:40,color: Colors.pinkAccent,),
                        Text('Contact',style: TextStyle(fontSize:20),),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCourseDetails()),);
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
                          Image.asset("images/book.png",height: 80 ,width:40,color: Colors.pinkAccent),
                          Text('Courses',style: TextStyle(fontSize:20),),
                        ],
                      ),
                    ),
                  ),
                ],

              ),
            ),
          ],
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
          title: Text('Alert'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to Reset Your PassWord?'),
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
            TextButton(
              child: Text('ok'),
              onPressed: ()  async{
                Navigator.pop(context);

                await _auth.resetPassword(myEmail);

                final snackBar = SnackBar(
                  content: Text('Your Reset Password Link has been sent to '+myEmail),
                  duration: new Duration(seconds: 5),
                  backgroundColor: Colors.green,
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }

  _fetch() async{
    final firebaseuser = await FirebaseAuth.instance.currentUser();

    if(firebaseuser!=null){
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .get()
          .then((ds){
        myEmail=ds.data['Email'];
        name=ds.data['Name'];
      }).catchError((e){
        print(e);
      });
    }
  }
}

