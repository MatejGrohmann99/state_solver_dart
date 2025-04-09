 # basicSearch

 Performs a basic search algorithm to find solutions for a given state, based on provided move definitions.

 ## Function Signature

 ```dart
  List<String> basicSearch({
  required Map<String, List<List<int>>> moveDefinitions,
  required bool Function(List<List<int>> state) stateValidator,
  required String scramble,
  required int maxDepth,
  });
  ```

 ## Parameters

 - **`moveDefinitions`** (`Map<String, List<List<int>>>`):
 A map where keys are move names (e.g., "U", "R", "F") and values are lists of move definitions.
 - **`stateValidator`** (`bool Function(List<List<int>> state)`):
 A function that takes a state and returns `true` if the state is solved, `false` otherwise.
 - **`scramble`** (`String`):
 A string representing the initial scramble (e.g., "R U2 R' U'").
 - **`maxDepth`** (`int`):
 The maximum depth of the search algorithm.

 ## Returns

 - `List<String>`: A list of solution algorithms (move sequences) as strings.

 ## Description

 This function performs a basic search algorithm to find solutions for a given state, based on the provided move definitions and scramble. It explores possible move sequences up to a specified maximum depth and returns a list of solutions.

 ### Process:

 1.  **Validation**: Validates the move definition keys.
 2.  **Move Option Map Creation**: Generates a map of all possible move options (clockwise, double, counter-clockwise).
 3.  **Initial State**: Reflects the initial state based on the first move definition and applies the scramble.
 4.  **Search Loop**:
 5.  Returns the list of solutions.

 #### Search loop details

- Iterates through depths from 0 to `maxDepth`.
- Generates possible move sequences.
- Applies each move sequence to the current state.
- Checks if the resulting state is solved using the `stateValidator` function.
- If solved, adds the move sequence to the solutions list.

 ## Example Usage

 ```dart
  import 'package:state_solver_dart/basic_search/basic_search.dart';
 
  const uMove = [
  // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [03, 00, 01, 02, 08, 09, -1, -1, 12, 13, -1, -1, 16, 17, -1, -1, 04, 05, -1, -1, -1, -1, -1, -1],
  ];
 
  const rMove = [
  // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, 09, 10, -1, -1, -1, -1, -1, -1, 21, 22, -1, 15, 12, 13, 14, 02, -1, -1, 01, -1, 19, 16, -1],
  ];
 
  const fMove = [
  // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
  [-1, -1, 05, 06, -1, 20, 21, -1, 11, 08, 09, 10, 03, -1, -1, 02, -1, -1, -1, -1, 15, 12, -1, -1],
  ];
 
  void main() {
  final startTime = DateTime.now();
  final movesMap = {
  "R": rMove,
  "U": uMove,
  // "F": fMove,
  };
  bool isStateSolveValidation(List<List<int>> state) {
  final content = state[0];
  for (int i = 0; i < content.length; i++) {
  if (content[i] != i) return false;
  }
  return true;
  }
 
  final results = basicSearch(
  moveDefinitions: movesMap,
  stateValidator: isStateSolveValidation,
  maxDepth: 9,
  scramble: "R U2 R' U' R U R' U' R U' R'",
  );
 
  print('finished in ${DateTime.now().difference(startTime)}');
  }
 ```

 ## Implementation Details

 1.  **Move Definition Validation**: Uses `moveDefinitionKeyValidation` to ensure valid move keys.
 2.  **Move Option Map**: Creates a map with move keys and their possible move options using `moveOptions`.
 3.  **Initial State**: Generates an initial state using `permutationReflection` and applies the scramble.
 4.  **Search**: Performs a breadth-first search to find solutions up to `maxDepth`.
 5.  **Move Application**: Applies move sequences using `permutationAlgorithm` and `parseOptionValue`.
 6.  **Solution Validation**: Checks for solved states using the provided `stateValidator`.
 7.  **Result**: Returns a list of solution algorithms as strings.

 ## Notes

 -   The function throws exceptions for invalid move definitions, missing scramble data, and invalid scramble formats.
 -   The time complexity of the algorithm increases exponentially with `maxDepth`.
 -   The search algorithm explores possible move sequences in a breadth-first manner.