import 'package:state_solver_dart/basic_search/move_options/move_options.dart';

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

  print('U MOVE OPTIONS: \n${moveOptions(uMove)} \n');
  print('R MOVE OPTIONS: \n${moveOptions(rMove)} \n');
  print('F MOVE OPTIONS: \n${moveOptions(fMove)} \n');
}
