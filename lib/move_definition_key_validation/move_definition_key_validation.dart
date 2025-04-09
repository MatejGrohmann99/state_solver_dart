/// Validates a list of move definition keys to ensure they do not contain apostrophes, the digit '2', or spaces.
///
/// This function checks each key in the provided list against a regular expression that
/// matches any apostrophe (`'`), the digit '2', or whitespace characters (spaces, tabs, etc.).
/// If any key is found to contain these characters, the function returns `false`.
///
/// Example:
/// ```dart
/// final validKeys = ['U', 'R', 'F'];
/// final invalidKeys = ['U\'', 'R2', 'F '];
///
/// print(moveDefinitionKeyValidation(validKeys)); // Output: true
/// print(moveDefinitionKeyValidation(invalidKeys)); // Output: false
/// ```
///
/// Parameters:
///   - `keys`: A list of strings representing the move definition keys to be validated.
///
/// Returns:
///   - `bool`: `true` if all keys in the list are valid (do not contain apostrophes, '2', or spaces), `false` otherwise.
///
/// Implementation Details:
///   1. A regular expression `RegExp(r"[' 2\s]")` is created to match apostrophes, '2', and whitespace.
///   2. The function iterates through each key in the provided `keys` list.
///   3. For each key, `keysRegex.hasMatch(key)` is used to check if the key contains any of the invalid characters.
///   4. If a match is found, the function immediately returns `false`.
///   5. If the loop completes without finding any invalid characters, the function returns `true`.
bool moveDefinitionKeyValidation(List<String> keys) {
  // verify that keys does not contain characters ', 2 and spaces
  final keysRegex = RegExp(r"[' 2\s]");
  for (var i = 0; i < keys.length; i++) {
    if (keysRegex.hasMatch(keys[i])) {
      return false;
    }
  }

  return true;
}
