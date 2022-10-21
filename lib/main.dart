import 'package:flutter/material.dart';

import 'card_list_editor.dart';
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
  List<ListModel> list = [];
  var _i = 1;

  void _addCard() {
    setState(() {
      list.add(ListModel(title: "Title $_i", subTitle: "Subtitle $_i"));
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
