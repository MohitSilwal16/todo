import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {
  VoidCallback onSave;
  DialogueBox({
    super.key,
    required this.controller,
    required this.onSave,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 51, 48, 48),
      content: Container(
        width: 200,
        height: 190,
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            const Text('Add Task'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add Task',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                    width: 20,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
              autofocus: true,
              showCursor: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 20),
              onPressed: onSave,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
