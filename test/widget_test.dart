import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_task_dialog.dart';
import 'package:todo_app/screens/task_list_view.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(home: TaskListView()));

    // Find a widget that displays the letter 'H'.
    expect(find.text('Tasks'), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    final addTaskFormKey = Key('add_task_form');

    // Build a MaterialApp with the addTaskFormKey.
    await tester.pumpWidget(MaterialApp(home: AddTaskDialog()));

    // Find the MaterialApp widget using the addTaskFormKey.
    expect(find.byKey(addTaskFormKey), findsOneWidget);
  });

  testWidgets('finds container widgets', (WidgetTester tester) async {
    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(home: AddTaskDialog()));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets("should add and remove a task from the todo list", (WidgetTester tester) async {
    // Given
    var oldTaskListCount = Task.tasks.length;
    print(Task.tasks.length);

    // When
    await tester.pumpWidget(MaterialApp(home: TaskListView()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key("add_task_name_text_field")), "task_name");
    await tester.enterText(find.byKey(Key("add_task_details_text_field")), "task_details");
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();

    // Then
    expect(Task.tasks.length, oldTaskListCount + 1);

    // When
    await tester.tap(find.byKey(Key("task_name_delete_button")));
    await tester.pumpAndSettle();

    await tester.tap(find.text("DELETE"));
    await tester.pumpAndSettle();

    // Then
    expect(Task.tasks.length, oldTaskListCount);
  });
}
