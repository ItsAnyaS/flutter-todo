import 'package:flutter/material.dart';
import 'package:flutter_todo/utilities/dialog_box.dart';
import 'package:flutter_todo/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();

  List toDoList = [
    ["Make tutorial", false],
    ["Do exercise", false]
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewtask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
      Navigator.of(context).pop();
  }

  void createNewTask (){
    showDialog(context: context, builder: (context)  {
      return DialogBox(
        controller: _controller,
        onDiscard: Navigator.of(context).pop,
        onSave: saveNewtask,
      );
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        backgroundColor: Colors.yellow,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[500],
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            deleteFunction: (context) => deleteTask(index),
            onChanged: (value) => checkBoxChanged(value, index));

        },
        )
    );
  }
}