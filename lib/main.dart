import 'package:flutter/material.dart';
import 'package:todos_app/screen/view_todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF141315),
          backgroundColor: Theme.of(context).primaryColor),
      home: const ViewTodo(),
    );
  }
}
