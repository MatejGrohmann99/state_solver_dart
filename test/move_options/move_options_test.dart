import 'package:test/test.dart';
import 'package:state_solver_dart/move_options/move_options.dart';

void main() {
  group('getMoveOptions Tests', () {
    test('U Permutation Options', () {
      final options = getMoveOptions(uClockwisePermutation);
      expect(options[0], equals(uClockwisePermutation));
      expect(options[1], equals(uDoublePermutation));
      expect(options[2], equals(uCounterClockwisePermutation));
    });

    test('F Permutation Options', () {
      final options = getMoveOptions(fClockwisePermutation);
      expect(options[0], equals(fClockwisePermutation));
      expect(options[1], equals(fDoublePermutation));
      expect(options[2], equals(fCounterClockwisePermutation));
    });

    test('R Permutation Options', () {
      final options = getMoveOptions(rClockwisePermutation);
      expect(options[0], equals(rClockwisePermutation));
      expect(options[1], equals(rDoublePermutation));
      expect(options[2], equals(rCounterClockwisePermutation));
    });

    test('Invalid move definition throws exception', () {
      final invalidMove = [
        [1, 2, 0, -1],
      ];
      expect(() => getMoveOptions(invalidMove), throwsA(isA<Exception>()));
    });
  });
}

const uClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
];

const uCounterClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [01, 02, 03, 00, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [02, 03, 04, 05, 06, 07, 00, 01, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
];

const uDoublePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [02, 03, 00, 01, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [04, 05, 06, 07, 00, 01, 02, 03, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
];

const fClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, 11, 08, 09, 10, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 10, 11, -1, -1, -1, -1, 16, 17, 05, 04, -1, -1, 13, 12, -1, -1, -1, -1, -1, -1],
];

const fCounterClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, 09, 10, 11, 08, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 13, 12, -1, -1, -1, -1, 04, 05, 17, 16, -1, -1, 10, 11, -1, -1, -1, -1, -1, -1],
];

const fDoublePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, 10, 11, 08, 09, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 16, 17, -1, -1, -1, -1, 13, 12, 11, 10, -1, -1, 04, 05, -1, -1, -1, -1, -1, -1],
];

const rClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 15, 12, 13, 14, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, 12, 13, -1, -1, -1, -1, -1, -1, -1, -1, 18, 19, 03, 02, -1, -1, 15, 14, -1, -1, -1, -1],
];

const rCounterClockwisePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 13, 14, 15, 12, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, 15, 14, -1, -1, -1, -1, -1, -1, -1, -1, 02, 03, 19, 18, -1, -1, 12, 13, -1, -1, -1, -1],
];

const rDoublePermutation = [
// 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 14, 15, 12, 13, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, 18, 19, -1, -1, -1, -1, -1, -1, -1, -1, 15, 14, 13, 12, -1, -1, 02, 03, -1, -1, -1, -1],
];
