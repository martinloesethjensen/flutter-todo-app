class Task {
  String name, detail;
  bool completed = false;

  static List<Task> _tasks = [
    Task("Choose topic", "testing descr"),
    Task("Drink tea", null),
    Task("Some task", null),
    Task("Update Flutter SDK", "Update to 1.9.1"),
  ];

  static List<Task> get tasks => _tasks;

  static List<Task> get completedTasks =>
      _tasks.where((task) => task.completed).toList();

  static List<Task> get currentTasks =>
      _tasks.where((task) => !task.completed).toList();

  Task(this.name, this.detail);
}
