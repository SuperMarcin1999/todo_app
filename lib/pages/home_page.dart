import 'package:flutter/material.dart';
import '../components/dialog_box_page.dart';
import '../components/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controller of text alert textbox
  final _controller = TextEditingController();

  // list of todos
  List todos = [
    ["Make Tutorial", true],
    ["Do Exercices", false],
    ["Do Exercices 2", true],
    ["Do Exercices 3", true],
  ];

  // Fuctions
  void checkTaskChecked(bool? afterChanged, int index) {
    if (afterChanged == null) {
      return;
    }
    setState(() {
      todos[index][1] = afterChanged;
    });
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
      todos.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
  }

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
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todos[index][0],
            isTaskChecked: todos[index][1],
            onTaskChanged: (value) => checkTaskChecked(value, index),
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
