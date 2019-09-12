import 'package:flutter/material.dart';
import 'package:todo_app/task_list_view.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter TODO Demo",
      home: TaskListView(),
    );
  }
}
