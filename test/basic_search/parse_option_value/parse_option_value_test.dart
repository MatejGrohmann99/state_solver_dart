import 'package:state_solver_dart/basic_search/parse_option_value/parse_option_value.dart';
import 'package:test/test.dart';

void main() {
  group('parseOptionValue Tests', () {
    final moveMap = {
      'U': [
        [
          [3, 0, 1, 2, 8, 9, -1, -1, 12, 13, -1, -1, 16, 17, -1, -1, 4, 5, -1, -1, -1, -1, -1, -1]
        ],
        [
          [2, 3, 0, 1, 12, 13, -1, -1, 16, 17, -1, -1, 4, 5, -1, -1, 8, 9, -1, -1, -1, -1, -1, -1]
        ],
        [
          [1, 2, 3, 0, 16, 17, -1, -1, 4, 5, -1, -1, 8, 9, -1, -1, 12, 13, -1, -1, -1, -1, -1, -1]
        ]
      ],
      'R': [
        [
          [-1, 9, 10, -1, -1, -1, -1, -1, -1, 21, 22, -1, 15, 12, 13, 14, 2, -1, -1, 1, -1, 19, 16, -1]
        ],
        [
          [-1, 21, 22, -1, -1, -1, -1, -1, -1, 19, 16, -1, 14, 15, 12, 13, 10, -1, -1, 9, -1, 1, 2, -1]
        ],
        [
          [-1, 19, 16, -1, -1, -1, -1, -1, -1, 1, 2, -1, 13, 14, 15, 12, 22, -1, -1, 21, -1, 9, 10, -1]
        ]
      ],
      'F': [
        [
          [-1, -1, 5, 6, -1, 20, 21, -1, 11, 8, 9, 10, 3, -1, -1, 2, -1, -1, -1, -1, 15, 12, -1, -1]
        ],
        [
          [-1, -1, 20, 21, -1, 15, 12, -1, 10, 11, 8, 9, 6, -1, -1, 5, -1, -1, -1, -1, 2, 3, -1, -1]
        ],
        [
          [-1, -1, 15, 12, -1, 2, 3, -1, 9, 10, 11, 8, 21, -1, -1, 20, -1, -1, -1, -1, 5, 6, -1, -1]
        ]
      ],
    };

    test('Clockwise move (single key)', () {
      expect(parseOptionValue('U', moveMap), equals(moveMap['U']![0]));
      expect(parseOptionValue('R', moveMap), equals(moveMap['R']![0]));
      expect(parseOptionValue('F', moveMap), equals(moveMap['F']![0]));
    });

    test('Double move (key + "2")', () {
      expect(parseOptionValue('U2', moveMap), equals(moveMap['U']![1]));
      expect(parseOptionValue('R2', moveMap), equals(moveMap['R']![1]));
      expect(parseOptionValue('F2', moveMap), equals(moveMap['F']![1]));
    });

    test('Counter-clockwise move (key + "\'")', () {
      expect(parseOptionValue('U\'', moveMap), equals(moveMap['U']![2]));
      expect(parseOptionValue('R\'', moveMap), equals(moveMap['R']![2]));
      expect(parseOptionValue('F\'', moveMap), equals(moveMap['F']![2]));
    });

    test('Invalid key', () {
      expect(() => parseOptionValue('X', moveMap), throwsA(isA<Exception>()));
      expect(() => parseOptionValue('X2', moveMap), throwsA(isA<Exception>()));
      expect(() => parseOptionValue('X\'', moveMap), throwsA(isA<Exception>()));
    });

    test('Invalid variant', () {
      expect(() => parseOptionValue('U3', moveMap), throwsA(isA<Exception>()));
      expect(() => parseOptionValue('R1', moveMap), throwsA(isA<Exception>()));
      expect(() => parseOptionValue('F?', moveMap), throwsA(isA<Exception>()));
    });
  });
}
