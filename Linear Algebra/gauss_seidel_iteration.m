clc; clear;


%   INPUT
A = [0 .25 .25 0;
    .25 0 0 .25;
    .25 0 0 .25;
    0 .25 .25 0];

b = [50 50 25 25]';
eps = 0.1;
N = 10;
n=length(A);
x = zeros(n,1);         %   Initial Guess = 0


[x,iter] = gaussSeidal(A,b,x,eps,n,N)

%   GS Method
function [x,m] = gaussSeidal(A,b,x,eps,n,N)
    % err = zeros(n,1);       %   error
    err = inf;
    x_new = 0;
    m=0;
    while err > eps && m<N
        for m=1:N
            for i=1:n
                xold=x(i);
                for j=1:n
                    x_m = A(i,j)*x(j);
                    x_new = x_new + x_m;
                end
                x(i) = x_new + b(i);
                err = abs(x(i)-xold);
                x_new=0;
            end
        end
    end
end

