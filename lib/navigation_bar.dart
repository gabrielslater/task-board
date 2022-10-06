import 'package:flutter/material.dart';

class KanbanNavigationDrawer extends StatelessWidget {
  const KanbanNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var header = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            "Kanban Board",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        header,
        ListTile(
          title: const Text("Save"),
          leading: const Icon(Icons.save),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("Load"),
          leading: const Icon(Icons.folder),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("Import/Export"),
          leading: const Icon(Icons.import_export),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("Help"),
          leading: const Icon(Icons.question_mark),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return Drawer(
      child: drawerItems,
    );
  }
}
