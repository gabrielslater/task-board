import 'package:json_annotation/json_annotation.dart';

part 'task_board_model.g.dart';

@JsonSerializable()
class BoardModel {
  final List<ColumnModel> columns;

  int get size => columns.length;

  BoardModel([List<ColumnModel>? columns]) : columns = columns ?? [];

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

  int getColumnSize(int index) => columns[index].size;

  List<CardModel> getColumnList(int index) => columns[index].getCards;

  String getColumnTitle(int index) => columns[index].title;

  void addColumn(String title) {
    columns.add(ColumnModel(title));
  }

  void retitleColumn(int index, String title) {
    columns[index].retitle(title);
  }

  void addCard(int index, String title, String body) {
    columns[index].addNewCard(title, body);
  }

  /// Moves a [CardModel] at [fromIndex] in column [fromColumn] to
  /// [toIndex] in [toColumn]
  void moveCard(int fromColumn, int toColumn, int fromIndex, int toIndex) {
    var card = columns[fromColumn].removeCard(fromIndex);
    columns[toColumn].addCardAt(toIndex, card);
  }

  void deleteCard(int colIndex, int cardIndex) {
    columns[colIndex].removeCard(cardIndex);
  }

  void modifyCard(int colIndex, int cardIndex, String title, String body) {
    columns[colIndex].modifyCard(cardIndex, title, body);
  }

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() {
    var cols = [];

    for (var col in columns) {
      cols.add(col.toJson());
    }

    return {'columns': cols};
  }
}

@JsonSerializable()
class ColumnModel {
  late String title;
  List<CardModel> cards = [];

  ColumnModel(this.title);

  int get size => cards.length;

  List<CardModel> get getCards => [...cards];

  CardModel getCard(int index) => cards[index];

  void retitle(String newTitle) {
    title = newTitle;
  }

  void addNewCard(String title, String body) {
    cards.add(CardModel(title, body));
  }

  void addCard(CardModel card) {
    cards.add(card);
  }

  CardModel removeCard(int index) {
    return cards.removeAt(index);
  }

  void modifyCard(int index, String title, String body) {
    cards[index] = cards[index].updateTitle(title).updateBody(body);
  }

  void addCardAt(int index, CardModel card) {
    cards.insert(index, card);
  }

  factory ColumnModel.fromJson(Map<String, dynamic> json) =>
      _$ColumnModelFromJson(json);

  Map<String, dynamic> toJson() {
    var cardsJson = [];

    for (var card in cards) {
      cardsJson.add(card.toJson());
    }

    return {
      'title': title,
      'cards': cardsJson,
    };
  }

  @override
  String toString() {
    return 'KanbanColumnModel{title: $title, cards: $cards}';
  }
}

@JsonSerializable()
class CardModel {
  final String title;

  final String body;

  const CardModel(this.title, this.body);

  CardModel updateTitle(String title) {
    return CardModel(title, body);
  }

  CardModel updateBody(String body) {
    return CardModel(title, body);
  }

  CardModel copy() {
    return CardModel(title, body);
  }

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);

  @override
  String toString() {
    return 'KanbanCardModel{title: $title, body: $body}';
  }
}
