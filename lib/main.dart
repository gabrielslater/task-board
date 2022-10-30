import 'package:flutter/material.dart';

void main() {
  runApp(const KanbanApp());
}

class KanbanApp extends StatefulWidget {
  const KanbanApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanAppState();
}

class _KanbanAppState extends State<KanbanApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test',
        home: Builder(
          builder: (BuildContext context) {
            return const KanbanScaffold();
          },
        ));
  }
}

class KanbanScaffold extends StatefulWidget {
  const KanbanScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanScaffoldState();
}

class _KanbanScaffoldState extends State<KanbanScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: const KanbanWorkspace(),
      drawer: const KanbanNavigationDrawer(),
    );
  }
}

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

class KanbanColumn extends StatelessWidget {
  const KanbanColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class KanbanCard extends StatefulWidget {
  /// Creates a card with a title and body.
  const KanbanCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(8, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                "",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text(""),
          )
        ],
      ),
    );
  }
}

class KanbanWorkspace extends StatelessWidget {
  const KanbanWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
