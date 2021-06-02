import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Task Manager',
          style: TextStyle(fontSize: 25),
        )),
      ),
      body: getImage(),
    );
  }

  Widget getImage() {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/home.jpg"), fit: BoxFit.cover),
      ),
      child: Center(
          child: ElevatedButton(
              child: Text(
                "Click",
                style: TextStyle(fontSize: 23),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TaskList();
                }));
              })),
    );
  }
}
