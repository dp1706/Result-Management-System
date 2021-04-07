import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.pinkAccent,
        elevation: 8,
        shadowColor: Colors.black12,
        title: Text("About Us" ,style: TextStyle(fontSize: 16,),),

      ),
    );
  }
}
