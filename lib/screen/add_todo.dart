import 'package:flutter/material.dart';
import 'package:todos_app/model/todo.dart';
import 'package:todos_app/services/todo_service.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _todoTaskController = TextEditingController();
  final _todoEmojiController = TextEditingController();
  final _todoDateController = TextEditingController();
  final _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF17171A),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: null,
        elevation: 0,
        backgroundColor: const Color(0xFF141315),
      ),
      body: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * .1,
            color: const Color(0xFF141315),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: const [
                Text(
                  'Add new',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ]),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            color: const Color(0xFF17171A),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TextField(
                  controller: _todoTaskController,
                  decoration: const InputDecoration(
                    enabled: true,
                    hintText: 'Task',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF232328)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _todoDateController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    enabled: true,
                    hintText: 'Date',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF232328)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _todoEmojiController,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    enabled: true,
                    hintText: 'Emoji',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF232328)),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF752ECF),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(32)), // foreground
                    ),
                    onPressed: () async {
                      var todo = Todo();
                      todo.task = _todoTaskController.text;
                      todo.date = _todoDateController.text;
                      todo.emoji = _todoEmojiController.text;
                      var result = await _todoService.saveTodo(todo);
                      Navigator.pop(context, result);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child:
                          Text('Create tasks', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
