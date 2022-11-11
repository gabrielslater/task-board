class KanbanBoardModel {
  final List<KanbanColumnModel> _columns = [];

  int get size => _columns.length;

  int getColumnSize(int index) => _columns[index].size;

  List<KanbanCardModel> getColumnList(int index) => _columns[index].cards;

  String getColumnTitle(int index) => _columns[index].title;

  void addColumn(String title) {
    _columns.add(KanbanColumnModel(title));
  }

  void retitle(int index, String title) {
    _columns[index].renameColumn(title);
  }

  void addCard(int index, String title, String body) {
    _columns[index].addNewCard(title, body);
  }

  /// Moves a [KanbanCardModel] at [fromIndex] in column [fromColumn] to
  /// [toIndex] in [toColumn]
  void moveCard(int fromColumn, int toColumn, int fromIndex, int toIndex) {
    var card = _columns[fromColumn].removeCard(fromIndex);
    _columns[toColumn].addCardAt(toIndex, card);
  }

  void deleteCard(int colIndex, int cardIndex) {
    _columns[colIndex].removeCard(cardIndex);
  }

  void modifyCard(int colIndex, int cardIndex, String title, String body) {
    _columns[colIndex].modifyCard(cardIndex, title, body);
  }
}

class KanbanColumnModel {
  late String _title;
  final List<KanbanCardModel> _cards = [];

  KanbanColumnModel(this._title);

  String get title => _title;

  int get size => _cards.length;

  List<KanbanCardModel> get cards => [..._cards];

  KanbanCardModel getCard(int index) => _cards[index];

  void renameColumn(String newTitle) {
    _title = newTitle;
  }

  void addNewCard(String title, String body) {
    _cards.add(KanbanCardModel(title, body));
  }

  void addCard(KanbanCardModel card) {
    _cards.add(card);
  }

  KanbanCardModel removeCard(int index) {
    return _cards.removeAt(index);
  }

  void modifyCard(int index, String title, String body) {
    _cards[index] = _cards[index].updateTitle(title).updateBody(body);
  }

  void addCardAt(int index, KanbanCardModel card) {
    _cards.insert(index, card);
  }

  @override
  String toString() {
    return 'KanbanColumnModel{_title: $_title, _cards: $_cards}';
  }
}

class KanbanCardModel {
  final String _title;

  String get title => _title;

  final String _body;

  String get body => _body;

  const KanbanCardModel(this._title, this._body);

  KanbanCardModel updateTitle(String title) {
    return KanbanCardModel(title, _body);
  }

  KanbanCardModel updateBody(String body) {
    return KanbanCardModel(_title, body);
  }

  KanbanCardModel copy() {
    return KanbanCardModel(_title, _body);
  }

  @override
  String toString() {
    return 'KanbanCardModel{_title: $_title, _body: $_body}';
  }
}
