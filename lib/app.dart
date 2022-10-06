import 'package:final_project_kanban_board/scaffold.dart';
import 'package:flutter/material.dart';

class KanbanApp extends StatefulWidget {
  const KanbanApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KanbanAppState();
}

class _KanbanAppState extends State<KanbanApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test',
        home: Builder(
          builder: (BuildContext context) {
            return const KanbanScaffold();
          },
        ));
  }
}
