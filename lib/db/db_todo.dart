import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_app/model/todo.dart';

class DatabaseConnect {
  Database? _database;
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'todo.db';
    final path = join(dbpath, dbname);
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return _database!;
  }

  // Create database
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task TEXT,
      emoji TEXT,
      creationDate TEXT,
      isChecked INTEGER
      )
    ''');
  }

  // Insert todo
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Update todo
  Future<void> updateTodo(Todo todo) async {
    final db = await database;

    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Delete todo
  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete('todo', where: 'id = ?', whereArgs: [todo.id]);
  }

  // Get todo
  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('todo', orderBy: 'id DESC');
    return List.generate(
      items.length,
      (index) => Todo(
          id: items[index]['id'],
          task: items[index]['task'],
          emoji: items[index]['emoji'],
          creationDate: items[index]['creationDate'],
          isChecked: items[index]['isChecked'] == 1 ? true : false),
    );
  }
}
