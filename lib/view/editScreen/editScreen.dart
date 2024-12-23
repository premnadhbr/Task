import 'package:flutter/material.dart';
import '../../model/notes/notes.dart';

class EditScreen extends StatefulWidget {
  final Note? note;

  const EditScreen({super.key, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController tasksController;

  late List<String> tasks;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note!.title);
    tasksController = TextEditingController();
    tasks = List<String>.from(widget.note?.tasks ?? []);
  }

  void saveTask() {
    if (tasksController.text.isNotEmpty) {
      setState(() {
        tasks.add(tasksController.text);
        if (widget.note != null) {
          widget.note!.tasks = List<String>.from(tasks);
        }
        tasksController.clear();
      });
    }
  }

  void addTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            controller: tasksController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter task',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                saveTask();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, widget.note);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30),
                    ),
                    onChanged: (value) {
                      if (widget.note != null) {
                        widget.note!.title = value;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ...tasks.map((task) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                      ),
                      title: Text(
                        task,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            tasks.remove(task);
                            if (widget.note != null) {
                              widget.note!.tasks = List<String>.from(tasks);
                            }
                          });
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTaskDialog,
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.add),
      ),
    );
  }
}
