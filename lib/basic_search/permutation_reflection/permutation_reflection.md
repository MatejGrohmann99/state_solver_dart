# permutationStateReflection

Generates a default identity state matrix based on the shape of a given permutation matrix.

## Function Signature

```dart
List<List<int>> permutationReflection(List<List<int>> permutation);
```

## Parameters

- **`permutation`** (`List<List<int>>`):  
  A 2D list of integers used solely to determine the shape of the output matrix.

## Returns

- A new 2D list (`List<List<int>>`) with the same dimensions as `permutation`, where each row contains a sequence `[0, 1, 2, ..., n - 1]`.

## Description

This function is typically used to generate a default state matrix that matches the dimensions of a given permutation matrix. Each row in the returned matrix contains its own indices in ascending order, effectively acting as an identity row.

## Example

```dart
final permutation = [
  [2, 1, 0],
  [-1, 0, 2]
];

final state = permutationReflection(permutation);

// state:
// [
//   [0, 1, 2],
//   [0, 1, 2]
// ]
```

## Notes

- Useful as a helper function when testing or generating mock state matrices.
- Does not validate contents of the input `permutation`; only its shape is used.
