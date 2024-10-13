import numpy as np

def gram_schmidt(vectors):
    """Applies the Gram-Schmidt process to a set of vectors and returns an orthonormal basis."""
    orthonormal_basis = []
    
    for v in vectors:
        # Orthogonalize v against all previous basis vectors
        v_orthogonal = v
        for u in orthonormal_basis:
            proj = np.dot(v_orthogonal, u) * u
            v_orthogonal = v_orthogonal - proj
        
        # Normalize the orthogonalized vector
        norm = np.linalg.norm(v_orthogonal)
        if norm > 1e-10:  # To avoid division by zero or numerical instability
            u_normalized = v_orthogonal / norm
            orthonormal_basis.append(u_normalized)
    
    return orthonormal_basis

# Input vectors
vectors_a = [
    np.array([-1, 0, 1]),  # Vector 1 in R^3
    np.array([-1, -1, 0]), # Vector 2 in R^3
    np.array([0, 0, 1])    # Vector 3 in R^3
]

vectors_b = [
    np.array([1, -1, 1, -1]),  # Vector 1 in R^4
    np.array([5, 1, 1, 1]),    # Vector 2 in R^4
    np.array([2, 3, 1, -1])    # Vector 3 in R^4
]

# Apply Gram-Schmidt process
orthonormal_basis_a = gram_schmidt(vectors_a)
orthonormal_basis_b = gram_schmidt(vectors_b)

# Output the results for set (a) in R^3
print("Orthonormal basis for set (a) in R^3:")
for vec in orthonormal_basis_a:
    print(vec)

# Output the results for set (b) in R^4
print("\nOrthonormal basis for set (b) in R^4:")
for vec in orthonormal_basis_b:
    print(vec)

