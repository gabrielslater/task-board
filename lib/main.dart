import 'package:final_project_kanban_board/kanban_model.dart';
import 'package:flutter/material.dart';

void main() => runApp(const KanbanApp());

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

  @override
  void initState() {
    super.initState();

    board.addColumn('Column 1');
    board.addColumn('Column 2');
    board.addColumn('Column 3');

    for (var i = 0; i < board.size; i++) {
      for (var j = 0; j < 3; j++) {
        board.addCard(i, "Title", "Body");
      }
    }
  }

  void _addCard(int column) {
    setState(() {
      board.addCard(column, "Title", "Body");
    });
  }

  Widget buildColumn(int column) {
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Flexible(
            child: buildColumn(0),
          ),
          Flexible(
            child: buildColumn(1),
          ),
          Flexible(
            child: buildColumn(2),
          ),
        ],
      ),
    );
  }
}

class KanbanCard extends StatefulWidget {
  final String title;
  final String body;

  final Function(String title, String body) onEdit;
  final Function() onDelete;

  const KanbanCard({
    Key? key,
    required this.title,
    required this.body,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanCardState();
}

class _KanbanCardState extends State<KanbanCard> {
  bool _isEditingText = false;
  late TextEditingController _titleEditingController;
  late TextEditingController _bodyEditingController;

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
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
                color: Colors.red,
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
          fontSize: 16,
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
          fontSize: 16,
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
}
