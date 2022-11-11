import 'package:final_project_kanban_board/kanban_board.dart';
import 'package:flutter/material.dart';

import 'editable_card_list.dart';

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
        color: column % 2 == 0 ? Colors.white24 : Colors.white,
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
                    id: card.id,
                    onEdit: (String title, String body, int id) {
                      setState(() {
                        board.modifyCard(column, id, title, body);
                      });
                    },
                    onDelete: (int id) {
                      setState(() {
                        board.deleteCard(column, id);
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
