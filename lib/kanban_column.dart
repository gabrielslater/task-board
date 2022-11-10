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

  void addCard(KanbanCardModel card) {
    if (_cards.indexWhere((element) => element.id == card.id) == -1) {
      _cards.add(card);
    }
  }

  KanbanCardModel getCardById(int id) {
    return _cards.firstWhere((element) => element.id == id);
  }

  KanbanCardModel removeCardById(int id) {
    var idx = _cards.indexWhere((element) => element.id == id);
    var card = _cards[idx];

    _cards.removeAt(idx);

    return card;
  }
}
