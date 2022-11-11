import 'kanban_card.dart';

class KanbanColumnModel {
  late String _title;
  final List<KanbanCardModel> _cards = [];

  KanbanColumnModel(this._title);

  String get title => _title;

  int get size => _cards.length;

  List<KanbanCardModel> get cards => [..._cards];

  void renameColumn(String newTitle) {
    _title = newTitle;
  }

  void addNewCard(String title, String body, int id) {
    // TODO: ask about throwing errors/exceptions
    if (_cards.indexWhere((card) => card.id == id) == -1) {
      _cards.add(KanbanCardModel(title, body, id));
    }
  }

  void addCard(KanbanCardModel card) {
    if (_cards.indexWhere((card) => card.id == card.id) == -1) {
      _cards.add(card);
    }
  }

  KanbanCardModel getCardById(int id) {
    return _cards.firstWhere((card) => card.id == id);
  }

  bool hasCard(int id) {
    return _cards.indexWhere((card) => card.id == id) != -1;
  }

  KanbanCardModel removeCardById(int id) {
    var idx = _cards.indexWhere((card) => card.id == id);
    var card = _cards[idx];

    _cards.removeAt(idx);

    return card;
  }

  @override
  String toString() {
    return 'KanbanColumnModel{_title: $_title, _cards: $_cards}';
  }

  void modifyCard(int id, String title, String body) {
    var index = _cards.indexWhere((card) => card.id == id);
    _cards[index] = _cards[index].updateTitle(title).updateBody(body);
  }
}
