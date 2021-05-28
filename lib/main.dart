import 'package:flutter/material.dart';
import 'package:task_manager/screens/home.dart';



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