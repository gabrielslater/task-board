import 'package:final_project_kanban_board/kanban_card.dart';

import 'kanban_column.dart';

class KanbanBoardModel {
  final List<KanbanColumnModel> _columns = [];
  int _id_counter = 0;

  int get size => _columns.length;

  void addColumn(String title) {
    _columns.add(KanbanColumnModel(title));
  }

  void renameColumn(int index, String title) {
    _columns[index].renameColumn(title);
  }

  List<KanbanCardModel> getColumnList(int index) {
    return _columns[index].cards;
  }

  String getColumnTitle(int index) {
    return _columns[index].title;
  }

  void addCard(int index, String title, String body) {
    _columns[index].addNewCard(title, body, _id_counter);
    _id_counter++;
  }

  bool columnHasCard(int index, int id) {
    return _columns[index].cards.indexWhere((card) => card.id == id) != -1;
  }

  void moveCard(int fromIndex, int toIndex, int id) {
    if (_columns[fromIndex].hasCard(id)) {
      var card = _columns[fromIndex].removeCardById(id);
      _columns[toIndex].addCard(card);
    }
  }

  void deleteCard(int index, int id) {
    if (_columns[index].hasCard(id)) {
      _columns[index].removeCardById(id);
    }
  }
}
