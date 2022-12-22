class Todo {
  int? id;
  String? task;
  String? emoji;
  String? date;
  bool? status;
  todoMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['task'] = task!;
    mapping['emoji'] = emoji!;
    mapping['date'] = date!;
    mapping['status'] = status;
    return mapping;
  }
}
