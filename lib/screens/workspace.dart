import 'package:final_project_kanban_board/card.dart';
import 'package:flutter/material.dart';

class KanbanWorkspace extends StatelessWidget {
  const KanbanWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createCardColumn(context);
  }

  Widget _createCardColumn(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        width: 350,
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            Row(
              children: const <Widget>[
                Text(
                  "Test",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: const <Widget>[
                  KanbanCard(
                      title: "Lorem Ipsum",
                      body:
                          "Id aut sint asperiores atque ad ad et inventore. Omnis "
                          "numquam et eveniet. Earum quis error non. Incidunt "
                          "atque rerum occaecati cum sed veniam."),
                  KanbanCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
