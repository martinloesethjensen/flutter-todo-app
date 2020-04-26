import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/model/task.dart';

void main() {
  group("Task", () {
    test("should be added to the current tasks list", () {
      // Given
      final task = Task("name", "detail");
      var oldCurrentTasksCount = Task.currentTasks.length;

      // When
      Task.tasks.add(task);

      // Then
      expect(Task.currentTasks.length, oldCurrentTasksCount + 1);
    });

    test("should be removed from list", () {
      if (Task.tasks.isNotEmpty) {
        // Given
        var oldCount = Task.tasks.length;

        // When
        Task.tasks.removeLast();

        // Then
        expect(Task.tasks.length, oldCount - 1);
      }
    });
  });
}
