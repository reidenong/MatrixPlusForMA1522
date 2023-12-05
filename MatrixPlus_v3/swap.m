function matrix = swap(matrix, rowA, rowB)
% SWAP Swap rows A and B in the input matrix A.
%
%   A = SWAP(A, a, b) swaps rows a and b in the matrix A and returns the
%   modified matrix. Rows a and b must be valid row indices in A

matrix([rowA,rowB], :) = matrix([rowB, rowA], :);
msg = sprintf("        R%d <-> R%d", rowA, rowB);
disp(" ")
disp("    Row Swap: ")
disp(msg)
end