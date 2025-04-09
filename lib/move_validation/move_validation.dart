import 'package:state_solver_dart/permutation_addition/permutation_addition.dart';
import 'package:state_solver_dart/permutation_algorithm/permutation_algorithm.dart';
import 'package:state_solver_dart/permutation_reflection/permutation_reflection.dart';

///
/// Every move on a 6-sided cube should return the cube back to its solved state after 4 tries.
/// Every move combined 4 times should resolve into a no permutation state (identity permutation).
///
/// This function validates if a given move definition for a 6-sided cube adheres to these properties.
///
/// Example of a U (Up) clockwise move definition:
/// ```dart
/// const uClockwisePermutation = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
///   [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
/// ];
/// ```
///
/// Returns `true` if the move definition is valid, `false` otherwise.
///
/// ```dart
/// bool isValid = moveValidation(uClockwisePermutation);
/// print(isValid); // Outputs: true or false
/// ```
///
/// Parameters:
///   - `moveDefinition`: A list of lists representing the move definition for the 6-sided cube.
///     Each inner list represents a row of the cube and contains integers representing the positions of the elements after the move.
///     The values in each inner list should be a permutation of the indices 0 to n-1, where n is the length of the inner list.
///     '-1' represents no change in the position.
///
/// Returns:
///   - `bool`: `true` if the move definition is valid, `false` otherwise.
///
/// Implementation Details:
///   1. `permutationReflection(moveDefinition)`: Reflects the move definition to get the initial state of the cube.
///   2. `permutationAlgorithm(stateCopy, moveDefinition)`: Applies the move definition to the current state of the cube.
///   3. The function iterates 4 times, applying the move definition each time, and checks if the cube returns to its initial state.
///   4. `permutationAddition(orderedPermutations: [moveDefinition, moveDefinition, moveDefinition, moveDefinition])`:
///      Combines the move definition 4 times to check if it results in a no permutation state (identity permutation).
///   5. A no permutation state is represented by a list of lists where each element is -1.
///
/// Usage:
/// ```dart
/// const uClockwisePermutation = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
///   [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
/// ];
///
/// bool isValid = moveValidation(uClockwisePermutation);
/// print(isValid); // Outputs: true if the move is valid
/// ```
bool moveValidation(List<List<int>> moveDefinition) {
  final state = permutationReflection(moveDefinition);
  var stateCopy = List<List<int>>.generate(state.length, (i) => List<int>.from(state[i]));

  for (int i = 0; i < 4; i++) {
    stateCopy = permutationAlgorithm(stateCopy, moveDefinition);
  }

  for (var i = 0; i < state.length; i++) {
    final row = state[i];
    final copyRow = stateCopy[i];
    for (var j = 0; j < row.length; j++) {
      if (row[j] != copyRow[j]) return false;
    }
  }

  final noPermutationPermutation = permutationAddition(
    orderedPermutations: [moveDefinition, moveDefinition, moveDefinition, moveDefinition],
  );

  for (var i = 0; i < noPermutationPermutation.length; i++) {
    final row = noPermutationPermutation[i];
    for (var j = 0; j < row.length; j++) {
      if (row[j] != -1) return false;
    }
  }

  return true;
}
