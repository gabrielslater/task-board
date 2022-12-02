import 'package:json_annotation/json_annotation.dart';

part 'kanban_model.g.dart';

@JsonSerializable()
class KanbanBoardModel {
  final List<KanbanColumnModel> _columns = [];

  int get size => _columns.length;

  void init() {
    addColumn('To do');
    addColumn('Working on');
    addColumn('Finished');

    for (var i = 0; i < size; i++) {
      for (var j = 0; j < 3; j++) {
        addCard(i, "Title", "Body");
      }
    }
  }

  int getColumnSize(int index) => _columns[index].size;

  List<KanbanCardModel> getColumnList(int index) => _columns[index].getCards;

  String getColumnTitle(int index) => _columns[index].title;

  void addColumn(String title) {
    _columns.add(KanbanColumnModel(title));
  }

  void retitleColumn(int index, String title) {
    _columns[index].retitle(title);
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

@JsonSerializable()
class KanbanColumnModel {
  late String title;
  final List<KanbanCardModel> cards = [];

  KanbanColumnModel(this.title);

  // String get title => _title;

  int get size => cards.length;

  List<KanbanCardModel> get getCards => [...cards];

  KanbanCardModel getCard(int index) => cards[index];

  factory KanbanColumnModel.fromJson(Map<String, dynamic> json) =>
      _$KanbanColumnModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanbanColumnModelToJson(this);

  void retitle(String newTitle) {
    title = newTitle;
  }

  void addNewCard(String title, String body) {
    cards.add(KanbanCardModel(title, body));
  }

  void addCard(KanbanCardModel card) {
    cards.add(card);
  }

  KanbanCardModel removeCard(int index) {
    return cards.removeAt(index);
  }

  void modifyCard(int index, String title, String body) {
    cards[index] = cards[index].updateTitle(title).updateBody(body);
  }

  void addCardAt(int index, KanbanCardModel card) {
    cards.insert(index, card);
  }

  @override
  String toString() {
    return 'KanbanColumnModel{_title: $title, _cards: $cards}';
  }
}

@JsonSerializable()
class KanbanCardModel {
  final String title;

  // String get title => _title;

  final String body;

  // String get body => _body;

  const KanbanCardModel(this.title, this.body);

  factory KanbanCardModel.fromJson(Map<String, dynamic> json) =>
      _$KanbanCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$KanbanCardModelToJson(this);

  KanbanCardModel updateTitle(String title) {
    return KanbanCardModel(title, body);
  }

  KanbanCardModel updateBody(String body) {
    return KanbanCardModel(title, body);
  }

  KanbanCardModel copy() {
    return KanbanCardModel(title, body);
  }

  @override
  String toString() {
    return 'KanbanCardModel{_title: $title, _body: $body}';
  }
}
