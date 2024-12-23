import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
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
              title: const Text(
                "Premnadh B.r",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                "Premnadh B.r",
              ),
              trailing: Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 75, 74, 74),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hi! I’m Malak, a community manager from Toronto. I help create and manage engaging communities.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            const ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              title: Text(
                "Notifications",
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("General"),
            ),
            const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text("Account"),
            ),
            const ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              title: Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}
