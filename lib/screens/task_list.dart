import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_detail.dart';


class TaskList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TaskListState();
  }

}

class TaskListState extends State<TaskList>{
  int taskCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List', style: TextStyle(fontSize: 25.0),),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Notes',
        backgroundColor: Colors.teal,
        onPressed: (){
          debugPrint("Task Added");
          navigateToDetail();

        },
      ),
    );
  }


  ListView getNoteListView() {
    return ListView.builder(
      itemCount: taskCount,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text("Dummy text",),
            trailing: Icon(Icons.delete),
            onTap: () {
              print("Hello");
              navigateToDetail();
            },
          ),
        );
      },
    );
  }
  void navigateToDetail(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TaskDetail();
    }));
  }

}