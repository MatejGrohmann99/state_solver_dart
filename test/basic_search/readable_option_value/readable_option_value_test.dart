import 'package:state_solver_dart/basic_search/readable_option_value/readable_option_value.dart';
import 'package:test/test.dart';

void main() {
  group('readableOptionValue Tests', () {
    test('Clockwise move (index 0)', () {
      expect(readableOptionValue('R', 0), equals(' R'));
      expect(readableOptionValue('U', 0), equals(' U'));
      expect(readableOptionValue('F', 0), equals(' F'));
    });

    test('Double move (index 1)', () {
      expect(readableOptionValue('R', 1), equals(' R2'));
      expect(readableOptionValue('U', 1), equals(' U2'));
      expect(readableOptionValue('F', 1), equals(' F2'));
    });

    test('Counter-clockwise move (index 2)', () {
      expect(readableOptionValue('R', 2), equals(' R\''));
      expect(readableOptionValue('U', 2), equals(' U\''));
      expect(readableOptionValue('F', 2), equals(' F\''));
    });

    test('Invalid index (out of range)', () {
      expect(() => readableOptionValue('R', 3), throwsA(isA<Exception>()));
      expect(() => readableOptionValue('U', -1), throwsA(isA<Exception>()));
    });
  });
}
