function Q = gramSchmidtEcon(spanOfColsAsMatrix)
    [rows, cols] = size(spanOfColsAsMatrix);
    [Q R] = qr(sym(spanOfColsAsMatrix));
    Q = simplify(Q);

    numVectors = size(Q, 2);
    for column = 1 : cols
        disp(" ")
        fprintf("v%d : \n", column)

        currentVec = Q(:, column);
        gcdVec = gcd(currentVec);
        %currentVec = 1/gcd * currentVec;
        fprintf("v%d has factor ",column)
        disp(gcdVec)
        disp(currentVec/gcdVec)
    end

    if (rank(spanOfColsAsMatrix) ~= numVectors)
        warning('Result may be invalid as given matrix is not linearly independent!')
    end

    Q = Q(:, 1:cols);
end




