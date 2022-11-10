class KanbanCardModel {
  final String _title;
  final String _body;
  final int _id;

  const KanbanCardModel(this._title, this._body, this._id);

  String get title => _title;

  String get body => _body;

  int get id => _id;

  KanbanCardModel updateTitle(String title) {
    return KanbanCardModel(title, _body, _id);
  }

  KanbanCardModel updateBody(String body) {
    return KanbanCardModel(_title, body, _id);
  }

  KanbanCardModel copy() {
    return KanbanCardModel(_title, _body, _id);
  }

  @override
  String toString() {
    return 'KanbanCardModel{_title: $_title, _body: $_body, _id: $_id}';
  }
}
