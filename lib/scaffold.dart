import 'package:flutter/material.dart';

class KanbanScaffold extends StatefulWidget {
  const KanbanScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanScaffoldState();
}

class _KanbanScaffoldState extends State<KanbanScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: const Center(
        child: Text('Test'),
      ),
    );
  }
}
