import 'package:flutter/material.dart';
import 'main.dart';

class DetailTodoPage extends StatelessWidget {
  final TodoItem item;
  final VoidCallback onDelete;
  final Function(bool) onToggleDone;

  const DetailTodoPage({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onToggleDone,
  });

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

              Text(
                item.title,
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(10),
                height: 120,
                child: Text(item.description),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: item.done,
                    onChanged: (value) => onToggleDone(value ?? false),
                  ),
                  const Text("Selesai"),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: onDelete,
                child: const Text("Hapus"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
