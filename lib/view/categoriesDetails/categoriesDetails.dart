import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryTitle;
  final List tasks;
  final int categoryIndex;

  CategoryDetailScreen({
    required this.categoryTitle,
    required this.tasks,
    required this.categoryIndex,
  });

  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  void _addTask(String task) {
    setState(() {
      widget.tasks.add({'title': task, 'icon': Icons.task_alt});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.tasks[index]['title']),
                  leading: Icon(widget.tasks[index]['icon']),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTask("New Task for ${widget.categoryTitle}");
            },
            child: const Text("Add New Task"),
          ),
        ],
      ),
    );
  }
}
