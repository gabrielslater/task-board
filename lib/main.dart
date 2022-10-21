import 'package:flutter/material.dart';

import 'editable_card_list.dart';
import 'card_list_editor.dart';

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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListModel> list = [];

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 6; i++) {
      list.add(ListModel(title: "Title $i", subTitle: "Subtitle $i"));
    }
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
        ));
  }
}
