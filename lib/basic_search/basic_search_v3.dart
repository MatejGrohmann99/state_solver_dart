import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:state_solver_dart/basic_search/move_definition_key_validation/move_definition_key_validation.dart';
import 'package:state_solver_dart/basic_search/move_options/move_options.dart';
import 'package:state_solver_dart/basic_search/parse_option_value/parse_option_value.dart';
import 'package:state_solver_dart/basic_search/permutation_algorithm/permutation_algorithm.dart';
import 'package:state_solver_dart/basic_search/permutation_reflection/permutation_reflection.dart';
import 'package:state_solver_dart/basic_search/possible_move_options/possible_move_options.dart';
import 'package:state_solver_dart/basic_search/readable_option_value/readable_option_value.dart';


late List<List<int>> originalState;

final invalidCharactersRegex = RegExp(r"[' 2\s]");

late final List<String> moveDefinitionKeys;

final Map<String, List<List<List<int>>>> moveDefinitionOptionMap =  <String, List<List<List<int>>>>{};

late bool Function(List<List<int>> state) stateValidator;

List<String> algorithms = [];

Future<List<String>> basicSearchV3({
  required Map<String, List<List<int>>> moveDefinitions,
  required bool Function(List<List<int>> state) stateValidatorDefinition,
  required String scramble,
  required int maxDepth,
}) async {
  stateValidator = stateValidatorDefinition;
  final solutions = <String>[];

  // step 1. -> validate move definitions
  moveDefinitionKeys = moveDefinitions.keys.toList();
  final moveDefinitionKeyValidationResult = moveDefinitionKeyValidation(moveDefinitionKeys);
  if (!moveDefinitionKeyValidationResult) throw Exception('Move definition keys are in invalid format');

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

  originalState = permutationReflection(moveDefinitionOptionMap.values.first.first);
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
      await _parallelExpand();
    }

    depth++;
  }

  return solutions;
}


Future<void> _parallelExpand() async {
  final numCores = Platform.numberOfProcessors;

  final chunkSize = (algorithms.length / numCores).ceil();
  final chunks = <List<String>>[];
  for (int i = 0; i < algorithms.length; i += chunkSize) {
    chunks.add(algorithms.sublist(i, min(i + chunkSize, algorithms.length)));
  }

  final receivePort = ReceivePort();
  final isolateResults = <Future<List<String>>>[];

  for (final chunk in chunks) {
    isolateResults.add(_spawnWorker(
      chunk,
      originalState,
      moveDefinitionKeys,
      moveDefinitionOptionMap,
      stateValidator,
      invalidCharactersRegex,
      receivePort.sendPort,
    ));
  }

  final results = await Future.wait(isolateResults);
  final allNextAlgorithms = results.expand((r) => r).toList();

  receivePort.close();
  algorithms = allNextAlgorithms;
}

Future<List<String>> _spawnWorker(
    List<String> chunk,
    List<List<int>> originalState,
    List<String> moveDefinitionKeys,
    Map<String, List<List<List<int>>>> moveDefinitionOptionMap,
    bool Function(List<List<int>> state) stateValidator,
    RegExp invalidCharactersRegex,
    SendPort sendPort,
    ) async {
  final resultPort = ReceivePort();
  await Isolate.spawn(_searchWorker, [chunk, originalState, moveDefinitionKeys, moveDefinitionOptionMap, stateValidator, invalidCharactersRegex, resultPort.sendPort]);
  final results = await resultPort.first;

  for (final res in (results as List)[1] as List) {
    print(res);
  }

  return (results as List)[0] as List<String>;
}

void _searchWorker(List<dynamic> args) {
  final chunk = args[0] as List<String>;
  final originalState = args[1] as List<List<int>>;
  final moveDefinitionKeys = args[2] as List<String>;
  final moveDefinitionOptionMap = args[3] as Map<String, List<List<List<int>>>>;
  final stateValidator = args[4] as bool Function(List<List<int>>);
  final invalidCharactersRegex = args[5] as RegExp;
  final sendPort = args[6] as SendPort;

  final results = <String>[];
  final solutions = <String>[];
  for (final algorithm in chunk) {
    final key = algorithm.replaceAll(invalidCharactersRegex, '').split('').last;
    final nextMoves = possibleMoveOptions(key, moveDefinitionKeys);

    var stateOrigin = List<List<int>>.generate(originalState.length, (i) => List<int>.from(originalState[i]));
    final steps = algorithm.split(' ').where((e) => e.isNotEmpty);
    for (final step in steps) {
      final permutation = parseOptionValue(step, moveDefinitionOptionMap);
      stateOrigin = permutationAlgorithm(stateOrigin, permutation);
    }

    for (final move in nextMoves) {
      for (int k = 0; k < 3; k++) {
        final permutation = moveDefinitionOptionMap[move]![k];
        final newAlg = '$algorithm ${readableOptionValue(move, k)}';
        var state = List<List<int>>.generate(originalState.length, (i) => List<int>.from(stateOrigin[i]));
        state = permutationAlgorithm(state, permutation);
        if (stateValidator(state)) {
          solutions.add(newAlg);
        } else {
          results.add(newAlg);
        }
      }
    }
  }

  sendPort.send([results, solutions]);
}
