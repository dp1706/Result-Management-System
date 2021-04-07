import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:result_management_system/set_up/login.dart';
import '../Auth/Auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _key = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.2,0.5, 1],
                    colors: [Colors.blue,Colors.purple, Colors.deepPurple])

            ),
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            //color: Colors.deepPurple,
            child: Form(
              key: _key,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 120.0,
                        child: Image.asset(
                          "images/email.png",
                          fit: BoxFit.contain,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if(value.isEmpty){
                              return "Email cann't be empty";
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.black54,),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FlatButton(
                          hoverColor: Colors.purpleAccent,
                          color: Colors.transparent,
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),
                          onPressed: () async{
                            if (_key.currentState.validate()) {
                              try{
                                await _auth.resetPassword(_emailController.text);
                                _showMyDialog(_emailController.text);
                              }
                              catch(e){
                                   _showMyErrorDialog();
                              }
                            }
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Reset Password',
                                style: TextStyle(color: Colors.black38, fontSize: 20),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),

                      InkWell(
                        child: Text(
                          "Continue to Login",
                          style: TextStyle(color: Colors.blueAccent,fontSize: 16),
                        ),

                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),

                    ]),
              ),
            ),
          ),
        ),
    );
  }
  Future<void> _showMyErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Email'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please check Email format or you are not registered.'),
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
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(String email) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          elevation: 5,

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Password reset link has been sent to '+ email),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
          ],
        );
      },
    );
  }

}
