import 'package:state_solver_dart/move_definition_key_validation/move_definition_key_validation.dart';
import 'package:state_solver_dart/move_options/move_options.dart';
import 'package:state_solver_dart/permutation_algorithm/permutation_algorithm.dart';
import 'package:state_solver_dart/permutation_reflection/permutation_reflection.dart';

import '../possible_move_options/possible_move_options.dart';
import '../readable_option_value/readable_option_value.dart';

/// response is list of algorithms found
List<String> basicSearch({
  /// map of moves, string is key of the move used int the response
  required Map<String, List<List<int>>> moveDefinitions,

  /// validates if state is "solved"
  required bool Function(List<List<int>> state) stateValidator,

  /// Scramble
  required String scramble,

  /// Max length of solution
  required int maxDepth,
}) {
  final invalidCharactersRegex = RegExp(r"[' 2\s]");

  /// get key from algorithm
  /// will return key from last algorithm
  ///
  String getLastMoveKey(String algorithm) {
    return algorithm.replaceAll(invalidCharactersRegex, '').split('').last;
  }

  List<List<int>> parseOptionValue(String value, Map<String, List<List<List<int>>>> map) {
    final valueList = value.split('');
    if (valueList.length == 1) {
      return map[value]![0];
    } else {
      final key = valueList.first;
      final lastChar = valueList.last;
      if (lastChar == '2') {
        return map[key]![1];
      }
      if (lastChar == '\'') {
        return map[key]![2];
      }
    }
    throw Exception('Error parsing option value $value');
  }

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

  /// helper function to get new copy of state
  List<List<int>> getNewState() {
    return List<List<int>>.generate(
        originalState.length, (i) => List<int>.generate(originalState[i].length, (j) => originalState[i][j]));
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
          final state = permutationAlgorithm(getNewState(), permutation);

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
        final possibleMoveOptionsList = possibleMoveOptions(getLastMoveKey(algorithm), moveDefinitionKeys);
        for (var j = 0; j < possibleMoveOptionsList.length; j++) {
          final key = possibleMoveOptionsList[j];
          for (int k = 0; k < 3; k++) {
            final finalAlgorithm = algorithm + readableOptionValue(key, k);
            final finalAlgorithmList = finalAlgorithm.split(' ').where((e) => e.isNotEmpty);

            var state = getNewState();
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
