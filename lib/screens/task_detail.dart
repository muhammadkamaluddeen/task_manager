import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskDetailState();
  }
}

class TaskDetailState extends State<TaskDetail>{
  var priorityList = ["High", "Low"];
  var currentItem = "Low";
  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskDesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;


    return Scaffold(
        appBar: AppBar(title: Text("Task Description", style: TextStyle(fontSize: 25 ),),),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                  title: DropdownButton<String>(
                    dropdownColor: Colors.teal,
                    // underline: Text("Priority"),

                    items: priorityList.map((String dropDownItem){
                      return DropdownMenuItem<String>(value: dropDownItem,
                          child:Text(dropDownItem, style: TextStyle(fontSize: 20),));
                    }).toList(),
                    onChanged: (String newItem){
                      setState(() {
                        this.currentItem = newItem;
                      });
                    },
                    value: currentItem,
                  )

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: taskTitle,
                style: TextStyle(fontSize: 23),
                onChanged: (value){
                  setState(() {
                    debugPrint("Something changed");
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
                    });
                  },

                  child: Text("Save", style: TextStyle(fontSize: 23),),
                ),),
                SizedBox(width:5.0),
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        debugPrint("Deleted");
                      }
                      , child: Text("Delete",style: TextStyle(fontSize: 23))),
                )
              ],),
            ),

          ],
        )
    );
  }


}