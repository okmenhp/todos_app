import 'package:flutter/material.dart';
import 'package:todos_app/db/db_todo.dart';
import 'package:todos_app/model/todo.dart';
import 'package:todos_app/screen/add_todo.dart';
import 'package:todos_app/screen/edit_todo.dart';

class ViewTodo extends StatefulWidget {
  const ViewTodo({super.key});

  @override
  State<ViewTodo> createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  var db = DatabaseConnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'Daily Tasks',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        color: const Color(0xFF17E0BC),
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Completed',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'To do Tasks',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: FutureBuilder(
                      future: db.getTodo(),
                      initialData: const [],
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        var data = snapshot.data;
                        var dataLength = data!.length;
                        return dataLength == 0
                            ? const Center(
                                child: Text(
                                  'No data',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: dataLength,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: const Color(0XFF232328),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Transform.scale(
                                              scale: 1.5,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    value:
                                                        data[index].isChecked,
                                                    onChanged:
                                                        (bool? value) async {
                                                      var db =
                                                          DatabaseConnect();
                                                      setState(
                                                        () {
                                                          data[index]
                                                                  .isChecked =
                                                              value!;
                                                        },
                                                      );
                                                      var anothorTodo = Todo(
                                                          id: data[index].id,
                                                          task:
                                                              data[index].task,
                                                          emoji:
                                                              data[index].emoji,
                                                          creationDate:
                                                              data[index]
                                                                  .creationDate,
                                                          isChecked: data[index]
                                                              .isChecked);
                                                      anothorTodo.isChecked =
                                                          value!;
                                                      await db.insertTodo(
                                                          anothorTodo);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditToDo(
                                                              todos:
                                                                  data[index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(data[index]
                                                              .emoji),
                                                          const SizedBox(
                                                              width: 15),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .4,
                                                                child: Text(
                                                                  data[index]
                                                                      .task,
                                                                  maxLines: 1,
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                data[index]
                                                                    .creationDate,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xFF575762)),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      var db =
                                                          DatabaseConnect();
                                                      var myTodo = Todo(
                                                          id: data[index].id,
                                                          task:
                                                              data[index].task,
                                                          emoji:
                                                              data[index].emoji,
                                                          creationDate:
                                                              data[index]
                                                                  .creationDate,
                                                          isChecked: data[index]
                                                              .isChecked);
                                                      await db
                                                          .deleteTodo(myTodo);
                                                      if (!mounted) return;
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ViewTodo(),
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..removeCurrentSnackBar()
                                                        ..showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Todo Deleted Success')));
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .delete_outline_rounded,
                                                      size: 32,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddToDo()));
        },
        backgroundColor: const Color(0xFF752ECF),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
