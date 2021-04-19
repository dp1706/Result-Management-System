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
  String Teacher_id;
  String Post;
  String Stream;

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
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                        ListTile(
                          leading: Icon(Icons.home,color: Colors.pinkAccent,),
                          title: Text(
                            "Name",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(name,style: TextStyle(fontSize: 14),),
                          dense: true,
                        ),
                        Divider(thickness: 0.5,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.email,color: Colors.pinkAccent,),
                          title: Text(
                            "Email",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(myEmail,style: TextStyle(fontSize: 14),),
                          dense: true,
                        ),
                        Divider(thickness: 0.5,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.format_list_numbered,color: Colors.pinkAccent,),
                          title: Text(
                            "Teacher ID",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(Teacher_id,style: TextStyle(fontSize: 14),),
                          dense: true,
                        ),
                        Divider(thickness: 0.5,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.article_outlined,color: Colors.pinkAccent,),
                          title: Text(
                            "Post",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(Post,style: TextStyle(fontSize: 14),),
                          dense: true,
                        ),
                        Divider(thickness: 0.5,),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                        ),
                        ListTile(
                          leading: Icon(Icons.book,color: Colors.pinkAccent,),
                          title: Text(
                            "Stream",
                            textScaleFactor: 1.4,
                          ),
                          subtitle: Text(Stream,style: TextStyle(fontSize: 14),),
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
        Stream=ds.data['Stream'];
      }).catchError((e){
        print(e);
      });
    }
  }
}