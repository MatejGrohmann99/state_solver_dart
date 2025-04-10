/// Generates a readable string representation of a move option based on a given key and index.
///
/// This helper function takes a move key (e.g., 'U', 'R', 'F') and an index representing the move variant
/// (0 for clockwise, 1 for double, 2 for counter-clockwise) and returns a formatted string.
///
/// Example:
/// ```dart
/// final clockwiseR = readableOptionValue('R', 0); // Returns ' R'
/// final doubleR = readableOptionValue('R', 1); // Returns ' R2'
/// final counterClockwiseR = readableOptionValue('R', 2); // Returns ' R''
///
/// print(clockwiseR); // Output:  R
/// print(doubleR); // Output:  R2
/// print(counterClockwiseR); // Output:  R'
/// ```
///
/// Parameters:
///   - `key`: The move key (e.g., 'U', 'R', 'F').
///   - `index`: An integer representing the move variant:
///     - 0: Clockwise move (no suffix).
///     - 1: Double move ('2' suffix).
///     - 2: Counter-clockwise move ('\'' suffix).
///
/// Returns:
///   - `String`: A formatted string representing the move option (e.g., ' R', ' R2', ' R'').
///
/// Throws:
///   - `Exception`: If the provided `index` is not 0, 1, or 2, indicating an invalid index.
///
/// Implementation Details:
///   1. A `switch` statement is used to determine the suffix based on the provided `index`.
///   2. The suffix is appended to the move `key` to create the readable string.
///   3. The string is returned with a leading space for consistent formatting.
String readableOptionValue(String key, int index) {
  final end = switch (index) {
    0 => '',
    1 => '2',
    2 => '\'',
    _ => throw Exception('Invalid index out of range when trying to create readable option'),
  };
  return ' $key$end';
}
