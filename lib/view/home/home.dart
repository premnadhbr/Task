import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/controller/home/bloc/home_bloc.dart';

import '../../model/notes/notes.dart';
import '../editScreen/editScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> sampleNotes = [];

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController taskTitleController = TextEditingController();
        TextEditingController taskIconController = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            height: 170,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: taskIconController,
                      decoration: const InputDecoration(
                        hintText: "😍",
                        hintStyle: TextStyle(fontSize: 30),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    TextField(
                      controller: taskTitleController,
                      decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(fontSize: 30),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        color: Colors.blue[200],
                        onPressed: () {
                          if (taskTitleController.text.isNotEmpty &&
                              taskIconController.text.isNotEmpty) {
                            BlocProvider.of<HomeBloc>(context).add(
                              AddNote(
                                note: Note(
                                  id: sampleNotes.length,
                                  icon: taskIconController.text,
                                  title: taskTitleController.text,
                                ),
                              ),
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -30,
                  right: -30,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case NotesAdded:
            final notesState = state as NotesAdded;
            final List<Note> notes = notesState.notes;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Categories",
                  style: TextStyle(fontSize: 20),
                ),
                centerTitle: true,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    radius: 30.0,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/person.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 20),
                            color: Colors.white,
                            elevation: 3,
                            shape: const RoundedRectangleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditScreen(note: note),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        '${note.icon} \n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            height: 1.5),
                                      ),
                                      Text(
                                        note.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${note.tasks.length.toString()} Tasks",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(RemoveNote(index: index));
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            size: 18,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _addNewTask();
                },
                elevation: 10,
                backgroundColor: Colors.grey.shade800,
                child: const Icon(
                  Icons.add,
                  size: 38,
                ),
              ),
            );

          default:
            return const Scaffold(
              body: Center(
                child: Text('Add some notes'),
              ),
            );
        }
      },
    );
  }
}
