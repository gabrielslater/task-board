import 'package:final_project_kanban_board/kanban_card.dart';
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
                KanbanCard(),
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
  KanbanCardModel _card = KanbanCardModel(title: "Title", body: "Body");

  KanbanCard({Key? key}) : super(key: key);

  void editTitle(String title) {
    _card = KanbanCardModel(title: title, body: _card.body);
  }

  void editBody(String body) {
    _card = KanbanCardModel(title: _card.title, body: body);
  }

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  // https://blog.nonstopio.com/the-editable-text-in-a-flutter-aeca4e845cbb?gi=2a69035248be
  bool _isEditingText = false;
  late TextEditingController _titleEditingController;
  late TextEditingController _bodyEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget._card.title);
    _bodyEditingController = TextEditingController(text: widget._card.body);
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _bodyEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              title,
              const Spacer(),
              _buildEditButton(),
            ],
          ),
          body,
        ],
      ),
    );
  }

  Widget get title {
    if (_isEditingText) {
      return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 200),
          child: TextField(controller: _titleEditingController));
    } else {
      return Text(
        widget._card.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget get body {
    if (_isEditingText) {
      return TextField(controller: _bodyEditingController);
    } else {
      return Text(widget._card.body);
    }
  }

  Widget _buildEditButton() {
    if (_isEditingText) {
      return IconButton(
        onPressed: () {
          print("off");
          setState(() {
            widget.editTitle(_titleEditingController.text.toString());
            widget.editBody(_bodyEditingController.text.toString());
            _isEditingText = false;
          });
        },
        icon: const Icon(Icons.check),
      );
    } else {
      return IconButton(
        onPressed: () {
          print("on");
          setState(() {
            _isEditingText = true;
          });
        },
        icon: const Icon(Icons.edit),
      );
    }
  }
}

class KanbanWorkspace extends StatelessWidget {
  const KanbanWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KanbanColumn(title: "title");
  }
}
