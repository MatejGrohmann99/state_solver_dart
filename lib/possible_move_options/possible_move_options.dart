/// Retrieves a list of possible move options by excluding a specified key from a given list of keys.
///
/// This helper function takes a key and a list of keys as input and returns a new list
/// containing all keys from the input list except the specified key. This is useful for
/// generating a list of available move options when a particular move has already been selected.
///
/// Example:
/// ```dart
/// final allKeys = ['U', 'R', 'F', 'L', 'D', 'B'];
/// final selectedKey = 'R';
///
/// final possibleOptions = possibleMoveOptions(selectedKey, allKeys);
/// print(possibleOptions); // Output: [U, F, L, D, B]
/// ```
///
/// Parameters:
///   - `key`: The key to be excluded from the list of possible move options.
///   - `keys`: A list of strings representing all possible move options.
///
/// Returns:
///   - `List<String>`: A new list containing all keys from the input `keys` list, excluding the specified `key`.
///
/// Implementation Details:
///   1. The function uses the `where` method to filter the input `keys` list, excluding the specified `key`.
///   2. The filtered result is converted to a new list using `List<String>.from()`.
///
/// Notes:
///   - The function returns a new list, leaving the original `keys` list unchanged.
///   - If the input `key` is not found in the `keys` list, the function returns a copy of the original list.
List<String> possibleMoveOptions(String key, List<String> keys) {
  return List<String>.from(keys.where((e) => e != key));
}
