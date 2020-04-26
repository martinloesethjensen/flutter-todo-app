import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String _taskName = '';
  String _taskDetails;

  void _save() {
    final task = _taskName.isNotEmpty ? Task(_taskName, _taskDetails) : null;
    Navigator.of(context).pop(task);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'SAVE',
              style: theme.textTheme.body1.copyWith(color: Colors.white),
            ),
            onPressed: _save,
          ),
        ],
      ),
      body: Form(
        child: ListView(
          key: Key("add_task_form"),
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                key: Key("add_task_name_text_field"),
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                ),
                style: theme.textTheme.headline,
                onChanged: (value) => _taskName = value,
                autofocus: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                key: Key("add_task_details_text_field"),
                decoration: InputDecoration(
                  labelText: 'Details',
                  filled: true,
                ),
                onChanged: (value) => _taskDetails = value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
