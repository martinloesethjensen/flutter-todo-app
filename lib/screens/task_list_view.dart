import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_dialog.dart';

import '../model/task.dart';

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
          onPressed: () => _toggleTask(task)),
      title: Text(task.name),
      subtitle: (task.detail != null) ? Text(task.detail) : null,
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTask(task),
      ),
      // TODO: Delete a task
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
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  _toggleTask(Task task) {
    setState(() {
      task.completed = !task.completed;
    });
  }

  _deleteTask(Task task) async {
    final confirmed = (Platform.isIOS)
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Delete Task?'),
              content: const Text('This task will be permanently deleted.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text('Delete'),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
          )
        : await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Task?'),
              content: const Text('This task will be permanently deleted.'),
              actions: <Widget>[
                FlatButton(
                  child: const Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: const Text("DELETE"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          );

    if (confirmed ?? false) {
      setState(() {
        Task.tasks.remove(task);
      });
    }
  }

  _addTask() async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskDialog(),
        fullscreenDialog: true,
      ),
    );

    if (task != null) {
      setState(() {
        Task.tasks.add(task);
      });
    }
  }
}
