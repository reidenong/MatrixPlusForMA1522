# Matrix+ for MA1522 in MatLab <br /> <img  src="https://img.shields.io/badge/MATLAB-R2023a-orange"  height="17"  />
In essence, **Matrix+** is a wrapper class in MatLab designed to greatly enhance the functionality of matrices in MatLab. By incorporating ready to use algorithms and refining existing functions, **Matrix+** is more efficient and intuitive, and helps improve performance under timed conditions such as exams. 
```
Eg) Performing 3 row operations, then finding it's Least Square
    solution for b:

// Vanilla MatLab 
>> A(2, :) = A(2, :) - 4*A(1, :);    // R2 -> R2 + 4R1
>> A(3, :) = 3 * A(3, :)             // R3 -> 3*R3
>> A([1,2], :) = A([2,1],:)          // R2 <-> R1
>> null([A'*A*b A'*b])

// Matrix+
>> A = A.rowOp("R2 += 4R1")
        .rowOp("R3 *= 3")
        .rowOp("R2 <-> R1")
>> A.leastSquare(b)
```
The key design principles of **Matrix+** are to 
(1) Make code easy to read and interpret,
(2) Cut down implementation time for functions, 
(3) Provide a instant answer with workings whenever possible.

<br/> 

**Matrix+** was made over the course of AY23/24 S1 for use in the NUS mod MA1522: Linear Algebra for Computing. Use at your own discretion!

**Read the User Guide on how to use Matrix+ in irl contexts with past year exam questions*.*

## Installation Guide
The folder containing scripts should be placed in the MATLAB directory.

For Windows users, place the scriptpack at
```
C:\Users\Your_Name\Documents\MATLAB\MatrixPlus_vX\
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
- ```checkDiag(matrix A)``` : Check diagonalizability of matrix A with working shown
- ```gramSchmidt(matrix A)``` : Returns matrix where columns form a orthonormal basis
- ```leastSquare(matrix A, vector b)``` : Returns solution set of the least square soln of Ax = b

**Eigenvectors**
- ```findEigPoly(matrix A)``` : Returns the factorized characteristic polynomial of A
- ```findEigSpace(matrix A, int eigVal)``` : Returns a basis for the Eigenspace of given Eigenvalue
- ```findEigVec(matrix A, int eigVal)``` : Returns a eigenvector for a given eigenvalue
- ```autoSVD(matrix A)``` : Performs the Singular Value Decomposition algorithm with working

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

```checkDiag(matrix A)``` checks the diagonalizability of matrix ```A``` by checking if the sum of dimensions of eigenspaces is equal to the order of the given matrix. Shows working to the extent of each eigenspace.
```
A =

     1    -3     3
     3    -5     3
     6    -6     4

>> checkDiag(A)
from given matrix, we find the following eigenvalues: 
 
eigenvalues =
 
[-2, -2, 4]
 
order n square matrix A is diagonalizable iff the sum of geometric multiplicites = n
ie.   sum_eigenvalue_k(dim(E_k)) == 3 
 
eigenspace E_(-2) has dimension 2
[1, -1]
[1,  0]
[0,  1]
 
eigenspace E_(4) has dimension 1
1/2
1/2
  1
 
sum = 3 is equal to the order of matrix, thus given matrix is diagonalizable. 
```

<br />

```findEigSpace(matrix A, int EigVal)``` and ```findEigVec(matrix A, int eigVal)``` perform similar functions to find the space and vector associated with the eigenvalue respectively. ```findEigSpace``` uses ```null(sym(EigVal * I - A))``` to determine the Eigenspace, and findEigVec gives the first basis vector of the same Eigenspace.
```
>> A = [1 1 0; 1 1 0; 0 0 2]

A =

     1     1     0
     1     1     0
     0     0     2

>> eig(sym(A))
 
ans =
 
0
2
2
 
>> findEigSpace(A, 2)
 
ans =
 
[1, 0]
[1, 0]
[0, 1]
 
>> findEigVec(A, 2)
 
ans =
 
1
1
0
```

<br />

```findEigPoly(matrix A)``` uses the formula ```CharacteristicPolynomial = det(sym(xI - A))``` with symbolic x to return the factorized polynomial of ```A```.
```
>> A = [2 -1 5; -1 2 5; 5 5 -4]

A =

     2    -1     5
    -1     2     5
     5     5    -4

>> findEigPoly(A)
 
det(xI - A) = 
x^3 - 63*x + 162
 
[x - 3, x + 9, x - 6]
```

<br />

```gramSchmidt(matrix A)``` uses QR Decomposition to turn a collection of linearly independent column vectors into a basis of orthonormal vectors. Column vectors ```u1```,```u2```, ... are pased in as a matrix ```U``` where ```U = (u1 u2 u3 ... )```. Product is not guaranteed when vectors passed in are not already linearly independent, and program will throw a warning.
```
>> u1 = [1; 2; 1]; u2 = [1; 1; 1]; u3 = [1; 1; 2];
>> S = [u1 u2 u3]

S =

     1     1     1
     2     1     1
     1     1     2

>> Q = gramSchmidt(S)
 
v1 : 
v1 has factor 6^(1/2)/6
 
1
2
1
 
 
v2 : 
v2 has factor 3^(1/2)/3
 
 1
-1
 1
 
 
v3 : 
v3 has factor 2^(1/2)/2
 
-1
 0
 1
 
 
Q =
 
[6^(1/2)/6,  3^(1/2)/3, -2^(1/2)/2]
[6^(1/2)/3, -3^(1/2)/3,          0]
[6^(1/2)/6,  3^(1/2)/3,  2^(1/2)/2]
```

<br />

```findDiag(matrix A)``` produces a possible diagonalization of matrix ```A``` using the library ```eig()``` function. I lack a complete understanding of why this works, only that it does, so use with caution. When a non-diagonalizable matrix is passed in, the program throws an error to prompt the user to check for diagonalizability through other methods. While it is pretty conclusive that ```findDiag``` will throw an error if the matrix given is not diagonalizable, it is *not* guaranteed that the given matrix is not diagonalizable if an error is thrown, so keep that in mind. In general, with warning, check for diagonzalization through other methods.
```
>> B = [6 -3; -3 14]

B =

     6    -3
    -3    14

>> [P D] = findDiag(B)
 
    Using [P D] = findDiag(A), 
    A = P x D x P^-1 where
 
P =
 
[3, -1/3]
[1,    1]
 
 
D =
 
[5,  0]
[0, 15]
```

<br />

```leastSquare(matrix A, columnVector b)``` solves for ```A'Ax = A'b```, a least squares solution for the equation ```Ax = b```. Returns the solution set in the form of a matrix.
```
>> A = [1 1 0 1; 0 1 1 0; 1 2 1 1]; b = [1; 1; 1];
>> solutionSet = leastSquare(A, b)
 
Solving for A'Ax = A'b, we do rref([A'*A A'*b]) to get solution set: 
 
solutionSet =
 
[1, 0, -1, 1,   0]
[0, 1,  1, 0, 2/3]
[0, 0,  0, 0,   0]
[0, 0,  0, 0,   0]
```

<br />

Sample Usage of Row Elementary Operation functions
```
>> A = eye(3)

A =

     1     0     0
     0     1     0
     0     0     1

>> A = swap(A, 1, 2)
 
    Row Swap: 
        R1 <-> R2

A =

     0     1     0
     1     0     0
     0     0     1

>> A = rsum(A, 3, 2, 5)
 
    Row Sum:
        R3 += 5 * R2

A =

     0     1     0
     1     0     0
     5     0     1

>> A = mult(A, 3, 10)
 
    Scalar Multiplication:
        R3 = 10 * R3

A =

       0              1              0       
       1              0              0       
      50              0             10   
```

<br />

Sample Usage of Matrix Manipulation functions
```
>> A = eye(2)

A =

       1              0       
       0              1       

>> row = getRow(A, 1)

row =

       1              0       

>> col = getCol(A, 2)

col =

       0       
       1       

```
