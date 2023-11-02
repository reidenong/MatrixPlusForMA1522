function matrix = rsum(matrix, rowA, rowB, factor)
% RSUM Perform row sum operation on the input matrix.
%
%   MATRIX = RSUM(MATRIX, rowA, rowB, factor) performs the row sum operation
%   on MATRIX where rowA is replaced by rowA + factor * rowB. Rows rowA and 
%   rowB must be valid row indices in MATRIX, and factor is the scalar 
%   multiplier applied to rowB before the addition.
%

matrix(rowA, :) = matrix(rowA, :) + factor*matrix(rowB, :);
msg = sprintf("        R%d += %d * R%d", rowA, factor, rowB);
disp(" ")
disp("    Row Sum:")
disp(msg)
end