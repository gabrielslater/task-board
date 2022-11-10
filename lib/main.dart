import 'package:final_project_kanban_board/kanban_card.dart';
import 'package:flutter/material.dart';

import 'editable_card_list.dart';

void main() => runApp(const KanbanApp());

class KanbanApp extends StatelessWidget {
  const KanbanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanBan!',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const KanbanMainPage(title: 'Project KanBan!'),
    );
  }
}

class KanbanMainPage extends StatefulWidget {
  const KanbanMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<KanbanMainPage> createState() => _KanbanMainPageState();
}

class _KanbanMainPageState extends State<KanbanMainPage> {
  List<KanbanCardModel> firstList = [];
  List<KanbanCardModel> secondList = [];
  List<KanbanCardModel> thirdList = [];
  var listOneCounter = 1;
  var listTwoCounter = 1;
  var listThreeCounter = 1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 3; i++) {
      firstList.add(KanbanCardModel(
          title: "Title $listOneCounter", body: "Subtitle $listOneCounter"));
      listOneCounter++;

      secondList.add(KanbanCardModel(
          title: "Title $listTwoCounter", body: "Subtitle $listTwoCounter"));
      listTwoCounter++;

      thirdList.add(KanbanCardModel(
          title: "Title $listThreeCounter",
          body: "Subtitle $listThreeCounter"));
      listThreeCounter++;
    }
  }

  void _addCard() {
    setState(() {
      firstList.add(KanbanCardModel(
          title: "Title $listOneCounter", body: "Subtitle $listOneCounter"));
      listOneCounter++;
    });
  }

  //LIST.REMOVE AT INDEX IN LIST???
  void _deleteCard() {
    setState(() {
      // ignore: unrelated_type_equality_checks
      firstList.removeAt(listOneCounter);
      listOneCounter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Flexible(
            child: Container(
              color: Colors.blue,
              child: ListView.builder(
                itemCount: firstList.length,
                itemBuilder: (context, index) => EditableCardList(
                  const ListTile(title: Text("List1")),
                  model: firstList[index],
                  onChanged: (updatedModel) {
                    firstList[index] = updatedModel;
                  },
                ),
              ),
            ),
          ),
          Flexible(
              child: Container(
            color: Colors.green,
            child: ListView.builder(
              itemCount: secondList.length,
              itemBuilder: (context, index) => EditableCardList(
                const ListTile(title: Text("List2")),
                model: secondList[index],
                onChanged: (updatedModel) {
                  secondList[index] = updatedModel;
                },
              ),
            ),
          )),
          Flexible(
            child: Container(
              color: Colors.purple,
              child: ListView.builder(
                itemCount: thirdList.length,
                itemBuilder: (context, index) => EditableCardList(
                  const ListTile(title: Text("List1")),
                  model: thirdList[index],
                  onChanged: (updatedModel) {
                    thirdList[index] = updatedModel;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )),
          //button first
          Container(
              //margin: const EdgeInsets.all(35),
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )),
          Container(
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )),
          Container(
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )),
          Container(
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _addCard,
                tooltip: 'Add Card',
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              )),
          Container(
              padding: EdgeInsets.only(right: 5),
              child: FloatingActionButton(
                onPressed: _deleteCard,
                tooltip: 'Delete Card',
                backgroundColor: Colors.red,
                child: const Icon(Icons.remove),
              )), // button third
          // Add more buttons here
        ],
      ),
    );
  }
}
