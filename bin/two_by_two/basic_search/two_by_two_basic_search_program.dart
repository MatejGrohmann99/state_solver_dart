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

void main() async {
  final startTime = DateTime.now();
  final movesMap = {
    "R": rMove,
    "U": uMove,
    "F": fMove,
  };
  bool isStateSolveValidation(List<List<int>> state) {
    final content = state[0];
    for (int i = 0; i < content.length; i++) {
      if (content[i] != i) return false;
    }
    return true;
  }

  await basicSearch(
    moveDefinitions: movesMap,
    stateValidator: isStateSolveValidation,
    maxDepth: 12,
    scramble: "R U R' F' R U R' U' R' F R2 U' R'",
  );

  print('finished in ${DateTime.now().difference(startTime)}');
}
