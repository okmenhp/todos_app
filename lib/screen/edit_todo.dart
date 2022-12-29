import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/db/db_todo.dart';
import 'package:todos_app/model/todo.dart';
import 'package:todos_app/screen/view_todo.dart';

class EditToDo extends StatelessWidget {
  final Todo todos;

  const EditToDo({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    final todoTaskController = TextEditingController(text: todos.task);
    final todoEmojiController = TextEditingController(text: todos.emoji);
    final todoDateController = TextEditingController(text: todos.creationDate);
    void setDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF752ECF), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      ).then((value) {
        if (value == null) {
          return;
        }
        todoDateController.text = DateFormat("dd-MM-yyyy").format(value);
      });
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                    controller: todoTaskController,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    decoration: const InputDecoration(
                      enabled: true,
                      hintText: 'Task',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF232328)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Date',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF232328)),
                      ),
                    ),
                    onTap: setDatePicker,
                    controller: todoDateController,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: todoEmojiController,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    decoration: const InputDecoration(
                      enabled: true,
                      hintText: 'Emoji',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.white),
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
                        var db = DatabaseConnect();
                        var myTodo = Todo(
                            id: todos.id,
                            task: todoTaskController.text,
                            emoji: todoEmojiController.text,
                            creationDate: todoDateController.text,
                            isChecked: todos.isChecked);
                        await db.updateTodo(myTodo);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ViewTodo()));
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              content: Text('Todo Updated Success')));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Update tasks',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
