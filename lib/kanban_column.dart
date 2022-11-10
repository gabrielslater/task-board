import 'kanban_card.dart';

class KanbanColumnModel {
  late final String _title;
  final List<KanbanCardModel> _cards = [];

  KanbanColumnModel(this._title);

  int get size => _cards.length;

  void addNewCard(String title, String body, int id) {
    // TODO: ask about throwing errors/exceptions
    if (_cards.indexWhere((element) => element.id == id) == -1) {
      _cards.add(KanbanCardModel(title, body, id));
    }
  }
}
