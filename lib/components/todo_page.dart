
import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isTaskChecked;
  final Function(bool?)? onTaskChanged;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.isTaskChecked,
      required this.onTaskChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 25, left: 25, right: 25),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Checkbox(value: isTaskChecked, onChanged: onTaskChanged),
            Text(
              taskName,
              style: TextStyle(
                decoration: isTaskChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
