import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
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
              child: Column(children: const [
                TextField(
                  decoration: InputDecoration(
                    enabled: true,
                    hintText: 'Task',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF232328)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    enabled: true,
                    hintText: 'Date',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF232328)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
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
                    onPressed: () {},
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
