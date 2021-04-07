import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GeneratePassword extends StatefulWidget {
  @override
  _GeneratePasswordState createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  List<String> newPassword = [];
  List<String> passWORD = [];
  final _key = GlobalKey<FormState>();
  Color _color = Colors.blue;
  String isOk = '';
  num n;
  var excel = Excel.createExcel();
  TextEditingController _password = TextEditingController();
  final password = RandomPasswordGenerator();
  @override
  void initState() {
    super.initState();
  }

  checkBox(String name, Function onTap, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Checkbox(value: value, onChanged: onTap),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.pinkAccent,
          elevation: 8,
          shadowColor: Colors.black12,
          title: Text("Password Generator" ,style: TextStyle(fontSize: 20,),),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Center(
              child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        checkBox('Upper Case', (bool value) {
                          _isWithUppercase = value;
                          setState(() {});
                        }, _isWithUppercase),
                        checkBox('Lower Case', (bool value) {
                          _isWithLetters = value;
                          setState(() {});
                        }, _isWithLetters)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        checkBox('Symbols', (bool value) {
                          _isWithSpecial = value;
                          setState(() {});
                        }, _isWithSpecial),
                        checkBox('Numbers', (bool value) {
                          _isWithNumbers = value;
                          setState(() {});
                        }, _isWithNumbers)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        validator: (value) {
                          n = num.tryParse(value);
                          if(n == null){
                            return 'Enter Value or Value is not a valid Number';
                          }
                          return null;
                        },
                        controller: _password,
                        maxLength: 4,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Enter Count',
                          labelStyle: TextStyle(color: Colors.blue),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            passWORD.clear();

                            var excel = Excel.createExcel();
                            Sheet sheetObject = excel['Sheet1'];
                            sheetObject.appendRow(["SR No." , "Generated PassWord"]);
                            sheetObject.appendRow(["1" , "ertduxcs3yt7r8"]);
                            for (var table in excel.tables.keys) {
                              print(table); //sheet Name
                              print(excel.tables[table].maxCols);
                              print(excel.tables[table].maxRows);
                              for (var row in excel.tables[table].rows) {
                                print("$row");
                              }
                            }

                            for(int i=0;i<n;i++) {
                              passWORD.add(password.random_password(
                                  _isWithLetters, _isWithUppercase, _isWithNumbers,
                                  _isWithSpecial, 8));}
                            setState(() {
                              newPassword.clear();
                              for(int i=0;i<n;i++) {
                                newPassword.add(passWORD.elementAt(i));
                              }
                            });
                          }
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Generate Password',
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    if (newPassword.isNotEmpty && newPassword != null)
                      Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                isOk,
                                style: TextStyle(color: _color, fontSize: 25),
                              ),
                            ),
                          )),
                    if (newPassword.isNotEmpty && newPassword != null)
                      Table(
                        border: TableBorder.all(),
                        defaultColumnWidth: FixedColumnWidth(120.0),
                        children: [
                          TableRow(children :[
                            Text('SR No.',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center,),
                            Text('Password',style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                          ]),
                          for( num i=1; i<=n;i++)
                            TableRow(children :[
                              Text("$i",style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),
                              Text(newPassword.elementAt(i-1),style: TextStyle(fontSize: 14.0),textAlign: TextAlign.center),

                            ]
                            ),
                        ],
                      ),

                    SizedBox(
                      height: 30,
                    ),

                  ]),
            ),
          ),
        ));
  }


}

