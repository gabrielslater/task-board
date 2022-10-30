import 'package:final_project_kanban_board/kanban_card.dart';
import 'package:flutter/material.dart';

import 'editable_card_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      _i++;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        tooltip: 'Add Card',
        child: const Icon(Icons.add),
      ),
    );
  }
}
