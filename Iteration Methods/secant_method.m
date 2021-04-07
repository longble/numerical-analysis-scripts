clc; clear;

%   INPUT
f = @(x) x - 2*sin(x);     % Function
x0 = 2;                 % Initial Guess
x1 = 1.9;               % Initial Guess Two
eps = 0.1;              % Tolerance
N = 3;                 % Max. number of iterations


[roots, iterations] = secantMethod(f,x0,x1,eps,N)


function [root, iterations] = secantMethod(f,x0,x1,eps,N)
    x_nm1 = x0;
    x_n = x1;
    Nn = f(x_n) * (x_n - x_nm1);
    Dn = f(x_n) - f(x_nm1);
    x_n1 = x_n - Nn/Dn;
    x_n1 - x_n;
    
    stopCheck = false;
    n=0;
    while stopCheck == false && n ~= N
           
            iterations = 1;
            for n=0:N
                x_nm1 = x_n;
                x_n = x_n1;
%                 Nn = f(x_n) * (x_n - x_nm1);  %   Math check
%                 Dn = f(x_n) - f(x_nm1);       %   Math check
                x_n1 = x_n - Nn/Dn;
%                 x_n1 - x_n;                   %   Math check

                iterations = iterations + 1;
                relativeError = relativeErrorCalc(x_n1,x_n);
                stopCheck = stoppingCriteria(relativeError,eps);
                if stopCheck == true
                    break
                end
            end
    end
    root = x_n1;
    iterations = iterations;
end


function error = relativeErrorCalc(x_n1,x_n)
    num = x_n1 - x_n;
    den = x_n;
    error = abs(num/den);
end


function stopResults = stoppingCriteria(error, tolerance)
    if error < tolerance
       stopResults = true;
    else
        stopResults = false;
    end
end

