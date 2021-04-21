import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  
  List<String> name = [];
  List<String> email = [];
  List<String> aname = [];
  List<String> aemail = [];
  List<String> Post = [];
  List<String> Stream = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),

      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _fetchContact(),
          builder: (context,snapshot){
            if(snapshot.connectionState != ConnectionState.done)
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Column(
                      children: <Widget>[
                        CupertinoActivityIndicator(
                          radius:10,
                        ),
                        Text("Loading Data....",style:TextStyle(fontSize: 16)),
                      ]),
                ),
              );
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height:20.0),
                ListTile(
                  contentPadding: EdgeInsets.only(bottom: 20),
                  leading: Image.asset('images/contact.png', height: 30,color: Colors.pinkAccent,),
                  title: Center(
                    child: Text(
                      "Contact Details",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.4,

                    ),
                  ),
                ),
                ExpansionTile(
                    childrenPadding: EdgeInsets.only(top:10),
                    title: Text(
                      "Admin Contact Details",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      for(int i=0;i<aemail.length;i++)
                   Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: new EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                           leading: Icon(Icons.account_circle,size: 50,color: Colors.pinkAccent,),
                            title: Text(aname[i],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                            subtitle: Text(aemail[i],style: TextStyle(fontSize: 15,),),
                          trailing:
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: ElevatedButton(

                                  child: Text("Contact",style: TextStyle(color: Colors.black),),
                                  onPressed: () {
                                    _launchURL('mailto:'+aemail[i]+'?subject=&body=');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.blue,
                                    side: BorderSide(width: 1.0, color: Colors.blue),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),

                                    ),
                                  ),
                                ),
                              )
                           ),
                     ] ),
                    ),
                  ),
               ]),

                SizedBox(height:20.0),

                ExpansionTile(
                    childrenPadding: EdgeInsets.only(top:10),
                    title: Text(
                      "Faculty Contact Details",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      for(int i=0;i<email.length;i++)
                        Container(
                        width: MediaQuery.of(context).size.width * 1,
                        padding: new EdgeInsets.all(5.0),
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(20),
                          ),
                          child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.account_circle,size: 50,color: Colors.pinkAccent,),
                                  title: Text(name[i],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  subtitle: Text(Post[i]+"\n"+Stream[i],style: TextStyle(fontSize: 15,),),
                                  isThreeLine: true,
                                trailing:
                                    ElevatedButton(
                                      child: Text("Contact",style: TextStyle(color: Colors.black),),
                                      onPressed: () {
                                        _launchURL('mailto:'+email[i]+'?subject=&body=');

                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.blue,
                                        side: BorderSide(width: 1.0, color: Colors.blue),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32.0),

                                        ),
                                      ),
                                    )
                                ),] ),
                        ),
                      ),
                    ]),
              ],
            ),
          );
          }
        ),
      ),
    );
  }

   _launchURL(url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _fetchContact() async{

    final firebaseuser = await FirebaseAuth.instance.currentUser();
    if(firebaseuser!=null){
      await Firestore.instance
          .collection("Student")
          .orderBy("Role")
          .getDocuments()
         .then((value) {
           aemail.clear();
           email.clear();
           aname.clear();
           name.clear();
            for(int i=0;i<value.documents.length;i++){
              if(value.documents[i].data['Role'] == 'admin'){
                aemail.add(value.documents[i].data['Email']);
                aname.add(value.documents[i].data['Name']);
              }
              if(value.documents[i].data['Role'] == 'teacher'){
                email.add(value.documents[i].data['Email']);
                name.add(value.documents[i].data['Name']);
                Post.add(value.documents[i].data['Post']);
                Stream.add(value.documents[i].data['Stream']);

              }
            }
      }).catchError((e){
        print(e);
      });

    }
  }
}

