function [U S Vt] = autoSVD(matrix)
ori = matrix;
matRank = rank(matrix);
[rows, cols] = size(matrix);
matrix = matrix'*matrix;
eigenvalues = eig(sym(matrix))';

% STEP 1: Find Eigenvalues
disp("For given matrix, we first find A' * A: ")
disp(matrix)
disp("For given matrix, we have characteristic polynomial: ")
findEigPoly(matrix)
disp("This gives us sorted eigenvalues: ")
eigenvalues = sort(eigenvalues, 'descend');
rootValues = sym(eigenvalues).^0.5;
rootValues(rootValues == 0) = [];
[temp, numOfRoot] = size(rootValues);
disp(eigenvalues)

% Step 2: Construct S
disp("We now obtain S as a diagonal matrix of the sqrt of nonzero eigenvalues padded with 0s")
fprintf("since matrix is rank %d, we have S: ",matRank)
S = diag(rootValues);
S = [S zeros(numOfRoot, cols-numOfRoot)];
S = [S; zeros(rows - numOfRoot, cols)];
S = simplify(S);
S

% Step 3: find V, (v1 v2 v3 ...) where vi is the unit vector of each eigval
disp("Now we find a unit eigenvector for each eigenvalue.")
V = [];
[temp, numOfEig] = size(eigenvalues);
for i=1 : numOfEig
    fprintf("for our #%d eigenvalue of _%d_, we have unit vector: ", i, eigenvalues(1, i))
    v = findEigVec(matrix, eigenvalues(1, i))
    factor = 1/norm(sym(v));
    v = factor * v;
    V = [V v];
end
disp("Placing them in a vector V = (v1 v2 v3 ...) while getting the unit vector for each vector, we have V:")
V = simplify(V);
V
Vt = V';

% Step 4: find U
disp("Now we find a orthonormal basis for the solution space.")
disp("using formula u_i = 1/sqrt(eigenvalue) * A * v_i, we have")
disp(" ")
U = [];
for i=1 :numOfRoot
    fprintf("u%d:", i)
    disp(" ")
    u_i = 1/rootValues(1,i) * ori * V(:, i);
    u_i = simplify(u_i);
    disp(u_i)
    U = [U u_i];
end
U = simplify(U);

% Step 5: Finding orthonormal basis for U
isOrthonormal = isequal(U, quietGramSchmidt(U));
if (isOrthonormal) 
    disp("U = (u1 u2 u3 ...)is already a orthonormal basis for RR^2.")
    U 
else
    disp("Now we use the gram Schmidt process to find a orthonormal basis of U")
    U = gramSchmidt(U)
end

disp(" ")
disp("SVD algorithm is finished.")
disp("  We have A = U * S * VT, where ")

end