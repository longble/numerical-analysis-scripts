clc; clear;

%   INPUT
f = @(x) x^7 - 1000;  % Function
f_d = @(x) 7*x^6;     % Derivative of Function
x0 = 2;                 % Initial Guess
eps = 0.1;              % Tolerance
N = 10;                 % Max. number of iterations

% %   DERIVATIVE SOLVER
% syms x 
% gx = 1-x^3
% abs(diff(gx))


[roots, iterations] = newtonsMethod(f,f_d,x0,eps,N)

function [root, iterations] = newtonsMethod(f,f_d,x0,eps,N)
    x_n = x0;
    if f_d(x_n) == 0
        disp('Failure.')
    else
        stopCheck = false;
        n=0;
        while stopCheck == false && n ~= N
            x_n1 = x_n - (f(x_n)/f_d(x_n));
            iterations = 1;
            for n=0:N
                x_n = x_n1;
                if f_d(x_n) == 0
                    disp('Failure.')
                end
                x_n1 = x_n - (f(x_n)/f_d(x_n));
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

