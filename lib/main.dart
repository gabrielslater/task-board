import 'package:final_project_kanban_board/kanban_card.dart';
import 'package:flutter/material.dart';

import 'editable_card_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanBan!',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Project KanBan!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<KanbanCardModel> list = [];
  var _i = 1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 3; i++) {
      _addCard();
    }
  }

  void _addCard() {
    setState(() {
      list.add(KanbanCardModel(title: "Title $_i", body: "Subtitle $_i"));
      _i = _i + 1;
    });
  }

  void _deleteCard() {
    setState(() {
      // ignore: unrelated_type_equality_checks
      list.removeLast();
      _i = _i - 1;
    });
  }

// _i--;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => EditableCardList(
          model: list[index],
          onChanged: (updatedModel) {
            list[index] = updatedModel;
          },
        ),
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )), //button first

          Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: _deleteCard,
                tooltip: 'Delete Card',
                backgroundColor: Colors.red,
                child: const Icon(Icons.remove),
              )), // button third
          // Add more buttons here
        ],
      ),
    );
  }
}

