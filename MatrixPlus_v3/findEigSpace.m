function eigSpace = findEigSpace(matrix, eigenvalue)
[rows, cols] = size(matrix);
eigSpace = null(sym(eigenvalue*eye(rows) - matrix));
end
