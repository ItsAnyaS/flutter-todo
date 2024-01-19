import 'package:flutter/material.dart';
import 'package:flutter_todo/data/database.dart';
import 'package:flutter_todo/utilities/dialog_box.dart';
import 'package:flutter_todo/utilities/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  void initState(){

    //if this is the first time ever opening the app
    if (_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();


  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
      Navigator.of(context).pop();
      db.updateDataBase();
  }

  void createNewTask (){
    showDialog(context: context, builder: (context)  {
      return DialogBox(
        controller: _controller,
        onDiscard: Navigator.of(context).pop,
        onSave: saveNewTask,
      );
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            deleteFunction: (context) => deleteTask(index),
            onChanged: (value) => checkBoxChanged(value, index));

        },
        )
    );
  }
}