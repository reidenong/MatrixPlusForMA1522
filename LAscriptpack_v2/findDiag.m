function [P D] = findDiag(A)
[P, D] = eig(sym(A));
if size(P, 1) ~= size(A, 1) || size(P, 2) ~= size(A, 2)
    error('findDiag is unable to come up with a diagonalization for the given matrix.\n%s' ,'Check if matrix is diagonalizable?');
end
disp(" ")
disp("    Using [P D] = findDiag(A), ")
disp("    A = P x D x P^-1 where")
end
