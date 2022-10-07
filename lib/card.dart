import 'package:flutter/material.dart';

class KanbanCard extends StatelessWidget {
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

// return Container(
// padding: const EdgeInsets.all(8),
// color: Colors.white,
// child: FittedBox(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Text(
// "Test",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 14,
// ),
// ),
// Flexible(
// child: Container(
// padding: const EdgeInsets.all(8),
// child: const Text(
// "Id aut sint asperiores atque ad ad et inventore. Omnis numquam "
// "et eveniet. Earum quis error non. Incidunt atque rerum "
// "occaecati cum sed veniam.",
// ),
// ),
// ),
// ],
// ),
// ),
// );
