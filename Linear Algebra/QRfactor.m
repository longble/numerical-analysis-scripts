function eigValues = QRfactor(tridiagonal)
    B = tridiagonal;
    [n,m] = size(B);
    for i=1:10
        R = constructR(B,n);
        B = constructBn(R,B,n);
    end
    eigValues = diag(B);
end


function C = constructC(n,b,i,j)
    C = eye(n);
    cos_theta = 1/sqrt(1+(b(j,i)/b(i,i))^2);
    sin_theta = (b(j,i)/b(i,i))/sqrt(1+(b(j,i)/b(i,i))^2);
    C(i,i) = cos_theta;
    C(i,j) = sin_theta;
    C(j,i) = -sin_theta;
    C(j,j) = cos_theta;
end


function R = constructR(B,n)
    for i=1:n-1
        C = constructC(n,B,i,i+1);
        B = C*B;
    end
    R=B;
end


function Bn = constructBn(R,B,n)
    for i=1:n-1
        C = constructC(n,B,i,i+1);
        C_T = C';
        B = C*B;
        R = R*C_T;
    end
    Bn = R;
end