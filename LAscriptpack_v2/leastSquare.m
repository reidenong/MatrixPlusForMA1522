function solutionSet = leastSquare(A, b)
    solutionSet = rref(sym([A'*A A'*b]));
    disp(" ")
    disp("Solving for A'Ax = A'b, we do rref([A'*A A'*b]) to get solution set: ")
end