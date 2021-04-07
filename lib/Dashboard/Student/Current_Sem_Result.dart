import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Current_Sem_Result extends StatefulWidget{

  @override
  _Current_Sem_Result createState()=>_Current_Sem_Result();

}

class _Current_Sem_Result extends State<Current_Sem_Result>{
  final referenceDatabase = FirebaseDatabase.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.green,
        title: Text("Current Sem Result" ,style: TextStyle(fontSize: 20,),),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Comment Icon',
                iconSize: 26,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                }),
            IconButton(
                icon: Icon(Icons.reset_tv),
                tooltip: 'Comment Icon',
                iconSize: 26,
                onPressed: () {
                      _showMyDialog();
                }),
          ]

      ),
      body: SingleChildScrollView(

        child: FutureBuilder(
            future: _fetchresult(),
            builder: (context, snapshot) {
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20.0),
                    ListTile(
                      contentPadding: EdgeInsets.only(bottom: 20),
                      leading: Image.asset('images/notepad.png', height: 30,color: Colors.pinkAccent,),
                      title: Center(
                        child: Text(
                          "Current Sem Result",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.4,

                        ),
                      ),
                    ),
                    SingleChildScrollView(// Op
                           scrollDirection: Axis.horizontal,// tional
                        child: DataTable(
                           columns: <DataColumn>[
                             DataColumn(label: Text("Course Code")),
                             DataColumn(label: Text("Exam Type")),
                             DataColumn(label: Text("Marks Obtained")),
                             DataColumn(label: Text("Total Marks")),

                           ],
                           rows: <DataRow>[
                             for(int i=0;i<list.length;i+=4)
                             DataRow(
                               cells: <DataCell>[
                                 DataCell(Text(list[i])),
                                 DataCell(Text(list[i+1])),
                                 DataCell(Text(list[i+2])),
                                 DataCell(Text(list[i+3])),
                               ],
                             ),
                           ],),
                         ),
             ]),
              );
            }
        ),
      ),


    );
   // throw UnimplementedError();
  }
  _fetchresult() async{
    final firebaseuser = await FirebaseAuth.instance.currentUser();

    if(firebaseuser!=null){
      await Firestore.instance
          .collection('Student')
          .document(firebaseuser.uid)
          .get()
          .then((ds){
            list.clear();
                 for(int i=0;i<ds.data['Current'].length;i++) {
                   list.add(ds.data['Current'][i]["Course_code"].toString());
                   list.add(ds.data['Current'][i]["Type"].toString());
                   list.add(ds.data['Current'][i]["Marks"].toString());
                   list.add(ds.data['Current'][i]["Total"].toString());
                 }
      }).catchError((e){
        print(e);
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Alert'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to reset your current Sem Data?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            TextButton(
                child: Text('Proceed'),
                onPressed: () async{
                  final user = await FirebaseAuth.instance.currentUser();
                  DocumentReference docref = Firestore.instance.collection('Student').document(user.uid);
                  await docref
                      .get()
                      .then((value) async{
                        for(var i=0;i<value.data["Current"].length;i++) {
                          await docref
                              .updateData(
                              {
                                'Current': FieldValue.arrayRemove([{"Course_code":value.data["Current"][i]["Course_code"],"Marks":value.data["Current"][i]["Marks"],"Total":value.data["Current"][i]["Total"],"Type":value.data["Current"][i]["Type"]}]),
                              }
                          );
                        }});

                  await docref
                  .updateData(
                    {
                      'Current':FieldValue.arrayRemove([]),
                    }
                  );
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text("Your Current Sem Data has Been reset. Refresh to see changes"),
                    duration: new Duration(seconds: 5),
                    backgroundColor: Colors.green,
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
            ),
          ],
        );
      },
    );
  }
}