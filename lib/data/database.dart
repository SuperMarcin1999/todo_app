import 'package:hive_flutter/hive_flutter.dart';

import '../helpers/constants.dart';

class ToDoDataBase {
  // reference our box
  final _myBox = Hive.box(hiveBoxName);

  // todo items list
  List toDoList = [];

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", true]
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get(hiveToDoList);
  }

  void updateDataBase() {
    _myBox.put(hiveToDoList, toDoList);
  }
}
