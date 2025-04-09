import 'package:state_solver_dart/permutation_algorithm/permutation_algorithm.dart';
import 'package:test/test.dart';


void main() {
  group('permutationAlgorithm', () {
    test('Basic permutation', () {
      final state = [
        [10, 20, 30],
        [40, 50, 60]
      ];

      final permutation = [
        [2, 1, 0],
        [-1, 0, 2]
      ];

      final result = permutationAlgorithm(state, permutation);

      expect(result, [
        [30, 20, 10],
        [40, 40, 60]
      ]);
    });

    test('Identity permutation (no change)', () {
      final state = [
        [1, 2, 3],
        [4, 5, 6]
      ];

      final permutation = [
        [0, 1, 2],
        [0, 1, 2]
      ];

      final result = permutationAlgorithm(state, permutation);

      expect(result, equals(state));
    });

    test('Handles -1 (no change at that index)', () {
      final state = [
        [7, 8, 9],
        [10, 11, 12]
      ];

      final permutation = [
        [-1, 2, 1],
        [1, -1, 0]
      ];

      final result = permutationAlgorithm(state, permutation);

      expect(result, [
        [7, 9, 8],
        [11, 11, 10]
      ]);
    });

    test('Throws assertion error on mismatched outer length', () {
      final state = [
        [1, 2],
        [3, 4]
      ];

      final permutation = [
        [0, 1]
      ];

      expect(() => permutationAlgorithm(state, permutation), throwsA(isA<AssertionError>()));
    });

    test('Throws assertion error on mismatched inner row length', () {
      final state = [
        [1, 2],
        [3, 4]
      ];

      final permutation = [
        [0, 1],
        [1]
      ];

      expect(() => permutationAlgorithm(state, permutation), throwsA(isA<AssertionError>()));
    });
  });
}
