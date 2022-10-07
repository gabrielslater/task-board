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
        width: 300,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        color: Colors.black12,
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
