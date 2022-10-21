import 'package:flutter/material.dart';

import 'card_list_editor.dart';
import 'editable_card_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanBan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'KanBan Board'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListModel> list = [];

  @override
  Scaffold initState() {
    super.initState();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          for (int i = 1; i <= 6; i++){
            list.add(ListModel(title: "Title $i", subTitle: "Subtitle $i"));
            setState(() {});
          }
        },
      ),
    );
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
