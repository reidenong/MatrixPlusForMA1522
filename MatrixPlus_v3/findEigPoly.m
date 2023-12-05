function findEigPoly(matrix)
% Output similar to ::eig()
% Displays the characteristic polynomial to show in working,
% essentially a shortcut for det(xI - A)

[rows, cols] = size(matrix);
if rows ~= cols
    error('Error: Input matrix is not square.');
end

syms x;
determinant = det(x * eye(rows, cols) - matrix);
disp(" ")
disp("det(xI - A) = ")
disp(determinant)
disp(factor(determinant))
end
