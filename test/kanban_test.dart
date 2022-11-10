import 'package:final_project_kanban_board/kanban_card.dart';
import 'package:final_project_kanban_board/kanban_column.dart';
import 'package:test/test.dart';

void main() {
  group('Card Tests', () {
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
  });

  group('Column Tests', () {
    group('addNewCard', () {
      test('addNewCard adds new card', () {
        var column = KanbanColumnModel('Column A');

        column.addNewCard("Title", "Body", 0);

        expect(column.size, equals(1));
      });

      test(
          'addNewCard adds new card only if a card with it\'s id does not already exist',
          () {
        var column = KanbanColumnModel('Column A');

        column.addNewCard("Title", "Body", 0);
        column.addNewCard("Title 2", "Body 2", 0);

        expect(column.size, equals(1));

        column.addNewCard("Title 2", "Body 2", 1);

        expect(column.size, equals(2));
      });
    });
    group('addCard', () {
      test('addCard adds an existing card', () {
        var column = KanbanColumnModel('Column A');

        var card = const KanbanCardModel("Title", "Body", 0);

        column.addCard(card);

        expect(column.size, equals(1));
        expect(column.getCardById(0), equals(card));
      });

      test(
          'addCard adds new card only if a card with it\'s id does not already exist',
          () {
        var column = KanbanColumnModel('Column A');

        var card_1 = const KanbanCardModel("Title", "Body", 0);
        var card_2 = const KanbanCardModel("Title 2", "Body 2", 0);

        column.addCard(card_1);
        column.addCard(card_2);

        expect(column.size, equals(1));
        expect(column.getCardById(0), card_1);

        var card_3 = const KanbanCardModel("Title 2", "Body 2", 1);

        column.addCard(card_3);

        expect(column.size, equals(2));
        expect(column.getCardById(1), card_3);
      });
    });
    group('getCardById', () {
      test('getCardById returns the correct card', () {
        var column = KanbanColumnModel('Column A');

        column.addNewCard('Title 0', 'Body', 0);
        column.addNewCard('Title 1', 'Body', 1);
        column.addNewCard('Title 2', 'Body', 2);

        expect(column.getCardById(0).title, equals('Title 0'));
      });
    });
  });
}
