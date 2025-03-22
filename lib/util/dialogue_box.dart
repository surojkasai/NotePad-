import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/my_buttons.dart';

class DialogueBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogueBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 200,
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add a new task",
                ),
              ),

              // SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     //save button
              //     FloatingActionButton(
              //       onPressed: () {},
              //       backgroundColor: Colors.amber,
              //       child: Icon(Icons.add),
              //     ),
              //     SizedBox(width: 20),
              //     FloatingActionButton(
              //       onPressed: () {},
              //       backgroundColor: Colors.amber,
              //       child: Icon(Icons.cancel),
              //     ),
              //     //cancel button
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  MyButtons(text: "Save", onPressed: onSave),
                  const SizedBox(width: 20),
                  MyButtons(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
