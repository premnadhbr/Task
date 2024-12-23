import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: const Text("heloooo"),
              subtitle: const Text("sssssss"),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.pending)),
            ),
            const Text(
                "Hi! My name is Malak i,m  a communitymanager from ronto sdsd"),
            const SizedBox(
              height: 40,
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications"),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text("General"),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Account"),
            ),
            const ListTile(
              leading: Icon(Icons.notifications),
              title: Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}
