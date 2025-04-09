/// Parses a move option string and retrieves the corresponding permutation matrix from a map.
///
/// This function takes a move option string (e.g., "U", "R2", "F'") and a map containing move definitions
/// as input. It extracts the move key and variant from the string and retrieves the corresponding
/// permutation matrix from the map.
///
/// Example:
/// ```dart
/// final moveMap = {
///   'U': [
///     [[3, 0, 1, 2, 8, 9, -1, -1, 12, 13, -1, -1, 16, 17, -1, -1, 4, 5, -1, -1, -1, -1, -1, -1]], // Clockwise U
///     [[2, 3, 0, 1, 12, 13, -1, -1, 16, 17, -1, -1, 4, 5, -1, -1, 8, 9, -1, -1, -1, -1, -1, -1]], // Double U
///     [[1, 2, 3, 0, 16, 17, -1, -1, 4, 5, -1, -1, 8, 9, -1, -1, 12, 13, -1, -1, -1, -1, -1, -1]] // Counter-clockwise U
///   ],
///   'R': [
///     [[-1, 9, 10, -1, -1, -1, -1, -1, -1, 21, 22, -1, 15, 12, 13, 14, 2, -1, -1, 1, -1, 19, 16, -1]], // Clockwise R
///     [[-1, 21, 22, -1, -1, -1, -1, -1, -1, 19, 16, -1, 14, 15, 12, 13, 10, -1, -1, 9, -1, 1, 2, -1]], // Double R
///     [[-1, 19, 16, -1, -1, -1, -1, -1, -1, 1, 2, -1, 13, 14, 15, 12, 22, -1, -1, 21, -1, 9, 10, -1]] // Counter-clockwise R
///   ],
///   'F': [
///     [[-1, -1, 5, 6, -1, 20, 21, -1, 11, 8, 9, 10, 3, -1, -1, 2, -1, -1, -1, -1, 15, 12, -1, -1]], // Clockwise F
///     [[-1, -1, 20, 21, -1, 15, 12, -1, 10, 11, 8, 9, 6, -1, -1, 5, -1, -1, -1, -1, 2, 3, -1, -1]], // Double F
///     [[-1, -1, 15, 12, -1, 2, 3, -1, 9, 10, 11, 8, 21, -1, -1, 20, -1, -1, -1, -1, 5, 6, -1, -1]] // Counter-clockwise F
///   ],
/// };
///
/// final clockwiseU = parseOptionValue('U', moveMap); // Returns moveMap['U'][0]
/// final doubleR = parseOptionValue('R2', moveMap); // Returns moveMap['R'][1]
/// final counterClockwiseF = parseOptionValue('F\'', moveMap); // Returns moveMap['F'][2]
///
/// print(clockwiseU);
/// print(doubleR);
/// print(counterClockwiseF);
/// ```
///
/// Parameters:
///   - `value`: The move option string to parse (e.g., "U", "R2", "F'").
///   - `map`: A map where the keys are move keys (e.g., "U", "R", "F") and the values are lists of permutation matrices,
///            where each list contains the clockwise, double, and counter-clockwise move variants, respectively.
///
/// Returns:
///   - `List<List<int>>`: The permutation matrix corresponding to the parsed move option.
///
/// Throws:
///   - `Exception`: If the move key is not found in the map or if the move option string is invalid.
///
/// Implementation Details:
///   1. The input `value` string is split into a list of characters.
///   2. If the list has only one character, it's assumed to be a clockwise move, and the corresponding
///      permutation matrix is retrieved from the map at index 0.
///   3. If the list has more than one character, the first character is the move key, and the last
///      character is the move variant ('2' for double, '\'' for counter-clockwise).
///   4. The corresponding permutation matrix is retrieved from the map based on the key and variant.
///   5. If the key is not found in the map or if the variant is invalid, an exception is thrown.
List<List<int>> parseOptionValue(String value, Map<String, List<List<List<int>>>> map) {
  final valueList = value.split('');
  if (valueList.length == 1) {
    if (!map.containsKey(value)) {
      throw Exception('Key was not found in the map provided, $value');
    }
    return map[value]![0];
  } else {
    final key = valueList.first;
    final lastChar = valueList.last;

    if (!map.containsKey(key)) {
      throw Exception('Key was not found in the map provided, $key');
    }

    if (lastChar == '2') {
      return map[key]![1];
    }
    if (lastChar == '\'') {
      return map[key]![2];
    }
  }
  throw Exception('Error parsing option value $value');
}
