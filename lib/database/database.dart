import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  //refernce the box
  List toDoList = [];
  final _mybox = Hive.box('myBox');

  //run this method if this is your first time running the app
  void createInitialData() {
    toDoList = [
      ["Make list", false],
      ["Make a another list", false],
    ];
  }

  //load the data
  void loadData() {
    toDoList = _mybox.get("TODOLIST");
  }

  //update the data
  void updateData() {
    _mybox.put("TODOLIST", toDoList);
  }
}
