import 'package:todos_app/db/repository.dart';
import 'package:todos_app/model/todo.dart';

class TodoService {
  late Repository _repository;
  TodoService() {
    _repository = Repository();
  }
  //Save User
  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  readAllTodo() async {
    return await _repository.readData('todos');
  }
}
