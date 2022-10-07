import 'package:flutter/material.dart';

class KanbanCard extends StatelessWidget {
  /// Creates a card with a title and body.
  const KanbanCard({Key? key, this.title, this.body}) : super(key: key);

  final String? title;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(8, 0, 16, 8),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(body ?? ""),
          )
        ],
      ),
    );
  }
}
