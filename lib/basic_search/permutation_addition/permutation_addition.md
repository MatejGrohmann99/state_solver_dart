# permutationAddition

Applies a sequence of permutations to an initial reflected state and returns a resolved permutation matrix indicating changes.

## Function Signature

```dart
List<List<int>> permutationAddition({required List<List<List<int>>> orderedPermutations});
```

## Parameters

- **`orderedPermutations`** (`List<List<List<int>>>`):  
  A list of 2D integer lists, where each inner list represents a permutation to be applied in order.

## Returns

- A 2D list (`List<List<int>>`) of integers representing the final permutation,  
  with `-1` indicating unchanged positions.

## Description

This function takes a list of ordered permutations and performs a cumulative transformation on an identity-like state matrix. The result is a permutation matrix where unchanged positions (i.e., already in correct order) are marked with `-1`.

### Process:

1. Reflect the shape of the first permutation to generate a base state.
2. Apply each permutation in `orderedPermutations` in sequence using `permutationAlgorithm`.
3. Mark elements in the result that have not changed position with `-1`.

This is useful for condensing multiple permutation steps into a single delta matrix.

## Example

```dart
final orderedPermutations = [
  [
    [-1, 2, 1],
    [-1, 2, 1]
  ],
  [
    [-1, 2, 1],
    [1, 0, -1]
  ]
];

final result = permutationAddition(orderedPermutations: orderedPermutations);

// result will look like:
// [
//   [-1, -1, -1],
//   [2, 0, 1]
// ]
```
