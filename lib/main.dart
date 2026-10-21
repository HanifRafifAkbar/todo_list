import 'package:flutter/material.dart';
import 'add_new_todo_page.dart';
import 'detail_todo_page.dart';

void main() {
  runApp(const MaterialApp(
    home: TodoMainScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class TodoItem {
  String title;
  String description;
  bool done;
  TodoItem(this.title, this.description, {this.done = false});
}

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({super.key});

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  final List<TodoItem> _shadowToDoList = [
    TodoItem("Beli makan pagi otw kampus", "Berhenti sebentar beli Ayam Malay"),
    TodoItem("Isi Bensin", "Cabang BP dekat Hallo Surabaya Keputih"),
    TodoItem("Kerjakan tugas", "Tugas kuliah minggu ini yaitu BP")
  ];

  void _openAddNew() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTodoPage(
          onCreate: (item) {
            setState(() {
              _shadowToDoList.add(item);
            });
          },
        ),
      ),
    );
  }

  void _openDetail(TodoItem item, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTodoPage(
          item: item,
          onDelete: () {
            setState(() {
              _shadowToDoList.removeAt(index);
            });
            Navigator.pop(context);
          },
          onToggleDone: (value) {
            setState(() {
              item.done = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Here's your To-Do List:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  child: _shadowToDoList.isEmpty
                      ? const Center(child: Text("Your To-Do List Here"))
                      : ListView.builder(
                          itemCount: _shadowToDoList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _shadowToDoList[index].title,
                                style: TextStyle(
                                  decoration: _shadowToDoList[index].done
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: _shadowToDoList[index].done
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ),
                              onTap: () =>
                                  _openDetail(_shadowToDoList[index], index),
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _openAddNew,
                child: const Text("New"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
