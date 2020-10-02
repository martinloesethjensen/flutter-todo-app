import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';

class AddTaskDialog extends StatefulWidget {
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDetailsController = TextEditingController();
  
  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDetailsController.dispose();
    super.dispose();
  }

  void _save() {
    final taskName = _taskNameController.value.text;
    final taskDetails = _taskDetailsController.value.text;
    final task = taskName.isNotEmpty ? Task(taskName, taskDetails) : null;
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
            key: Key('save_new_task'),
            child: Text(
              'SAVE',
              style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
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
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                ),
                style: theme.textTheme.headline5,
                controller: _taskNameController,
                autofocus: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                key: Key("add_task_details_text_field"),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Details',
                  filled: true,
                ),
                controller: _taskDetailsController,
                onSubmitted: (_) => _save(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
