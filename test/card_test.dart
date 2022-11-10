import 'package:final_project_kanban_board/kanban_card.dart';
import 'package:test/test.dart';

void main() {
  test('updateTitle makes a deep copy and changes the card\'s title', () {
    var card = const KanbanCardModel('Title', 'Body', 0);
    var modifiedCard = card.updateTitle('New Title');

    expect(modifiedCard, isNot(card));
    expect(modifiedCard.title, equals('New Title'));
    expect(modifiedCard.body, equals(card.body));
    expect(modifiedCard.id, equals(card.id));
  });

  test('updateBody makes a deep copy and changes the card\'s body', () {
    var card = const KanbanCardModel('Title', 'Body', 0);
    var modifiedCard = card.updateBody('New Body');

    expect(modifiedCard, isNot(card));
    expect(modifiedCard.title, equals(card.title));
    expect(modifiedCard.body, equals('New Body'));
    expect(modifiedCard.id, equals(card.id));
  });

  test('Copy makes a deep copy and changes nothing', () {
    var card = const KanbanCardModel('Title', 'Body', 0);
    var modifiedCard = card.copy();

    expect(modifiedCard, isNot(card));
    expect(modifiedCard.title, equals(card.title));
    expect(modifiedCard.body, equals(card.body));
    expect(modifiedCard.id, equals(card.id));
  });
}
