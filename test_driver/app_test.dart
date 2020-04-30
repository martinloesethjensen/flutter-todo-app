// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:todo_app/model/task.dart';

void main() {
  group('Todo App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final buttonFinder = find.byValueKey('add_task_button');
    final saveButtonFinder = find.byValueKey("save_new_task");
    final deleteTaskButtonFinder = find.byValueKey("task_name_delete_button");
    final addTaskNameTextField = find.byValueKey("add_task_name_text_field");
    final addTaskDetailsTextField =
        find.byValueKey("add_task_details_text_field");

    var oldTaskListCount = Task.tasks.length;

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // To make sure the device is ready before starting the tests
    sleep(Duration(seconds: 4));

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test("should add a task to the todo list", () async {
      sleep(Duration(seconds: 2));

      await driver.tap(buttonFinder);

      sleep(Duration(seconds: 1));

      await driver.tap(addTaskNameTextField);

      sleep(Duration(seconds: 1));

      await driver.enterText("task_name", timeout: Duration(milliseconds: 300));

      await driver.tap(addTaskDetailsTextField);

      sleep(Duration(seconds: 1));

      await driver.enterText("task_details", timeout: Duration(milliseconds: 300));

      sleep(Duration(seconds: 1));

      await driver.tap(saveButtonFinder, timeout: Duration(milliseconds: 500));

      expect(await driver.getText(find.byValueKey("task_name_title")),
          "task_name");
    });

    test("should remove a task from the todo list", () async {
      sleep(Duration(seconds: 2));

      await driver.tap(deleteTaskButtonFinder,
          timeout: Duration(milliseconds: 500));

      sleep(Duration(seconds: 1));

      await driver.tap(find.text("DELETE"), timeout: Duration(milliseconds: 300));

      expect(Task.tasks.length, oldTaskListCount);
    });
  });
}
