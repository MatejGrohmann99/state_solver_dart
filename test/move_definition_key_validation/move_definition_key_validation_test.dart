import 'package:state_solver_dart/move_definition_key_validation/move_definition_key_validation.dart';
import 'package:test/test.dart';

void main() {
  group('moveDefinitionKeyValidation', () {
    test('verify keys do contain 2', () {
      final moveDefinitions = [
        'U',
        'R2',
        'F ',
      ];

      final validation = moveDefinitionKeyValidation(moveDefinitions);
      expect(validation, isFalse);
    });

    test('verify keys do contain \'', () {
      final moveDefinitions = [
        "U'",
        'R',
        'F ',
      ];

      final validation = moveDefinitionKeyValidation(moveDefinitions);
      expect(validation, isFalse);
    });

    test('verify keys do contain spaces', () {
      final moveDefinitions = [
        'U',
        'R',
        ' F ',
      ];

      final validation = moveDefinitionKeyValidation(moveDefinitions);
      expect(validation, isFalse);
    });

    test('verify valid keys', () {
      final moveDefinitions = [
        'U',
        'R',
        'F',
        'B',
        'D',
        'L',
        'Rw',
        'Lw',
        'r',
      ];

      final validation = moveDefinitionKeyValidation(moveDefinitions);
      expect(validation, isTrue);
    });

    test('Subtract', () {
      final keysRegex = RegExp(r"[^'\s](?=[^'\s]*$)");
      final string = 'L\' U2 L U R R U2\'';
      final matcher = keysRegex.firstMatch(string)?.group(1);
      print(matcher);
    });
  });
}
