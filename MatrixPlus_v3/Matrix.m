classdef Matrix < matlab.mixin.CustomDisplay
    % Fields
    % ========
    properties(SetAccess = protected)
        matrix
    end
    
    % Constructors, Accessors, Factory Methods
    % =========
    methods 
        % Constructor
        function obj = Matrix(givenMatrix)
            obj.matrix = (givenMatrix);
        end
        % Accessor
        function output = get(obj)
            output = Matrix(obj.matrix).matrix;
        end
        function output = getCol(obj, col)
            output = Matrix.of(getCol(obj.matrix, col));
        end
        function output = getRow(obj, row)
            output = Matrix.of(getRow(obj.matrix, row));
        end
    end
    methods (Static)
        % Factory Method
        function obj = of(givenMatrix)
            obj = Matrix(givenMatrix);
        end

        function help(obj)
            disp(" ")
            disp("Welcome to Matrix+!")
            disp("To get started, create a Matrix+ Object using")
            disp(" ")
            disp("     A = Matrix(a)   where a is a matrix.")
            disp(" ")
            disp("Matrix Manipulation")
            disp("  >> A.get() : returns a MatLab matrix of A")
            disp("  >> A.getRow(int x) : returns row x of A")
            disp("  >> A.getCol(int y) : returns row y of A")
            disp("  >> A.rref() : returns the rref of A")
            disp("  >> A.det() : returns the determinant of A")
            disp("  >> A.inv() : returns the inverse of A")
            disp("  >> A.rank() : returns rank of A")
            disp("  >> A.null() : returns the nullspace of A")
            disp("  >> A.adj() : returns the adjoint of A")
            disp("  >> A.transpose() : returns the transpose of A")
            disp("  >> A.sym() : returns the symbolic matrix of A")
            disp("  >> A.norm() : returns the norm if A is a column vector")
            disp(" ")
            disp("Row Operations")
            disp("  >> A.rowOp(string expression) : performs row operation on A")
            disp('  Multiply: R1 -> 3R1 gives the expression "R1 *= 3"')
            disp('  Swap:     R1 <-> R2 gives the expression "R1 <-> R2"')
            disp('  Row Sum:  R1 += 3R2 gives the expression "R1 += 3R2"')
            disp(" ")
            disp("Orthogonal functions")
            disp('  >> A.gramSchmidt() : extends A to a orthonormal basis for R^n')
            disp('  >> A.gramSchmidtEcon() : Finds a orthonormal basis for A')
            disp('  >> A.leastSquare(Matrix b) : Finds the least square solution set of Ax = b')
            disp(" ")
            disp("Eigenvalue and Eigenvectors")
            disp('  >> A.findEigVals() : Returns sorted eigenvalues of A')
            disp('  >> A.findEigPoly() : Returns characteristic polynomial of A')
            disp('  >> A.findEigSpace(int eigVal) : Finds a basis for the eigenspace of eigVal')
            disp('  >> [P D] = A.findDiag() : Finds matrices P, D such that A = P * D * P.inv()')
            disp(' ')
            disp("Decompositions and Factorizations ")
            disp('  >> [U S V] = A.autoSVD() : Find U,S,V such that U * S * V = A, S diagonal, U, V orthogonal ')
        end
    end

    % Overriding custom display Method from interface
    methods (Access = protected)
        % Override CustomDisplay
        function displayScalarObject(obj)
            disp("M+")
            disp(obj.matrix)
        end
    end

    % Overriding MATLAB Operators
    methods
        function newMatrix = plus(obj1, obj2)
            newMatrix = Matrix.of(obj1.matrix + obj2.matrix);
        end
        function newMatrix = minus(obj1, obj2)
            newMatrix = Matrix.of(obj1.matrix - obj2.matrix);
        end
        function newMatrix = mtimes(obj1, obj2)
            if (isa(obj1, 'Matrix') & isa(obj2, 'Matrix'))
                newMatrix = Matrix.of(obj1.matrix * obj2.matrix);
            elseif (isa(obj1, 'Matrix'))
                newMatrix = Matrix.of(obj1.matrix * obj2);
            elseif (isa(obj2, 'Matrix'))
                newMatrix = Matrix.of(obj1 * obj2.matrix);
            end
        end
        function newMatrix = times(obj1, factor)
            newMatrix = Matrix.of(obj1.matrix * factor);
        end
        function newMatrix = mpower(obj, pow)
            newMatrix = Matrix.of(obj.matrix^pow);
        end
        function newMatrix = power(obj, pow)
            newMatrix = Matrix.of(obj.matrix.^pow);
        end
        function newMatrix = horzcat(A, B)
            newMatrix = Matrix.of([A.matrix B.matrix]);
        end
        function newMatrix = vertcat(A, B)
            newMatrix = Matrix.of([A.matrix; B.matrix]);
        end
        % FUTURE: Work on Matrix-matrix Concatenation
        % FUTURE2: Work on Matrix-matrix operations
    end

    % General Methods
    % ==================
    methods 
        % Convert to Symbolic
        function newMatrix = sym(obj)
            newMatrix = Matrix.of(sym(obj.matrix));
        end

        % Basic functions
        function newMatrix = inv(obj)
            if (obj.det() == 0)
                error("ERROR: Matrix is Singular")
            end
            newMatrix = Matrix.of(inv(obj.matrix));
        end
        function newMatrix = transpose(obj)
            newMatrix = Matrix.of(transpose(obj.matrix));
        end 
        function D = det(obj)
            D = det(obj.sym().matrix);
        end
        function newMatrix = adj(obj)
            newMatrix = Matrix.of(adjoint(obj.matrix));
        end
        function newMatrix = null(obj)
            newMatrix = Matrix.of(null(obj.matrix));
        end
        function val = norm(obj)
            val = sym(norm(obj.matrix));
        end

        % RREF
        function newMatrix = rref(obj)
            newMatrix = Matrix(rref(obj.matrix));
        end

        % Elementary row Operations
        % Takes in an expression expr and does a row Operation
        function newMatrix = rowOp(obj, expr)
            % InvalidExpressionException
            if (~isa(expr, 'string'))
                error('ERROR: expression is not a valid String!')
            end

            % Row swap operation
            if (contains(expr, "<->"))
                pat = "R" + digitsPattern(1);
                rawRow = extract(expr, pat);
                rows = [0 0];
                rows(1) = gRow(rawRow(1));
                rows(2) = gRow(rawRow(2));
                newMatrix = Matrix.of(swap(obj.matrix, rows(1), rows(2)));

            % Scalar Multiplication 
            elseif (contains(expr, '*='))
                pat = "R" + digitsPattern(1);
                rawRow = extract(expr, pat);
                row = gRow(rawRow);
                factor = extractAfter(expr, "*=");
                factor = str2num(factor);
                newMatrix = Matrix.of(mult(obj.matrix, row, factor));
            
            % Row addition
            elseif (contains(expr, "+="))
                pat = "R" + digitsPattern(1);
                rawRow = extract(expr, pat);
                rows = [0 0];
                rows(1) = gRow(rawRow(1));
                rows(2) = gRow(rawRow(2));
                factor = str2num(erase(erase(erase(expr, rawRow(1)), rawRow(2)), "+="));
                newMatrix = Matrix.of(rsum(obj.matrix, rows(1), rows(2), factor));
            
            % Row subtraction
            elseif (contains(expr, "-="))
                pat = "R" + digitsPattern(1);
                rawRow = extract(expr, pat);
                rows = [0 0];
                rows(1) = gRow(rawRow(1));
                rows(2) = gRow(rawRow(2));
                factor = -1 * str2num(erase(erase(erase(expr, rawRow(1)), rawRow(2)), "-="));
                newMatrix = Matrix.of(rsum(obj.matrix, rows(1), rows(2), factor));
            else
                error("ERROR: Invalid Row Operation Expression")
            end
        end

        % Orthogonal functions
        function newMatrix = gramSchmidt(obj)
            rawA = gramSchmidt(obj.matrix);
            newMatrix = Matrix.of(rawA);
        end
        function newMatrix = gramSchmidtEcon(obj)
            rawA = gramSchmidtEcon(obj.matrix);
            newMatrix = Matrix.of(rawA);
        end
        function newMatrix = leastSquare(obj, b)
            if (isa(b, "Matrix"))
                b = b.get();
            end
            rawSol = leastSquare(obj.matrix, b);
            newMatrix = Matrix.of(rawSol);
        end

        % Eigen-Functions
        function findEigPoly(obj)
            findEigPoly(obj.matrix)
        end
        function findEigVals(obj)
            vals = simplify(eig(sym(obj.matrix)));
            disp(sort(vals)')
        end
        function P = findEigSpace(obj, lambda)
            P = Matrix.of(findEigSpace(obj.matrix, lambda));
        end
        function checkDiag(obj)
            checkDiag(obj.matrix)
        end
        function [P D] = findDiag(obj)
            try
            nargoutchk(2, 2)
            catch e
                error("Error: Not enough outputs. Do '[P D] = A.findDiag()'")
            end
            [rawP rawD] = findDiag(obj.matrix);
            P = Matrix.of(rawP);
            D = Matrix.of(rawD);
        end
        function [U S V] = autoSVD(obj)
            try
            nargoutchk(3, 3)
            catch e
                error("Error: Not enough outputs. Do '[U S V] = A.autoSVD()'")
            end
            [rawU rawS rawV] = autoSVD(obj.matrix);
            U = Matrix.of(rawU);
            S = Matrix.of(rawS);
            V = Matrix.of(rawV);
        end

    end
end
