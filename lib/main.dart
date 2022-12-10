import 'dart:convert';

import 'package:final_project_task_board/local_storage.dart';
import 'package:final_project_task_board/task_board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'date_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TaskBoardApp());
}

class TaskBoardApp extends StatelessWidget {
  const TaskBoardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Board',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const TaskBoardTutorialPage(
        title: 'Task Board',
        isFirstTime: true,
      ),
    );
  }
}

class TaskBoardMainPage extends StatefulWidget {
  const TaskBoardMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskBoardMainPage> createState() => _TaskBoardMainPageState();
}

class _TaskBoardMainPageState extends State<TaskBoardMainPage> {
  BoardModel _board = BoardModel();

  set board(BoardModel board) => _board = board;

  String get boardJson => jsonEncode(_board.toJson()).toString();

  final LocalStoreManager manager = LocalStoreManager();

  final TextEditingController _importExportTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _board.init();
  }

  void _addCard(int column) {
    setState(() {
      _board.addCard(column, "", "");
    });
  }

  /// Creates a widget for displaying a [ColumnModel].
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
                  _board.getColumnTitle(column),
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
                  tooltip: "Add card to column",
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: _board.getColumnList(column).length,
                itemBuilder: (context, index) {
                  var card = _board.getColumnList(column)[index];
                  return TaskBoardCard(
                      // Building persistent ListViews
                      // https://www.youtube.com/watch?v=kn0EOS-ZiIc&
                      key: UniqueKey(),
                      title: card.title,
                      body: card.body,
                      onEdit: (String title, String body) {
                        setState(() {
                          _board.modifyCard(column, index, title, body);
                        });
                      },
                      onDelete: () {
                        setState(() {
                          _board.deleteCard(column, index);
                        });
                      },
                      onMove: () {
                        setState(() {
                          if (column < 2) {
                            _board.moveCard(column, column + 1, index,
                                _board.getColumnList(column + 1).length);
                          } else if (column == 2) {
                            _board.moveCard(column, 0, index,
                                _board.getColumnList(0).length);
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

    return SizedBox(
      width: 450,
      child: Container(
        color: Colors.black12,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                manager.saveToStorage(slot, {
                  'time': getDateString(),
                  'board': _board.toJson(),
                });

                Navigator.of(context).pop();
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
                        board = BoardModel.fromJson(slotData!['board']);
                      });

                      if (!mounted) return;

                      Navigator.of(context).pop();
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

  Future<void> _buildImportExportDialog(BuildContext context) async {
    var jsonString = boardJson;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text("Import or export a board"),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 450,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Import',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 150,
                          child: TextField(
                            minLines: 6,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Paste a board\'s JSON',
                            ),
                            controller: _importExportTextController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Export',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  tooltip: "Copy JSON string",
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: jsonString));
                                  },
                                  icon: const Icon(Icons.copy))
                            ],
                          ),
                          Text(jsonString),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            board = BoardModel.fromJson(jsonDecode(
                                _importExportTextController.text.toString()));
                          });
                        },
                        child: const Text('Import'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _importExportTextController.text = jsonString;
                        },
                        child: const Text('Export'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TaskBoardNavigationDrawer(
        onSaveLoad: () {
          _buildSaveLoadDialog(context);
        },
        onImportExport: () {
          _buildImportExportDialog(context);
        },
        onHelp: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TaskBoardTutorialPage(
                      title: "Task Board",
                      isFirstTime: false,
                    )),
          );
        },
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

/// Creates a widget for displaying a [CardModel].
class TaskBoardCard extends StatefulWidget {
  final String title;
  final String body;

  final Function(String title, String body) onEdit;
  final Function() onDelete;
  final Function() onMove;

  const TaskBoardCard({
    Key? key,
    required this.title,
    required this.body,
    required this.onEdit,
    required this.onDelete,
    required this.onMove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskBoardCardState();
}

class _TaskBoardCardState extends State<TaskBoardCard> {
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
              title,

              const Spacer(),
              _buildEditButton(),
              //DropdownButtonExample(),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                tooltip: "Delete card",
                color: Colors.red,
              ),
              _isEditingText
                  ? Container()
                  : IconButton(
                      onPressed: move,
                      tooltip: "Move card to the right",
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
          child: TextField(
            controller: _titleEditingController,
            decoration: const InputDecoration(hintText: 'Card title'),
          ));
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
      return TextField(
        controller: _bodyEditingController,
        decoration: const InputDecoration(hintText: 'Text'),
      );
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
        tooltip: "Finish editing card",
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
        tooltip: "Edit card",
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
  }
}

class TaskBoardNavigationDrawer extends StatelessWidget {
  const TaskBoardNavigationDrawer(
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
            "Task Board",
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

class TaskBoardTutorialPage extends StatelessWidget {
  final String title;
  final bool isFirstTime;

  const TaskBoardTutorialPage(
      {Key? key, required this.title, required this.isFirstTime})
      : super(key: key);

  Widget _buildPage(List<Widget> children) {
    return SizedBox.expand(
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const paragraphStyle = TextStyle(fontSize: 16);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            _buildPage([
              const Text(
                'Unfinished tasks tend to weigh on our minds. Writing'
                ' down plans helps eliminate the stress of '
                'unfinished tasks. It makes tasks feel easier. '
                'After all, "write an essay" is a much larger '
                'sounding task than "write a topic statement."',
                style: paragraphStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Dragging your feet on tasks that seem hard is normal. '
                'Breaking down tasks helps get around that idea of a '
                'mountain. The tinier you can make tasks, the easier it '
                'is to start. Often, once you\'ve started a task, it\'s '
                'much easier to keep working. "Write one sentence" can '
                'quickly become the urge to write a whole paragraph '
                'once started.',
                style: paragraphStyle,
              ),
            ]),
            _buildPage([
              const Text(
                'A task should be a single, actionable step. It\'s okay if you '
                'find a task you wrote isn\'t one step, you can always break it '
                'into more pieces. For example, an essay can often be broken '
                'down into an introduction, a body, and a conclusion.',
                style: paragraphStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Cleaning the house is many smaller tasks, like "Clean the '
                'sink" or "Put the laundry in the wash." Try writing down a '
                'task you\'ve been putting off and seeing if you can break it '
                'into smaller pieces. They can be as small as you want. '
                'Emailing someone can start with "Open my mail client." '
                'There\'s no one way of doing it. If "Write email" is a '
                'specific enough task for you, then it\'s fine to write that '
                'down.',
                style: paragraphStyle,
              ),
            ]),
            _buildPage([
              const Text(
                'Most of the time, there\'s going to be tasks that are more '
                'urgent than others in a project. There also may be time '
                'sensitive tasks, or tasks that have to be finished before '
                'another. "Buy groceries" should probably happen after "Clean '
                'out old food from the fridge," for example. Tasks will not '
                'all be accomplishable at once, and many projects take longer '
                'than a day.',
                style: paragraphStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Arranging tasks by time required helps you pick '
                'priorities. If a task seems to require so much time you\'re '
                'afraid of doing it, it\'s probably too big to be one task. '
                'See if you can identify parts you can break it into. "Read '
                'chapters 6-8" can be broken down into reading chapter 6, '
                'reading chapter 7, and reading chapter 8. It could be broken '
                'down even further by page numbers if necessary.',
                style: paragraphStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              isFirstTime
                  ? Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TaskBoardMainPage(
                                        title: "Task Board",
                                      )),
                            );
                          },
                          child: const Text('Get Started'),
                        ),
                        const Spacer(),
                      ],
                    )
                  : Container(),
            ]),
          ],
        ),
        appBar: AppBar(
          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Why?",
              ),
              Tab(
                text: "Chunking",
              ),
              Tab(
                text: "Time management",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
