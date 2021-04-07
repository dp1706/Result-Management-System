import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Tprofile extends StatefulWidget{
  @override
  _TprofileState createState()=> _TprofileState();
}

class _TprofileState extends State<Tprofile>{
  String myEmail;
  String name;
  num Teacher_id;
  String Post;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.lightBlueAccent,
          //automaticallyImplyLeading: false,
          title: Text("Profile" ,style: TextStyle(fontSize: 26,),),
        ),

        body: Center(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context , snapshot){
                if(snapshot.connectionState != ConnectionState.done)
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Column(
                          children: <Widget>[
                            CupertinoActivityIndicator(
                              radius:10,
                            ),

                          ]),
                    ),
                  );

                return Container(
                    margin: EdgeInsets.only(top: 15),
                    color: Colors.white54,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.black12,
                            radius: 60,
                            child: ClipOval(
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/128/1077/1077063.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                color: Colors.pinkAccent,
                              ),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text(
                            "Name",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(name),
                          dense: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text(
                            "Email",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(myEmail),
                          dense: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.format_list_numbered),
                          title: Text(
                            "Teacher ID",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text("$Teacher_id"),
                          dense: true,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.article_outlined),
                          title: Text(
                            "Post",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(Post),
                          dense: true,
                        ),
                      ],

                    ));
              }


          ),
        )

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
        Teacher_id = ds.data['Teacher ID'];
        Post=ds.data['Post'];
        //print(myEmail);
      }).catchError((e){
        print(e);
      });
    }
  }
}