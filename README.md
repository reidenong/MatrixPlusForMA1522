# Matlab Scriptpack for Linear Algebra <br /> <img  src="https://img.shields.io/badge/MATLAB-R2023a-orange"  height="17"  />
A collection of macros, functions and algorithms in MATLAB for use in NUS MA1522 Linear Algebra, AY23/24 Sem 1. Majority of the functions here are more of 'macros' for too be faster, with the exception of 1-2 implemented algorithms. Use at your own discretion!
<br />
## Installation Guide
The scriptpack should be placed in the MATLAB directory.

For Windows users, place the scriptpack at
```
C:\Users\Your_Name\Documents\MATLAB\LAscriptpack_vX\
```

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

### Method Documentation
```autoSVD(matrix A)``` performs the Singular Value Decomposition algorithm and returns ```[U S Vt]``` where U is a orthogonal matrix, S is a diagonal matrix, and Vt is a orthogonal matrix. Orthogonality of the matrices can be verified by ```A'*A == I```.
```
>> A = [4 11 14; 8 7 -2]

A =

     4    11    14
     8     7    -2

>> [U S Vt] = autoSVD(A)
For given matrix, we first find A' * A: 
    80   100    40
   100   170   140
    40   140   200

For given matrix, we have characteristic polynomial: 
 
det(xI - A) = 
x^3 - 450*x^2 + 32400*x
 
[x, x - 90, x - 360]
 
This gives us sorted eigenvalues: 
[360, 90, 0]
 
We now obtain S as a diagonal matrix of the sqrt of nonzero eigenvalues padded with 0s
since matrix is rank 2, we have S:  
S =
 
[6*10^(1/2),          0, 0]
[         0, 3*10^(1/2), 0]
 
Now we find a unit eigenvector for each eigenvalue.
for our #1 eigenvalue of _360_, we have unit vector:  
v =
 
1/2
  1
  1
 
for our #2 eigenvalue of _90_, we have unit vector:  
v =
 
  -1
-1/2
   1
 
for our #3 eigenvalue of _0_, we have unit vector:  
v =
 
 2
-2
 1
 
Placing them in a vector V = (v1 v2 v3 ...) while getting the unit vector for each vector, we have V:
 
V =
 
[1/3, -2/3,  2/3]
[2/3, -1/3, -2/3]
[2/3,  2/3,  1/3]
 
Now we find a orthonormal basis for the solution space.
using formula u_i = 1/sqrt(eigenvalue) * A * v_i, we have
 
u1: 
(3*10^(1/2))/10
    10^(1/2)/10
 
u2: 
     10^(1/2)/10
-(3*10^(1/2))/10
 
U = (u1 u2 u3 ...)is already a orthonormal basis for RR^2.
 
U =
 
[(3*10^(1/2))/10,      10^(1/2)/10]
[    10^(1/2)/10, -(3*10^(1/2))/10]
 
 
SVD algorithm is finished.
  We have A = U * S * VT, where 
 
U =
 
[(3*10^(1/2))/10,      10^(1/2)/10]
[    10^(1/2)/10, -(3*10^(1/2))/10]
 
 
S =
 
[6*10^(1/2),          0, 0]
[         0, 3*10^(1/2), 0]
 
 
Vt =
 
[ 1/3,  2/3, 2/3]
[-2/3, -1/3, 2/3]
[ 2/3, -2/3, 1/3]
```

<br />

```findEigSpace(matrix A, int EigVal)``` and ```findEigVec(matrix A, int eigVal)``` perform similar functions to find the space and vector associated with the eigenvalue respectively. ```findEigSpace``` uses ```null(sym(EigVal * I - A))``` to determine the Eigenspace, and findEigVec gives the first basis vector of the same Eigenspace.
```
```

<br />

```findEigPoly(matrix A)``` uses the formula ```CharacteristicPolynomial = det(sym(xI - A))``` with symbolic x to return the factorized polynomial of ```A```.
```
```

<br />

```gramSchmidt(matrix A)``` uses QR Decomposition to turn a collection of linearly independent column vectors into a basis of orthonormal vectors. Column vectors ```u1```,```u2```, ... are pased in as a matrix ```U``` where ```U = (u1 u2 u3 ... )```. Product is not guaranteed when vectors passed in are not already linearly independent, and program will throw a warning.
```
```

<br />

```findDiag(matrix A)``` produces a possible diagonalization of matrix ```A``` using the library ```eig()``` function. I lack a complete understanding of why this works, only that it does, so use with caution. When a non-diagonalizable matrix is passed in, the program throws an error to prompt the user to check for diagonalizability through other methods. While it is pretty conclusive that ```findDiag``` will throw an error if the matrix given is not diagonalizable, it is *not* guaranteed that the given matrix is not diagonalizable if an error is thrown, so keep that in mind. In general, with warning, check for diagonzalization through other methods.
```
```

<br />

```leastSquare(matrix A, columnVector b)``` solves for ```A'Ax = A'b```, a least squares solution for the equation ```Ax = b```. Returns the solution set in the form of a matrix.
```
```

<br />

Sample Usage of Row Elementary Operation functions
```
```

<br />

Sample Usage of Matrix Manipulation functions
```
```
