import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      key: Key(task.name),
      leading: IconButton(
          icon: (task.completed)
              ? Icon(Icons.check_circle)
              : Icon(Icons.radio_button_unchecked),
          onPressed: () => _toggleTask(task)),
      title: Text(
        task.name,
        key: Key("${task.name}_title"),
      ),
      subtitle: (task.detail != null) ? Text(task.detail) : null,
      trailing: IconButton(
        key: Key("${task.name}_delete_button"),
        icon: Icon(Icons.delete_forever),
        onPressed: () {
          print('Web: $kIsWeb');
          _deleteTask(task);
        },
      ),
      onTap: () {
        print('Web: $kIsWeb');
      }, // TODO: Show details
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
        key: Key('add_task_button'),
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
    print(kIsWeb);
    final confirmed = (Platform.isIOS)
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Delete Task?'),
              content: Text('This task will be permanently deleted.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('DELETE'),
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('CANCEL'),
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
              title: Text('Delete Task?'),
              content: Text('This task will be permanently deleted.'),
              actions: <Widget>[
                FlatButton(
                  child: Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("DELETE"),
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
