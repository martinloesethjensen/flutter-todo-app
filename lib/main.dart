import 'package:flutter/material.dart';
import 'package:todo_app/screens/task_list_view.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter TODO Demo",
      theme: ThemeData.dark(),
      home: TaskListView(),
    );
  }
}
