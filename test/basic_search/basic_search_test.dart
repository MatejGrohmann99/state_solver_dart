import 'package:state_solver_dart/basic_search/basic_search.dart';
import 'package:test/test.dart';

void main() {
  group('basic search', () {
    const uMove = [
      [3, 0, 1, 2, 8, 9, -1, -1, 12, 13, -1, -1, 16, 17, -1, -1, 4, 5, -1, -1, -1, -1, -1, -1],
    ];

    const rMove = [
      [-1, 9, 10, -1, -1, -1, -1, -1, -1, 21, 22, -1, 15, 12, 13, 14, 2, -1, -1, 1, -1, 19, 16, -1],
    ];

    const fMove = [
      [-1, -1, 5, 6, -1, 20, 21, -1, 11, 8, 9, 10, 3, -1, -1, 2, -1, -1, -1, -1, 15, 12, -1, -1],
    ];

    test('2x2 2-gen smoke test', () {
      final movesMap = {
        "R": rMove,
        "U": uMove,
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
        maxDepth: 8,
        scramble: "U R U2 R' U' R U R' U' R U' R'",
      );

      expect(results, contains(' U R2 U2 R U2 R2 U\''));
      expect(results, contains(' U R2 U2 R\' U2 R2 U'));
      expect(results, contains(' U\' R2 U2 R U2 R2 U'));
      expect(results, contains(' U\' R2 U2 R\' U2 R2 U\''));
    });

    test('2x2 3-gen smoke test', () {
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

      final results = basicSearch(
        moveDefinitions: movesMap,
        stateValidator: isStateSolveValidation,
        maxDepth: 5,
        scramble: "R U R' F' U2",
      );

      expect(results, contains(' R\' F\' R F U2'));
      expect(results, contains(' U2 F R U\' R\''));
    });
  });
}
