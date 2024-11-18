class Task {
  final String name;
  final String description;
  bool isCompleted;
  final String time; // Add time attribute

  Task({
    required this.name,
    required this.description,
    this.isCompleted = false,
    required this.time, // Initialize time
  });
}

class Level {
  final int levelNumber;
  final List<Task> tasks;

  Level({
    required this.levelNumber,
    required this.tasks,
  });
}
