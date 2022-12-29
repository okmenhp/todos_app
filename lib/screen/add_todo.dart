import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:todos_app/db/db_todo.dart';
import 'package:todos_app/model/todo.dart';
import 'package:todos_app/screen/view_todo.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final todoTaskController = TextEditingController();
  final todoEmojiController = TextEditingController();
  final todoDateController = TextEditingController();
  bool _validateTask = false;

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
      body: SingleChildScrollView(
        child: Column(
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
                    controller: todoTaskController,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                      // enabled: true,
                      hintText: 'Task',
                      hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.white),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF232328)),
                      ),
                      errorText:
                          _validateTask ? ' Value Can\'t Be Empty' : null,
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
                        setState(() {
                          todoTaskController.text.isEmpty
                              ? _validateTask = true
                              : _validateTask = false;
                        });

                        if (_validateTask == false) {
                          var db = DatabaseConnect();

                          var myTodo = Todo(
                              task: todoTaskController.text,
                              emoji: todoEmojiController.text,
                              creationDate: todoDateController.text,
                              isChecked: false);
                          await db.insertTodo(myTodo);
                          if (!mounted) return;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewTodo()));
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content: Text('Todo Added Success')));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('Create tasks',
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
