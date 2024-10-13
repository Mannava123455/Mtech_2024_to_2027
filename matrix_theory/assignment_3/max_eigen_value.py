'''
Matrix theory assignment 3 

Name: Mannava Venkatasai
roll:EE24MTECH12008

The power method for calculating the largest eigenvalue/vector
pair of a square symmetric matrix 𝐴 is described as follows:
i.   Initialize: set the vector x0 to an arbitrary value.
ii.  For i =1, 2, 3, . . .
iii. xi+1=Axi/|| Axi||2


The power method for calculating the smallest eigenvalue/vector
pair of a square symmetric matrix 𝐴 is described as follows:
i.   Initialize: set the vector x0 to an arbitrary value.
ii.  For i =1, 2, 3, . . .
iii. xi+1=A^-1 xi/|| Axi||2







'''

import numpy as np
import matplotlib.pyplot as plt


def power_method_for_max_eigenvalue_and_eigenvector(A,iterations):

    #find the dim of A
    n = A.shape[0]

    #initialize the vector x_0 to the arbitary value
    x_k = np.ones(n)

    #run the iterations
    for i in range(iterations):
        Ax_k = A @ x_k
        x_k_1 = Ax_k/np.linalg.norm(Ax_k)
        x_k = x_k_1

    return np.dot(x_k.T,A@x_k),x_k

def power_method_for_min_eigenvalue_and_eigenvector(A,iterations):

    #find the dim of A
    n = A.shape[0]

    #initialize the vector x_0 to the arbitary value
    x_k = np.ones(n)

    #run the iterations
    for i in range(iterations):
        x_k_1 = np.linalg.solve(A,x_k)
        x_k_1 = x_k_1/np.linalg.norm(x_k_1)
        x_k = x_k_1

    return np.dot(x_k.T,A@x_k),x_k


def power_method_with_error_for_max_eigen_value(A, eigvec_builtin,iterations):
 
    #find the dim of A
    n = A.shape[0]

    #initialize the vector x_0 to the arbitary value
    x_k = np.ones(n)
    errors = []

    #run the iterations
    for i in range(iterations):
        Ax_k = A @ x_k
        x_k_1 = Ax_k/np.linalg.norm(Ax_k)
       
        # Compute error with respect to the true eigenvector
        error = np.linalg.norm(x_k_1 - eigvec_builtin)
        errors.append(error)
        x_k = x_k_1    

    return errors


def power_method_with_error_for_min_eigen_value(A, eigvec_builtin,iterations):
 
    #find the dim of A
    n = A.shape[0]

    #initialize the vector x_0 to the arbitary value
    x_k = np.ones(n)
    errors = []

    #run the iterations
    for i in range(iterations):
        x_k_1 = np.linalg.solve(A,x_k)
        x_k_1 = x_k_1/np.linalg.norm(x_k_1)
       
        # Compute error with respect to the true eigenvector
        error = np.linalg.norm(x_k_1 - eigvec_builtin)
        errors.append(error)
        x_k = x_k_1    

    return errors




n = 2
A = np.random.rand(n, n)
iterations = 500
print(f"input array = {A}")

max_eigen_value,max_eigen_vector =  power_method_for_max_eigenvalue_and_eigenvector(A,iterations)
min_eigen_value,min_eigen_vector =  power_method_for_min_eigenvalue_and_eigenvector(A,iterations)


eigvals, eigvecs = np.linalg.eig(A)
max_builtin_eigenvalue = np.max(eigvals)
min_builtin_eigenvalue = np.min(eigvals)



print(f"Maximum eigen value of a matrix A is {max_eigen_value}")
print(f"Maximum eigen vector of a matrix A is {max_eigen_vector}")

print(f"Builtin Maximum eigen vector of a matrix A is {eigvecs[:, np.argmax(eigvals)]}")
print(f"Builtin Maximum eigen value of a matrix A is {max_builtin_eigenvalue}")

print(f"Minimum eigen value of a matrix A is {min_eigen_value}")
print(f"Minimum eigen vector of a matrix A is {min_eigen_vector}")

print(f"Builtin Minimum eigen vector of a matrix A is {eigvecs[:, np.argmin(eigvals)]}")
print(f"Builtin Minimum eigen value of a matrix A is {min_builtin_eigenvalue}")


errors1 = power_method_with_error_for_max_eigen_value(A, eigvecs[:, np.argmax(eigvals)],iterations)
errors2 = power_method_with_error_for_min_eigen_value(A, eigvecs[:, np.argmax(eigvals)],iterations)

# print(f"errors = {errors}")
plt.subplot(2,1,1)
plt.plot(errors1)
plt.title("Error vs. Iterations for Power Method for max eigen vector ")

plt.subplot(2,1,2)
plt.plot(errors2)

plt.xlabel("Iterations")
plt.ylabel("Error")
plt.title("Error vs. Iterations for Power Method for min eigen vector")
plt.show()





