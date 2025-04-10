import 'package:state_solver_dart/basic_search/possible_move_options/possible_move_options.dart';
import 'package:test/test.dart';

void main() {
  group('possibleMoveOptions Tests', () {
    test('Exclude a key from a list of keys', () {
      final allKeys = ['U', 'R', 'F', 'L', 'D', 'B'];
      final selectedKey = 'R';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(['U', 'F', 'L', 'D', 'B']));
    });

    test('Exclude a key that is the first element', () {
      final allKeys = ['U', 'R', 'F'];
      final selectedKey = 'U';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(['R', 'F']));
    });

    test('Exclude a key that is the last element', () {
      final allKeys = ['U', 'R', 'F'];
      final selectedKey = 'F';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(['U', 'R']));
    });

    test('Key not found in the list', () {
      final allKeys = ['U', 'R', 'F'];
      final selectedKey = 'X';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(['U', 'R', 'F']));
    });

    test('Empty list of keys', () {
      final allKeys = <String>[];
      final selectedKey = 'U';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(<String>[]));
    });

    test('Single key list', () {
      final allKeys = ['U'];
      final selectedKey = 'U';

      final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
      expect(possibleOptions, equals(<String>[]));
    });
  });
}
