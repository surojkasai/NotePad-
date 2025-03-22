import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/util/dialogue_box.dart';
import 'package:flutter_application_1/util/todo_tile.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _controller = TextEditingController();
  //reference the box

  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    //if this is the first time running the app then it will show the default values
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    }
    //if there is data then
    else {
      db.loadData();
    }
  }

  //todo tasks

  // checkBox state on or off

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      // Show an error message (optional)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task cannot be empty!")));
      return; // Stop execution if input is empty
    }

    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();

    // Close the dialog
    Navigator.of(context).pop();
  }

  //create a new task func
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete a task func
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF4E1C6),
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(title: Text("NotePad +"), elevation: 0),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => {deleteTask(index)},
          );
        },
      ),
    );
  }
}
