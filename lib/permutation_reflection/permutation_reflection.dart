/// Generates a default identity state matrix based on the shape of the given
/// `permutation` matrix.
///
/// Each row in the returned 2D list contains sequential integers starting
/// from `0` up to the length of that row minus one.
///
/// This function is useful when you want to initialize a `state` matrix
/// that matches the shape of an existing `permutation` matrix, with default
/// values representing their own indices.
///
/// Example:
/// ```dart
/// final permutation = [
///   [2, 1, 0],
///   [-1, 0, 2]
/// ];
///
/// final state = permutationStateReflection(permutation);
///
/// // state:
/// // [
/// //   [0, 1, 2],
/// //   [0, 1, 2]
/// // ]
/// ```
///
/// Params:
/// - [permutation]: A 2D list of integers used only for size reference.
///
/// Returns:
/// A new 2D list of integers with the same dimensions as [permutation],
/// where each row is an identity sequence: `[0, 1, 2, ..., n - 1]`.
List<List<int>> permutationReflection(List<List<int>> permutation) {
  return List<List<int>>.generate(permutation.length, (i) => List<int>.generate(permutation[i].length, (i) => i));
}
