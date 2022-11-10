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

    for (var i = 0; i < 3; i++) {
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
                itemCount: board.getColumnList(column).length,
                itemBuilder: (context, index) => KanbanCard(
                  ListTile(title: Text(board.getColumnTitle(column))),
                  model: board.getColumnList(column)[index],
                  onDelete: (model) {
                    setState(() {
                      print(board.getColumnList(column)[index]);
                      print(model);
                      print('intended id ${model.id}');
                      board.deleteCard(column, model.id);
                    });
                  },
                ),
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
          Flexible(child: buildColumn(1)),
          Flexible(
            child: buildColumn(2),
          ),
        ],
      ),
    );
  }
}
