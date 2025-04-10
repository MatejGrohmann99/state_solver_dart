# moveValidation

Validates if a move definition for a 6-sided cube returns the cube to its solved state after 4 applications.

## Function Signature

```dart
 bool moveValidation(List<List<int>> moveDefinition);
```

## Parameters

- **`moveDefinition`** (`List<List<int>>`):
  A 2D list of integers representing the move definition for the 6-sided cube. Each inner list represents a row of the cube, and contains integers indicating the new positions of the elements after the move. `'-1'` represents no change in position.

## Returns

- `bool`: `true` if the move definition is valid, `false` otherwise.

## Description

This function checks if a given move definition for a 6-sided cube adheres to the following properties:

1.  Applying the move 4 times returns the cube to its initial state.
2.  Combining the move 4 times results in a no-permutation state (identity permutation).

## Example

```dart
 const uClockwisePermutation = [
   // 00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23
   [03, 00, 01, 02, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
   [06, 07, 00, 01, 02, 03, 04, 05, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
 ];

 bool isValid = moveValidation(uClockwisePermutation);
 print(isValid); // Outputs: true or false
```

## Implementation Details

1.  `permutationReflection(moveDefinition)`: Reflects the move definition to get the initial state of the cube.
2.  `permutationAlgorithm(stateCopy, moveDefinition)`: Applies the move definition to the current state of the cube.
3.  The function iterates 4 times, applying the move definition each time, and checks if the cube returns to its initial state.
4.  `permutationAddition(orderedPermutations: [moveDefinition, moveDefinition, moveDefinition, moveDefinition])`: Combines the move definition 4 times to check if it results in a no permutation state (identity permutation).
5.  A no permutation state is represented by a list of lists where each element is -1.

## Notes

-   The function uses the `permutationReflection`, `permutationAlgorithm`, and `permutationAddition` functions from the `state_solver_dart` package.
-   It assumes that the input `moveDefinition` is a valid move definition for a 6-sided cube.
-   The function returns `true` if the move definition is valid, and `false` otherwise.