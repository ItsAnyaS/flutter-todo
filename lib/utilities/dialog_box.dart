import 'package:flutter/material.dart';
import 'package:flutter_todo/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onDiscard;
  DialogBox({
    super.key,
    required this.controller,
    required this.onDiscard,
    required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.yellow[300],
        content: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
          TextField(
            controller:controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task"
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(text: 'Save', onPressed: onSave),
              const SizedBox(width: 8.0),
              MyButton(text: 'Discard', onPressed: onDiscard)
            ],
          )
        ],
        ),
      ),
    );
  }
}