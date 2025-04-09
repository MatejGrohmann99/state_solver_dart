import 'package:state_solver_dart/move_validation/move_validation.dart';

import '../permutation_addition/permutation_addition.dart';

///
/// Generates a list of move options based on a given clockwise move definition.
///
/// This function takes a valid clockwise move definition and returns a list containing:
/// 1. The clockwise move itself.
/// 2. The double move (applying the clockwise move twice).
/// 3. The counter-clockwise move (applying the clockwise move three times).
///
/// It ensures the provided move definition is valid using `moveValidation` before generating the options.
///
/// Example of a U (Up) move options generation:
/// ```dart
/// const uClockwisePermutation = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
///   [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
/// ];
///
/// const uCounterClockwisePermutation = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [01, 02, 03, 00, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
///   [02, 03, 04, 05, 06, 07, 00, 01, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
/// ];
///
/// const uDoublePermutation = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [02, 03, 00, 01, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
///   [04, 05, 06, 07, 00, 01, 02, 03, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
/// ];
///
/// final moveOptions = moveOptions(uClockwisePermutation);
/// print(moveOptions);
/// // Output: [
/// //   uClockwisePermutation,
/// //   uDoublePermutation,
/// //   uCounterClockwisePermutation,
/// // ]
/// ```
///
/// Parameters:
///   - `moveDefinition`: A list of lists representing a valid clockwise move definition.
///     Each inner list represents a row of the cube and contains integers representing the positions of the elements after the move.
///     The values in each inner list should be a permutation of the indices 0 to n-1, where n is the length of the inner list.
///     '-1' represents no change in the position.
///
/// Returns:
///   - `List<List<List<int>>>`: A list containing the clockwise move, double move, and counter-clockwise move definitions.
///
/// Throws:
///   - `Exception`: If the provided `moveDefinition` is not a valid move (as determined by `moveValidation`).
///
/// Implementation Details:
///   1. `moveValidation(moveDefinition)`: Validates the provided move definition.
///   2. `permutationAddition(orderedPermutations: [moveDefinition])`: Generates the clockwise move (same as input).
///   3. `permutationAddition(orderedPermutations: [moveDefinition, moveDefinition])`: Generates the double move.
///   4. `permutationAddition(orderedPermutations: [moveDefinition, moveDefinition, moveDefinition])`: Generates the counter-clockwise move.
List<List<List<int>>> moveOptions(List<List<int>> moveDefinition) {
  final validation = moveValidation(moveDefinition);
  if (!validation) throw Exception('provided move definition is not valid move!');

  final clockwiseDefinition = permutationAddition(orderedPermutations: [moveDefinition]);
  final doubleDefinition = permutationAddition(orderedPermutations: [moveDefinition, moveDefinition]);
  final counterClockwiseDefinition =
      permutationAddition(orderedPermutations: [moveDefinition, moveDefinition, moveDefinition]);

  return [
    clockwiseDefinition,
    doubleDefinition,
    counterClockwiseDefinition,
  ];
}
