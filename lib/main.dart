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
            return Scaffold(
              appBar: AppBar(
                title: const Text('Test'),
              ),
              body: const KanbanWorkspace(),
              drawer: const KanbanNavigationDrawer(),
            );
          },
        ));
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

/// Creates a widget for containing a set of [KanbanCard]s.
class KanbanColumn extends StatelessWidget {
  // TODO: temporary final values until [KanbanColumnModel] is finished
  final String title;

  const KanbanColumn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: 350,
        color: Colors.black12,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                // TODO: add card on press
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.add),
                )
              ],
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
                KanbanCard(
                  title: "title",
                  body: "body",
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

/// Creates a widget for displaying a [KanbanCardModel].
class KanbanCard extends StatefulWidget {
  // TODO: temporary values until [KanbanCardModel] is attached
  String title;
  String body;

  KanbanCard({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
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
          Text(widget.body)
        ],
      ),
    );
  }
}

class KanbanWorkspace extends StatelessWidget {
  const KanbanWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KanbanColumn(title: "title");
  }
}
