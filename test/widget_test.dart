import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/screens/add_task_dialog.dart';
import 'package:todo_app/screens/task_list_view.dart';

void main() {
  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(MaterialApp(
      home: TaskListView(),
    ));

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
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(MaterialApp(home: AddTaskDialog(),));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byType(Container), findsWidgets);
  });
}
