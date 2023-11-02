# Matlab Scriptpack for Linear Algebra <br /> <img  src="https://img.shields.io/badge/MATLAB-R2023a-orange"  height="17"  />
A collection of macros, functions and algorithms in MATLAB for use in NUS MA1522 Linear Algebra, AY23/24 Sem 1. Majority of the functions here are more of 'macros' for too be faster, with the exception of 1-2 implemented algorithms. Use at your own discretion!
<br />
## Installation Guide
The scriptpack should be placed in the MATLAB directory.

For Windows users, place the scriptpack at
```
C:\Users\Your_Name\Documents\MATLAB\LAscriptpack_vX\
```
<br />

## Usage Guide
The latest version is LAscriptpack_v2, and it has the following methods:

**Basic Matrix Manipulation**
- ```getRow(matrix A, int i)``` : Returns a specific row of a matrix
- ```getCol(matrix A, int i)``` : Returns a specific column of a matrix

**Elementary Row Operations**
- ```swap(matrix A, int i, int j)``` : Returns matrix with rows i and j swapped
- ```rsum(matrix A, int i, int j, int factor)``` : Returns matrix with row(i) += factor * row(j)
- ```mult(matrix A, int i, int factor)``` : Returns matrix with row(i) *= factor

**Orthogonalisation and Diagonalization**
- ```findDiag(matrix A)``` : Returns matrices [P D] where P * D * inv(P) = A
- ```gramSchmidt(matrix A)``` : Returns matrix where columns form a orthonormal basis

**Eigenvectors**
- ```findEigPoly(matrix A)``` : Returns the factorized characteristic polynomial of A
- ```findEigSpace(matrix A, int eigVal)``` : Returns a basis for the Eigenspace of given Eigenvalue
- ```findEigVec(matrix A, int eigVal)``` : Returns a eigenvector for a given eigenvalue
- ```autoSVD(matrix A)``` : Performs the Singular Value Decomposition algorithm with steps

##
