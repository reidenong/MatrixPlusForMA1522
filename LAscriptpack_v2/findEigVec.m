function eigVec = findEigVec(matrix, eigenvalue)
eigSpace = findEigSpace(matrix, eigenvalue);
eigVec = eigSpace(:, 1);
end
