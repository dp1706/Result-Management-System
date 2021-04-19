import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:result_management_system/Dashboard/Admin/Manage Student/StudentDetails.dart';
import 'package:result_management_system/Dashboard/Teacher/TeacherContact.dart';
import 'package:result_management_system/set_up/login.dart';
import '../Profile/TeacherProfile.dart';
import '../../Auth/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddResult.dart';
import '../../AboutUs/AboutUs.dart';
import '../../Calander/Calander.dart';
import 'AddFinalResult.dart';


class THomeScreen extends StatefulWidget{
  @override
  _THomeScreenState createState()=> _THomeScreenState();
}


class _THomeScreenState extends State<THomeScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String myEmail;
  String name;
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.pinkAccent,
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
                          MaterialPageRoute(builder: (context) => Tprofile()),
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
                        _showMyLogoutDialog();
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
                          MaterialPageRoute(builder: (context) => AddResult()),
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
                          Image.asset("images/notepad.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                          Text('Add Result', style: TextStyle(fontSize: 25,),),

                        ],

                      ),

                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddFinalResult()),
                        );
                      });
                    },


                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(15),
                        //side: BorderSide(color: Colors.black),
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
                          Image.asset("images/notepad.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                          Text('Final Result', style: TextStyle(fontSize: 25,),),

                        ],

                      ),

                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StudentDetailsScreen()),
                        );
                      });
                    },

                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.pinkAccent,
                      margin: EdgeInsets.only(left:15,right:15,bottom:25,top:25),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height:15,
                          ),
                          Image.asset("images/graduated.png",height: 70 ,width:40,color: Colors.pinkAccent),
                          Text('Students',style: TextStyle(fontSize:25),),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TeacherContact()),
                        );
                      });
                    },


                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(15),
                        //side: BorderSide(color: Colors.black),
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
                          Image.asset("images/contact.png",height: 70 ,width:40,color: Colors.pinkAccent,),
                          Text("Contact", style: TextStyle(fontSize: 25,),),

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

  Future<void> _showMyLogoutDialog() async {
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
                Text('Are you sure to logout?'),
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
                _auth.signOut().then((result){
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });

                });
              },
            ),
          ],
        );
      },
    );

  }
}

