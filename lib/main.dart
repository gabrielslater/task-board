import 'package:final_project_kanban_board/kanban_model.dart';
import 'package:final_project_kanban_board/local_storage.dart';
import 'package:flutter/material.dart';

import 'date_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KanbanApp());
}

class KanbanApp extends StatelessWidget {
  const KanbanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanBan!',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const KanbanMainPage(title: 'Project KanBan!'),
    );
  }
}

class KanbanMainPage extends StatefulWidget {
  const KanbanMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<KanbanMainPage> createState() => _KanbanMainPageState();
}

class _KanbanMainPageState extends State<KanbanMainPage> {
  KanbanBoardModel board = KanbanBoardModel();
  final LocalStoreManager manager = LocalStoreManager();
  late SnackBar saveSnackBar = const SnackBar(content: Text('Saved slot'));
  late SnackBar loadSnackBar = const SnackBar(content: Text('Loaded slot'));
  late SnackBar deleteSnackBar = const SnackBar(content: Text('Deleted slot'));

  @override
  void initState() {
    super.initState();

    board.init();
  }

  void _addCard(int column) {
    setState(() {
      board.addCard(column, "Title", "Body");
    });
  }

  /// Creates a widget for displaying a [KanbanColumnModel].
  Widget _buildColumn(int column) {
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
                  board.getColumnTitle(column),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _addCard(column);
                    });
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: board.getColumnList(column).length,
                itemBuilder: (context, index) {
                  var card = board.getColumnList(column)[index];
                  return KanbanCard(
                      // Building persistent ListViews
                      // https://www.youtube.com/watch?v=kn0EOS-ZiIc&
                      key: UniqueKey(),
                      title: card.title,
                      body: card.body,
                      onEdit: (String title, String body) {
                        setState(() {
                          board.modifyCard(column, index, title, body);
                        });
                      },
                      onDelete: () {
                        setState(() {
                          board.deleteCard(column, index);
                        });
                      },
                      onMove: () {
                        setState(() {
                          if (column < 2) {
                            board.moveCard(column, column + 1, index,
                                board.getColumnList(column + 1).length);
                          } else if (column == 2) {
                            board.moveCard(column, 0, index,
                                board.getColumnList(0).length);
                          }
                        });
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> getSlotTitle(slot) async {
    var slotInfo = await manager.loadFromStorage(slot);

    return slotInfo != null ? 'saved at ${slotInfo['time']}' : '(empty)';
  }

  Future<Widget> _buildDialogOption(BuildContext context, String slot) async {
    var slotInfo = await manager.loadFromStorage(slot);

    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: SizedBox(
        width: 450,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Slot $slot',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  await getSlotTitle(slot),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              onPressed: () {
                manager.saveToStorage(slot, {
                  'time': getDateString(),
                  'board': board.toJson(),
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(saveSnackBar);
              },
              child: const Text("Save"),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: slotInfo == null
                  ? null
                  : () async {
                      var slotData = await manager.loadFromStorage(slot);
                      setState(() {
                        board = KanbanBoardModel.fromJson(slotData!['board']);
                      });

                      if (!mounted) return;

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(loadSnackBar);
                    },
              child: const Text("Load"),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                manager.delete(slot);

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(deleteSnackBar);
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buildSaveLoadDialog(BuildContext context) async {
    var slots = [
      await _buildDialogOption(context, '1'),
      await _buildDialogOption(context, '2'),
      await _buildDialogOption(context, '3'),
      await _buildDialogOption(context, '4'),
      await _buildDialogOption(context, '5'),
    ];

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text("Save or load a board"),
        children: slots,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: KanbanNavigationDrawer(
        onSaveLoad: () {
          _buildSaveLoadDialog(context);
        },
        onImportExport: () {},
        onHelp: () {},
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Flexible(
            child: _buildColumn(0),
          ),
          Flexible(
            child: _buildColumn(1),
          ),
          Flexible(
            child: _buildColumn(2),
          ),
        ],
      ),
    );
  }
}

/// Creates a widget for displaying a [KanbanCardModel].
class KanbanCard extends StatefulWidget {
  final String title;
  final String body;

  final Function(String title, String body) onEdit;
  final Function() onDelete;
  final Function() onMove;

  const KanbanCard({
    Key? key,
    required this.title,
    required this.body,
    required this.onEdit,
    required this.onDelete,
    required this.onMove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  bool _isEditingText = false;
  late TextEditingController _titleEditingController;
  late TextEditingController _bodyEditingController;

  get column => null;

  get board => null;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.title);
    _bodyEditingController = TextEditingController(text: widget.body);
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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 150, child: title),

              const Spacer(),
              _buildEditButton(),
              //DropdownButtonExample(),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
              IconButton(
                onPressed: move,
                icon: const Icon(Icons.arrow_circle_right_outlined),
                color: Colors.blue,
              ),
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
        widget.title,
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
      return Text(
        widget.body,
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    }
  }

  Widget _buildEditButton() {
    if (_isEditingText) {
      return IconButton(
        onPressed: () {
          setState(() {
            widget.onEdit(
              _titleEditingController.text,
              _bodyEditingController.text,
            );
            _isEditingText = false;
          });
        },
        icon: const Icon(Icons.check),
        color: Colors.green,
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            _isEditingText = true;
          });
        },
        icon: const Icon(Icons.edit),
        color: Colors.lightBlue,
      );
    }
  }

  void onDelete() {
    widget.onDelete();
  }

  void move() {
    widget.onMove();
    onDelete();
  }
}

class KanbanNavigationDrawer extends StatelessWidget {
  const KanbanNavigationDrawer(
      {Key? key,
      required this.onSaveLoad,
      required this.onImportExport,
      required this.onHelp})
      : super(key: key);

  final Function() onSaveLoad;
  final Function() onImportExport;
  final Function() onHelp;

  Widget buildListTile(String title, Icon leading, Function onTap) {
    return ListTile(
      title: Text(title),
      leading: leading,
      onTap: () {
        onTap();
      },
    );
  }

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
              icon: const Icon(Icons.close))
        ],
      ),
    );

    final drawerItems = ListView(
      children: <Widget>[
        header,
        buildListTile("Save/Load", const Icon(Icons.save), onSaveLoad),
        buildListTile(
            "Import/Export", const Icon(Icons.import_export), onImportExport),
        buildListTile("Help", const Icon(Icons.help), onHelp),
      ],
    );

    return Drawer(
      child: drawerItems,
    );
  }
}
