import 'package:flutter/material.dart';
import 'package:task_manager/screens/home.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:task_manager/model/task.dart';
//import 'package:task_manager/utils/database_helper.dart';
//import 'dart:async';




void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return ( MaterialApp(
      title: 'Task Keeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal
      ),
      home: Home(),
    )
    );
  }

}