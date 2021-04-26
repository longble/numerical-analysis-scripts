function B0 = householderTrid(matrix)
    [n,m] = size(matrix);
    I = eye(n);
    v = [];
    A = matrix;
    for r=1:n-2
        for j=1:n
            if j==1 || j==r
                v(j,r) = 0;
            elseif j==r+1
                S = calcS(A,j,r,n);
                sgn = calcSgn(A,j,r);
                v(j,r) = sqrt((1/2)*(1+(abs(A(j,r))/S)));
            elseif j==r+2
                v_const = v(j-1,r);
                num = A(j,r)*sgn;
                den = 2*v_const*S;
                v(j,r) = num/den;
            else
                num = A(j,r)*sgn;
                den = 2*v_const*S;
                v(j,r) = num/den;
            end
        end
        V = v(:,r);
        P = I - 2*V*V';
        %   Similarity Tranforms
        A = P*A*P;
    end
    B0 = A;
end


function Sn = calcS(matrix,i,r,n)
    X = 0;
    for i=i:n
        Xn = matrix(i,r)^2;
        X = X + Xn;
    end
%     X
    Sn = sqrt(X);
end


function sgn = calcSgn(matrix,row,column)
    if matrix(row,column) >= 0
        sgn = 1;
    else
        sgn = -1;
    end
end