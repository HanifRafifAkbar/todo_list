import 'package:flutter/material.dart';
import 'main.dart';

class AddNewTodoPage extends StatefulWidget {
  final Function(TodoItem) onCreate;

  const AddNewTodoPage({super.key, required this.onCreate});

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  bool _titleError = false;

  void _createTodo() {
    if (_titleController.text.trim().isEmpty) {
      setState(() {
        _titleError = true;
      });
      return;
    }

    widget.onCreate(
      TodoItem(
        _titleController.text.trim(),
        _descController.text.trim(),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const SizedBox(height: 5),
              const Text(
                "Add a new To-Do:",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),

              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "To-Do Title Here",
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _titleError ? Colors.red : Colors.blue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _titleError ? Colors.red : Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                onChanged: (_) {
                  if (_titleError) {
                    setState(() {
                      _titleError = false;
                    });
                  }
                },
              ),

              if (_titleError)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    "To-Do Title cannot be empty.",
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),

              const SizedBox(height: 25),

              TextField(
                controller: _descController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "To-Do Description Here",
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: _createTodo,
                child: const Text("Create!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
