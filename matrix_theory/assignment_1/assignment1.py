import numpy as np
import sympy as sp

# Function to find the basis for the column space
def column_space_basis(A):
    A = np.array(A, dtype=float)
    _, pivot_columns = sp.Matrix(A).T.rref()
    basis = A[:, pivot_columns]
    return basis, len(pivot_columns)

# Function to find the null space
def null_space(A):
    A = sp.Matrix(A)
    null_space_basis = A.nullspace()
    null_space_vectors = [np.array(vec).astype(np.float64) for vec in null_space_basis]
    return null_space_vectors, len(null_space_vectors)

# Function to find the rank (dimension of the column space)
def matrix_rank(A):
    return np.linalg.matrix_rank(A)

# Example matrix
A = [
    [1, 0, 2, 8, 2, -1],
    [2, -1, -2, 5, 4, 0],
    [0, -1, 0, 8, 5, -1],
    [4, -1, 2, 0, 8, 0]
]

# Finding the basis for the column space and its dimension
column_basis, column_space_dim = column_space_basis(A)
print("Column Space Basis:")
print(np.array(column_basis))
print("Dimension of Column Space (Rank of A):", column_space_dim)

# Finding the null space basis and its dimension
null_basis, null_space_dim = null_space(A)
print("\nNull Space Basis:")
for vec in null_basis:
    print(vec)
print("Dimension of Null Space:", null_space_dim)

# Finding the rank directly using NumPy
rank = matrix_rank(A)
print("\nRank of the Matrix (Dimension of Column Space):", rank)

