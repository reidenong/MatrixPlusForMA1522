function matrix = mult(matrix, row, scalar)
% MULT Perform scalar multiplication on the input matrix.
%
%   MATRIX = MULT(MATRIX, row, scalar) performs scalar multiplication on
%   MATRIX where row is multiplied by the scalar value. The specified row 
%   must be a valid row index in MATRIX, and scalar is the value by which 
%   the row is multiplied.
format rational
matrix(row, :) = scalar * matrix(row, :);
msg = sprintf("        R%d -> %d * R%d", row, scalar, row);
disp(" ")
disp("    Scalar Multiplication:")
disp(msg)
end
