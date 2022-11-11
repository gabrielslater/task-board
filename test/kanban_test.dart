import 'package:final_project_kanban_board/kanban_model.dart';
import 'package:test/test.dart';

void main() {
  group('Card Tests', () {
    var card = const KanbanCardModel('Title', 'Body');
    test('updateTitle makes a deep copy and changes the card\'s title', () {
      var modifiedCard = card.updateTitle('New Title');

      expect(modifiedCard, isNot(card));
      expect(modifiedCard.title, equals('New Title'));
      expect(modifiedCard.body, equals(card.body));
    });

    test('updateBody makes a deep copy and changes the card\'s body', () {
      var modifiedCard = card.updateBody('New Body');

      expect(modifiedCard, isNot(card));
      expect(modifiedCard.title, equals(card.title));
      expect(modifiedCard.body, equals('New Body'));
    });

    test('Copy makes a deep copy and changes nothing', () {
      var modifiedCard = card.copy();

      expect(modifiedCard, isNot(card));
      expect(modifiedCard.title, equals(card.title));
      expect(modifiedCard.body, equals(card.body));
    });
  });

  group('Column Tests', () {
    var column = KanbanColumnModel('Column A');
    var card = const KanbanCardModel("Title", "Body");

    test('retitle renames a column', () {
      expect(column.title, equals('Column A'));
      column.retitle('Column 1');

      expect(column.title, equals('Column 1'));
    });

    column = KanbanColumnModel('Column A');

    group('addNewCard', () {
      test('addNewCard adds new card', () {
        column.addNewCard("Title", "Body");

        expect(column.size, equals(1));
      });
    });

    test('addCard adds an existing card', () {
      var column = KanbanColumnModel('Column A');

      column.addCard(card);

      expect(column.size, equals(1));
      expect(column.getCard(0), equals(card));
    });

    test('getCard returns the correct card', () {
      var column = KanbanColumnModel('Column A');

      column.addNewCard('Title 0', 'Body');
      column.addNewCard('Title 1', 'Body');
      column.addNewCard('Title 2', 'Body');

      expect(column.getCard(0).title, equals('Title 0'));
    });

    test('removeCard returns the card it removed', () {
      var column = KanbanColumnModel('Column A');

      column.addCard(card);

      expect(column.removeCard(0), equals(card));
    });
  });

  group('Board Tests', () {
    test('addColumn adds a new column', () {
      var board = KanbanBoardModel();
      board.addColumn('Column A');

      expect(board.size, equals(1));
    });

    test('retitleColumn properly renames a column', () {
      var board = KanbanBoardModel();
      board.addColumn('Column A');

      expect(board.getColumnTitle(0), 'Column A');

      board.retitleColumn(0, 'Column 1');

      expect(board.getColumnTitle(0), 'Column 1');
    });

    test('deleteCard removes a card from a column', () {
      var board = KanbanBoardModel();
      board.addColumn('Column A');

      board.addCard(0, 'Title', 'Body');
      board.addCard(0, 'Title', 'Body');

      board.deleteCard(0, 1);

      expect(board.getColumnSize(0), equals(1));
    });
  });
}
