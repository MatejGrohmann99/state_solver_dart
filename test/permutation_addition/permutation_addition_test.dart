import 'package:state_solver_dart/permutation_addition/permutation_addition.dart';
import 'package:test/test.dart';

void main() {
  group('permutationAddition', () {
    test('Basic permutation addition', () {
      final orderedPermutations = [
        [
          [-1, 2, 1],
          [-1, 2, 1]
        ],
        [
          [-1, 2, 1],
          [1, 0, -1]
        ]
      ];

      final result = permutationAddition(orderedPermutations: orderedPermutations);

      expect(result, [
        [-1, -1, -1],
        [2, 0, 1]
      ]);
    });

    test('Handles single permutation matrix', () {
      final orderedPermutations = [
        [
          [1, 2, 0],
          [2, 2, 0]
        ]
      ];

      final result = permutationAddition(orderedPermutations: orderedPermutations);

      expect(result, orderedPermutations.first);
    });

    test('Multiple permutations applied sequentially', () {
      final orderedPermutations = [
        [
          [1, 2, 0],
          [-1, 2, 1]
        ],
        [
          [1, 2, 0],
          [1, 0, -1]
        ]
      ];

      final result = permutationAddition(orderedPermutations: orderedPermutations);

      expect(result, [
        [2, 0, 1],
        [2, 0, 1]
      ]);
    });

    test('Edge case with identical permutations', () {
      final orderedPermutations = [
        [
          [0, 1],
          [1, 0]
        ],
        [
          [0, 1],
          [1, 0]
        ]
      ];

      final result = permutationAddition(orderedPermutations: orderedPermutations);

      expect(result, [
        [-1, -1],
        [-1, -1]
      ]);
    });

    test('Preserves original state for unchanged positions', () {
      final orderedPermutations = [
        [
          [-1, 0, 1],
          [2, -1, 1]
        ]
      ];

      final result = permutationAddition(orderedPermutations: orderedPermutations);

      expect(result, [
        [-1, 0, 1],
        [2, -1, 1]
      ]);
    });
  });
}
