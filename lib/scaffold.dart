import 'package:final_project_kanban_board/navigation_bar.dart';
import 'package:final_project_kanban_board/screens/workspace.dart';
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
      body: const KanbanWorkspace(),
      drawer: const KanbanNavigationDrawer(),
    );
  }
}
