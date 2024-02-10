import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import '../components/dialog_box_page.dart';
import '../components/todo_tile.dart';
import '../helpers/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box(hiveBoxName);

  // Db List Access
  ToDoDataBase db = ToDoDataBase();

  // controller of text alert textbox
  final _controller = TextEditingController();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, the create default data
    if (_myBox.get(hiveToDoList) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // Fuctions
  void checkTaskChecked(bool? afterChanged, int index) {
    if (afterChanged == null) {
      return;
    }
    setState(() {
      db.toDoList[index][1] = afterChanged;
    });

    db.updateDataBase();
  }

  void createANewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void deleteItem(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updateDataBase();
  }
  // End functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        title: const Center(
          child: Text(
            'TO DO',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
      ),

      // Body
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isTaskChecked: db.toDoList[index][1],
            onTaskChanged: (value) => checkTaskChecked(value, index),
            deleteFunction: (context) => deleteItem(index),
          );
        },
      ),

      // Add button
      floatingActionButton: FloatingActionButton(
        onPressed: createANewTask,
        backgroundColor: Colors.amber[300],
        child: const Icon(Icons.add),
      ),
    );
  }
}
