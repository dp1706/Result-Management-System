import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:documents_picker/documents_picker.dart';
class ReadExcel extends StatefulWidget {
  @override
  _ReadExcelState createState() => _ReadExcelState();
}

class _ReadExcelState extends State<ReadExcel> {


  File file;
  var bytes;
  var excel;
  String path;
  List<dynamic> list = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Read Excel File"),),

      body:Container(
        child: RaisedButton(
          onPressed: () async{
            File pickerFile = await FilePicker.getFile(
                allowedExtensions: ['xlsx',],
                type: FileType.custom
            );
            if(pickerFile != null) {
              file = pickerFile;
              var bytes = file.readAsBytesSync();
              var excel = Excel.decodeBytes(bytes);
              for (var table in excel.tables.keys) {
                print(table); //sheet Name
                print(excel.tables[table].maxCols);
                print(excel.tables[table].maxRows);
                for (var row in excel.tables[table].rows) {
                  list = List<dynamic>.from(row);
                }
              }
            }
          },
        ),

      ),
    );
  }
}



