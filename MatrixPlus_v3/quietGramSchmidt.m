function Q = gramSchmidt(spanOfColsAsMatrix)
    [Q R] = qr(sym(spanOfColsAsMatrix));
    Q = simplify(Q);

    numVectors = size(Q, 2);
    for column = 1 : numVectors

        currentVec = Q(:, column);
        gcdVec = gcd(currentVec);
    end
end




