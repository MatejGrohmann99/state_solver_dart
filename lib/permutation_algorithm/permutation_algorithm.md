# permutationAlgorithm

Applies a permutation mapping to a 2D list (`List<List<int>>`) structure.

## Function Signature

```dart
List<List<int>> permutationAlgorithm(List<List<int>> state, List<List<int>> permutation);
```

## Parameters

- **`state`** (`List<List<int>>`):  
  A 2D list of integers representing the original data matrix. Each inner list represents a row of integers.

- **`permutation`** (`List<List<int>>`):  
  A 2D list of integers representing the permutation indices for each row in the `state`.  
  - Each value in a row corresponds to an index in the same row of `state`.
  - A value of `-1` means the element at that position should remain unchanged.

## Returns

- A new 2D list (`List<List<int>>`) with the same dimensions as `state`, where the elements have been rearranged according to the `permutation` matrix.

## Assertions

- The outer dimensions (number of rows) of `state` and `permutation` must be equal.
- Each corresponding row in `state` and `permutation` must be of the same length.

## Behavior

- The function first creates a deep copy of the `state` matrix.
- It then iterates over each cell of the `permutation` matrix.
- For each non-`-1` index in the permutation matrix, it updates the copy with the value at the specified index from the corresponding row in the original `state`.

## Example

```dart
final state = [
  [10, 20, 30],
  [40, 50, 60]
];

final permutation = [
  [2, 1, 0],
  [-1, 0, 2]
];

final result = permutationAlgorithm(state, permutation);

// result:
// [
//   [30, 20, 10],
//   [40, 40, 60]
// ]
```

## Notes

- Use this function when you need to re-map values in a 2D structure using a custom per-row index map.
- The function does **not** mutate the original `state` list, it returns new instance.
