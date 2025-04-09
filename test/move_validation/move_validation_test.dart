import 'package:state_solver_dart/move_validation/move_validation.dart';
import 'package:test/test.dart';

void main() {
  group('moveValidation Tests', () {
    test('Valid U Clockwise Move', () {
      const uClockwisePermutation = [
        // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
        [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
        [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
      ];

      expect(moveValidation(uClockwisePermutation), isTrue);
    });

    test('Invalid Move - Not Returning to Initial State', () {
      final invalidMove = [
        [1, 2, 0, -1, -1, -1],
        [3, 4, 5, -1, -1, -1],
      ];

      expect(moveValidation(invalidMove), isFalse);
    });

    test('Invalid Move - Not Returning to Identity After 4 Iterations', () {
      final invalidMove2 = [
        [1, 0, -1, -1],
        [3, 2, -1, -1],
      ];

      expect(moveValidation(invalidMove2), isFalse);
    });

    test('Move with invalid numbers', () {
      final invalidMove3 = [
        [4, 2, 0, -1, -1, -1],
        [3, 4, 1, -1, -1, -1],
      ];

      expect(moveValidation(invalidMove3), isFalse);
    });
  });
}
