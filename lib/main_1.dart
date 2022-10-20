import 'package:flutter/material.dart';

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
  int cardCount = 1;
  List<int> list = [1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          cardCount += 1;
          list.add(cardCount);
          setState(() {});
        },
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 38.0, right: 10, left: 10),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (content, index) {
                return SizedBox(
                  height: 170,
                  child: Card(
                    elevation: 8,
                    child: Column(
                      children: const [
                        Text('Title'),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Text')
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}