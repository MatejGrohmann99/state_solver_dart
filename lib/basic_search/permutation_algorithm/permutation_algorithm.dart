/// Applies a row-wise permutation to a 2D list of integers (`state`) using a
/// corresponding 2D list of permutation indices.
///
/// This function returns a **new** list with the same dimensions as `state`,
/// where each element is optionally rearranged based on the provided `permutation`.
///
/// A value of `-1` in the `permutation` matrix means the original value
/// at that position remains unchanged.
///
/// Both `state` and `permutation` must have the same number of rows,
/// and each corresponding row must have the same length.
///
/// Example:
/// ```dart
/// final state = [
///   [10, 20, 30],
///   [40, 50, 60]
/// ];
///
/// final permutation = [
///   [2, 1, 0],
///   [-1, 0, 2]
/// ];
///
/// final result = permutationAlgorithm(state, permutation);
///
/// // result:
/// // [
/// //   [30, 20, 10],
/// //   [40, 40, 60]
/// // ]
/// ```
///
/// Throws:
/// - `AssertionError` if the dimensions of `state` and `permutation` do not match.
///
/// Params:
/// - [state]: A 2D list of integers to be permuted.
/// - [permutation]: A 2D list of indices for row-wise permutation.
///   Each index must be a valid position within the corresponding row or -1 to skip.
///
/// Returns:
/// A new 2D list with elements rearranged according to the permutation.
List<List<int>> permutationAlgorithm(List<List<int>> state, List<List<int>> permutation) {
  assert(state.length == permutation.length, 'state and permutation differs in list length!');

  final copyOfState = List<List<int>>.generate(state.length, (i) => List<int>.from(state[i]));

  for (int i = 0; i < permutation.length; i++) {
    final permutationRow = permutation[i];
    final stateRow = state[i];

    assert(permutationRow.length == stateRow.length, 'Rows differs in list length!');

    for (int j = 0; j < permutationRow.length; j++) {
      final index = permutationRow[j];

      if (index == -1) continue;
      copyOfState[i][j] = stateRow[index];
    }
  }

  return copyOfState;
}
