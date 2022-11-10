import 'package:final_project_kanban_board/kanban_board.dart';
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
    group('renameColumn', () {
      test('renameColumn renames a column', () {
        var column = KanbanColumnModel('Column A');

        expect(column.title, equals('Column A'));
        column.renameColumn('Column 1');

        expect(column.title, equals('Column 1'));
      });
    });
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
    group('hasCard', () {
      test('hasCard returns true when the card exists', () {
        var column = KanbanColumnModel('Column A');

        column.addNewCard('Title 0', 'Body', 0);

        expect(column.hasCard(0), equals(true));
        expect(column.hasCard(100), equals(false));
      });
    });
    group('removeCardById', () {
      test('removeCardById returns the card it removed', () {});
    });
  });

  group('Board Tests', () {
    group('addColumn', () {
      test('addColumn adds a new column', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');

        expect(board.size, equals(1));
      });
    });

    group('getColumnTitle', () {
      test('getColumnTitle returns the column\'s name', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');

        expect(board.getColumnTitle(0), 'Column A');
      });
    });

    group('renameColumn', () {
      test('getColumnTitle properly renames a column', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');

        expect(board.getColumnTitle(0), 'Column A');

        board.renameColumn(0, 'Column 1');

        expect(board.getColumnTitle(0), 'Column 1');
      });
    });

    group('columnHasCard', () {
      test('columnHasCard returns true when a column has a card with id N', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');

        board.addCard(0, "Title", "Body");

        expect(board.columnHasCard(0, 0), equals(true));
        expect(board.columnHasCard(0, 10), equals(false));
      });
    });

    // TODO: Ask about testing encapsulated functions
    group('moveCard', () {
      test('moveCard sends a card from one column to another', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');
        board.addColumn('Column B');

        board.addCard(0, 'Title', 'Body'); // id = 0
        board.addCard(0, 'Title', 'Body'); // id = 1
        board.addCard(0, 'Title', 'Body'); // id = 2

        expect(board.columnHasCard(0, 2), equals(true));
        expect(board.columnHasCard(1, 2), equals(false));

        board.moveCard(0, 1, 2);

        expect(board.columnHasCard(0, 2), equals(false));
        expect(board.columnHasCard(1, 2), equals(true));
      });
    });

    group('deleteCard', () {
      test('deleteCard removes the expected card', () {
        var board = KanbanBoardModel();
        board.addColumn('Column A');

        board.addCard(0, 'Title', 'Body');
        board.addCard(0, 'Title', 'Body');

        expect(board.columnHasCard(0, 1), equals(true));

        board.deleteCard(0, 1);

        expect(board.columnHasCard(0, 1), equals(false));
      });
    });
  });
}
