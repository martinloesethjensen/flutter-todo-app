import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/add_task_dialog.dart';

import 'task.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final GlobalKey<State> _completedKey = GlobalKey<State>();

  ListTile widgetListTile(Task task) {
    return ListTile(
      leading: IconButton(
          icon: (task.completed)
              ? Icon(Icons.check_circle)
              : Icon(Icons.radio_button_unchecked),
          onPressed: () => toggleTask(task)),
      title: Text(task.name),
      subtitle: (task.detail != null) ? Text(task.detail) : null,
      trailing: Icon(Icons.delete_forever), // TODO: Delete a task
      onTap: () {}, // TODO: Show details
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text("Todo (${Task.currentTasks.length})"),
            initiallyExpanded: true,
            children: <Widget>[
              for (final task in Task.currentTasks) widgetListTile(task),
            ],
          ),
          ExpansionTile(
              key: _completedKey,
              initiallyExpanded: true,
              title: Text("Completed (${Task.completedTasks.length})"),
              children: <Widget>[
                for (final task in Task.completedTasks) widgetListTile(task),
              ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  _addTask() async {
//    final task = await Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => AddTaskDialog(), fullscreenDialog: false));
//    if (task != null) {
//      setState(() {
//        Task.tasks.add(task)
//      });
//    }
  }
}
