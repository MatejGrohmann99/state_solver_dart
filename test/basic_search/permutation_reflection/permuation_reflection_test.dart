import 'package:state_solver_dart/basic_search/permutation_reflection/permutation_reflection.dart';
import 'package:test/test.dart';

void main() {
  group('permutationReflection', () {
    test('Generates identity matrix of matching shape', () {
      final permutation = [
        [2, 1, 0],
        [-1, 0, 2]
      ];

      final result = permutationReflection(permutation);

      expect(result, [
        [0, 1, 2],
        [0, 1, 2]
      ]);
    });

    test('Handles empty permutation matrix', () {
      final permutation = <List<int>>[];

      final result = permutationReflection(permutation);

      expect(result, []);
    });

    test('Handles rows of varying lengths', () {
      final permutation = [
        [0, 1],
        [2, 3, 4],
        [5]
      ];

      final result = permutationReflection(permutation);

      expect(result, [
        [0, 1],
        [0, 1, 2],
        [0]
      ]);
    });

    test('Does not modify original permutation', () {
      final permutation = [
        [3, 2],
        [1, -1]
      ];

      final original = List<List<int>>.from(permutation.map((row) => List<int>.from(row)));
      permutationReflection(permutation);

      expect(permutation, original);
    });
  });
}
