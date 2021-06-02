import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/model/task.dart';
import 'package:task_manager/utils/database_helper.dart';
import 'dart:async';


class TaskDetail extends StatefulWidget {
  final String appBarTitle;
  final Task task;

  TaskDetail(this.task, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(this.task, this.appBarTitle);
  }
}

class TaskDetailState extends State<TaskDetail>{
  static var _priorityList = ["High", "Low"];
  var currentItem = "Low";

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Task task;

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDesc = TextEditingController();

  TaskDetailState(this.task, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
//    TextStyle textStyle = Theme.of(context).textTheme.headline1;

  //  taskTitle.text = task.title;
    //taskDesc.text = task.description;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
          return null;
        },



    child: Scaffold(
        appBar: AppBar(title: Text("Task Description", style: TextStyle(fontSize: 25 ),),
    leading: IconButton(icon: Icon(
    Icons.arrow_back),
    onPressed: () {
    moveToLastScreen();
    }
    ),),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: DropdownButton(
                    items: _priorityList.map((String dropDownStringItem) {
                      return DropdownMenuItem<String> (
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),

                    style: TextStyle(fontSize: 20.0,color: Colors.black),
                    dropdownColor: Colors.teal,

                    value: getPriorityAsString(task.priority),

                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updatePriorityAsInt(valueSelectedByUser);
                      });
                    }
                ),
              ),

              ),


            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(

                controller: taskTitle,
                style: TextStyle(fontSize: 23, ),
               //onSubmitted: (value){
                onChanged: (value){
                  setState(() {
                    debugPrint("Something changed");
                    updateTitle();
                  });

                },
                decoration: InputDecoration(

                  labelStyle: TextStyle(fontSize: 23),
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),


                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: taskDesc,
                maxLines: 4,
                style: TextStyle(fontSize: 23),
                onChanged: (value){
                  setState(() {
                    debugPrint("Something changed");
                    updateDescription();
                  });

                },
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 23),
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),


                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Expanded( child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      debugPrint("Saved");
                      _save();
                    });
                  },

                  child: Text("Save", style: TextStyle(fontSize: 23),),
                ),),
                SizedBox(width:5.0),
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        debugPrint("Deleted");
                        _delete();
                      }
                      , child: Text("Delete",style: TextStyle(fontSize: 23))),
                )
              ],),
            ),

          ],
        )
    ), );



}

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
// Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        task.priority = 1;
        break;
      case 'Low':
        task.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorityList[0];  // 'High'
        break;
      case 2:
        priority = _priorityList[1];  // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Task object
  void updateTitle(){
    task.title = taskTitle.text;

  }

  // Update the description of Task object
  void updateDescription() {
    task.description = taskDesc.text;

  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

    task.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (task.id != null) {  // Case 1: Update operation
      result = await helper.updateTask(task);
    } else { // Case 2: Insert Operation
      result = await helper.insertTask(task);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Task Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Task');
    }

  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW Task i.e. he has come to
    // the detail page by pressing the FAB of  Task List page.
    if (task.id == null) {
      _showAlertDialog('Status', 'No Task was deleted');
      return;
    }

    // Case 2: User is trying to delete the old Task  that already has a valid ID.
    int result = await helper.deleteTask(task.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Task Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Task');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}


