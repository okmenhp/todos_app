class Todo {
  int? id;
  final String task;
  final String emoji;
  String creationDate;
  bool isChecked;

  Todo(
      {this.id,
      required this.task,
      required this.emoji,
      required this.creationDate,
      required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'emoji': emoji,
      'creationDate': creationDate,
      'isChecked': isChecked ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'Todo(id: $id, task: $task, emoji: $emoji, creationDate: $creationDate, isCheck: $isChecked)';
  }
}
