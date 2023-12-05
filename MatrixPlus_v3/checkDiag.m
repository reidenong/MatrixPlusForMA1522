function checkDiag(matrix)
[row, col] = size(matrix);
disp("from given matrix, we find the following eigenvalues: ")
eigenvalues = eig(sym(matrix))'

if (~isreal(eigenvalues))
disp("given matrix does not have real eigenvalues (they contain i)")
disp("given matrix is not diagonalizable")
else
[a, b, c] = unique(eigenvalues);
tally = accumarray(c, 1);
freqArray = [a' tally];
fprintf("order n square matrix A is diagonalizable iff the sum of geometric multiplicites = n\n")
fprintf("ie.   sum_eigenvalue_k(dim(E_k)) == %d", row)
disp(" ")
disp(" ")
currentSum = 0;
[temp, numOfEig] = size(a);
for i=1 : numOfEig
    currEig = a(1, i);
    E_k = findEigSpace(matrix, currEig);
    [temp2, dimension] = size(E_k);
    currentSum = currentSum + dimension;
    fprintf("eigenspace E_(%d) has dimension %d\n",currEig, dimension);
    disp(E_k)
end

if(currentSum == row)
    fprintf("sum = %d is equal to the order of matrix, thus given matrix is diagonalizable.", currentSum)
else
    fprintf("sum = %d is not equal to the order of the matrix, given matrix is not diagonalizable.", currentSum)
end
disp(" ")
end
end
