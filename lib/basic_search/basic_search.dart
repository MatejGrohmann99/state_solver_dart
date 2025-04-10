import 'package:state_solver_dart/basic_search/move_definition_key_validation/move_definition_key_validation.dart';
import 'package:state_solver_dart/basic_search/move_options/move_options.dart';
import 'package:state_solver_dart/basic_search/parse_option_value/parse_option_value.dart';
import 'package:state_solver_dart/basic_search/permutation_algorithm/permutation_algorithm.dart';
import 'package:state_solver_dart/basic_search/permutation_reflection/permutation_reflection.dart';
import 'package:state_solver_dart/basic_search/possible_move_options/possible_move_options.dart';
import 'package:state_solver_dart/basic_search/readable_option_value/readable_option_value.dart';
/// Performs a basic search algorithm to find solutions for a given state, based on provided move definitions.
///
/// This function explores possible move sequences up to a specified maximum depth
/// and returns a list of solution algorithms as strings.
///
/// Example Usage:
/// ```dart
/// import 'package:state_solver_dart/basic_search/basic_search.dart';
///
/// const uMove = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [03, 00, 01, 02, 08, 09, -1, -1, 12, 13, -1, -1, 16, 17, -1, -1, 04, 05, -1, -1, -1, -1, -1, -1],
/// ];
///
/// const rMove = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [-1, 09, 10, -1, -1, -1, -1, -1, -1, 21, 22, -1, 15, 12, 13, 14, 02, -1, -1, 01, -1, 19, 16, -1],
/// ];
///
/// const fMove = [
///   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
///   [-1, -1, 05, 06, -1, 20, 21, -1, 11, 08, 09, 10, 03, -1, -1, 02, -1, -1, -1, -1, 15, 12, -1, -1],
/// ];
///
/// void main() {
///   final startTime = DateTime.now();
///   final movesMap = {
///     "R": rMove,
///     "U": uMove,
///     // "F": fMove,
///   };
///   bool isStateSolveValidation(List<List<int>> state) {
///     final content = state[0];
///     for (int i = 0; i < content.length; i++) {
///       if (content[i] != i) return false;
///     }
///     return true;
///   }
///
///   final results = basicSearch(
///     moveDefinitions: movesMap,
///     stateValidator: isStateSolveValidation,
///     maxDepth: 9,
///     scramble: "R U2 R' U' R U R' U' R U' R'",
///   );
///
///   print('finished in ${DateTime.now().difference(startTime)}');
/// }
/// ```
///
/// Parameters:
///   - `moveDefinitions` (Map\<String, List\<List\<int>>>): A map where keys are move names
///     (e.g., "U", "R", "F") and values are lists of move definitions.
///   - `stateValidator` (bool Function(List\<List\<int>> state)): A function that takes a
///     state and returns `true` if the state is solved, `false` otherwise.
///   - `scramble` (String): A string representing the initial scramble (e.g., "R U2 R' U'").
///   - `maxDepth` (int): The maximum depth of the search algorithm.
///
/// Returns:
///   - List\<String>: A list of solution algorithms (move sequences) as strings.
///
/// Implementation Details:
///   1. Validates the move definition keys using `moveDefinitionKeyValidation`.
///   2. Creates a map of all possible move options (clockwise, double, counter-clockwise) using `moveOptions`.
///   3. Reflects the initial state based on the first move definition and applies the scramble using `permutationReflection` and `permutationAlgorithm`.
///   4. Performs a breadth-first search to find solutions up to `maxDepth`:
///     - Iterates through depths from 0 to `maxDepth`.
///     - Generates possible move sequences.
///     - Applies each move sequence to the current state using `permutationAlgorithm` and `parseOptionValue`.
///     - Checks if the resulting state is solved using the `stateValidator` function.
///     - If solved, adds the move sequence to the solutions list.
///   5. Returns the list of solutions.
///
/// Throws:
///   - Exception: If move definition keys are in invalid format.
///   - Exception: If an unexpected error occurs during move definition option map creation.
///   - Exception: If `moveOptions` generation fails.
///   - Exception: If the scramble definition is invalid.
///
/// Notes:
///   - The function throws exceptions for invalid move definitions, missing scramble data, and invalid scramble formats.
///   - The time complexity of the algorithm increases exponentially with `maxDepth`.
///   - The search algorithm explores possible move sequences in a breadth-first manner.
List<String> basicSearch({
  required Map<String, List<List<int>>> moveDefinitions,
  required bool Function(List<List<int>> state) stateValidator,
  required String scramble,
  required int maxDepth,
}) {
  final invalidCharactersRegex = RegExp(r"[' 2\s]");

  final solutions = <String>[];

  // step 1. -> validate move definitions
  final moveDefinitionKeys = moveDefinitions.keys.toList();
  final moveDefinitionKeyValidationResult = moveDefinitionKeyValidation(moveDefinitionKeys);
  if (!moveDefinitionKeyValidationResult) throw Exception('Move definition keys are in invalid format');

  final moveDefinitionOptionMap = <String, List<List<List<int>>>>{};
  // step 2. -> create full moveDefinitionOptionMap
  // create map of possible moves that contains its options
  for (var i = 0; i < moveDefinitionKeys.length; i++) {
    final key = moveDefinitionKeys[i];
    final value = moveDefinitions[key];
    if (value == null) throw Exception('Unexpected error during move definition option map creation for key $key');

    try {
      final keyMoveOptions = moveOptions(value);
      moveDefinitionOptionMap[key] = keyMoveOptions;
    } on Exception catch (e) {
      throw Exception('moveOptions generation has failed with exception ${e.toString()}');
    }
  }

  var originalState = permutationReflection(moveDefinitionOptionMap.values.first.first);
  final splitScramble = scramble.split(' ');
  for (int i = 0; i < splitScramble.length; i++) {
    final char = splitScramble[i];
    if (char.length == 1) {
      originalState = permutationAlgorithm(originalState, moveDefinitionOptionMap[char]!.first);
    } else {
      final charList = char.split('');
      if (charList.length != 2) throw Exception('Invalid scramble definition');
      final index = charList.last == '2'
          ? 1
          : charList.last == '\''
              ? 2
              : throw Exception('Invalid character in scramble definition');
      originalState = permutationAlgorithm(originalState, moveDefinitionOptionMap[charList.first]![index]);
    }
  }

  var depth = 0;
  List<String> algorithms = [];
  while (depth < maxDepth) {
    print('searching depth ${depth + 1}');
    final newSolutions = <String>[];

    /// first lets generate all possible single movers
    if (algorithms.isEmpty) {
      for (int i = 0; i < moveDefinitionKeys.length; i++) {
        final key = moveDefinitionKeys[i];
        for (int j = 0; j < 3; j++) {
          final algorithm = readableOptionValue(key, j);
          final permutation = moveDefinitionOptionMap[key]![j];
          final state = permutationAlgorithm(originalState, permutation);

          if (stateValidator(state)) {
            newSolutions.add(algorithm);
          } else {
            algorithms.add(algorithm);
          }
        }
      }
    } else {
      List<String> newAlgorithms = [];
      for (var i = 0; i < algorithms.length; i++) {
        var algorithm = algorithms[i];
        final key = algorithm.replaceAll(invalidCharactersRegex, '').split('').last;
        final possibleMoveOptionsList = possibleMoveOptions(key, moveDefinitionKeys);
        for (var j = 0; j < possibleMoveOptionsList.length; j++) {
          final key = possibleMoveOptionsList[j];
          for (int k = 0; k < 3; k++) {
            final finalAlgorithm = algorithm + readableOptionValue(key, k);
            final finalAlgorithmList = finalAlgorithm.split(' ').where((e) => e.isNotEmpty);

            var state = List<List<int>>.generate(
                originalState.length, (i) => List<int>.generate(originalState[i].length, (j) => originalState[i][j]));
            for (final alg in finalAlgorithmList) {
              final permutation = parseOptionValue(alg, moveDefinitionOptionMap);
              state = permutationAlgorithm(state, permutation);
            }
            if (stateValidator(state)) {
              newSolutions.add(finalAlgorithm);
            } else {
              newAlgorithms.add(finalAlgorithm);
            }
          }
        }
      }

      algorithms = newAlgorithms;
    }

    if (newSolutions.isEmpty) {
      print('\n No solution found yet\n');
    } else {
      for (final solution in newSolutions) {
        print(solution);
      }
      solutions.addAll(newSolutions);
    }

    depth++;
  }

  return solutions;
}
