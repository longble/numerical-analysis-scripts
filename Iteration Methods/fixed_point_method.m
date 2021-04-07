clc; clear;

%   INPUT
f = @(x) x^3 + x - 1;               %   function
g1_x = @(x) 1/(1+x^2);              %   x = g1(x)
g2_x = @(x) 1-x^3;                  %   x = g2(x)
g1_xd = @(x) -(2*x)/(x^2 + 1)^2;    %   g1'(x)
g2_xd = @(x) 3*x^2;                 %   g2'(x)
x0 = 1;                             %   initial guess
eps = .1;                           %   tolerance
N = 10;                             %   max number of iterations


% %   DERIVATIVE SOLVER
% syms x 
% gx = 1-x^3
% abs(diff(gx))


[root, iterations] = fixedPointMethod(g1_x,g1_xd,x0,eps,N)


function [root, iterations] = fixedPointMethod(g_x,g_xd,x0,eps,N)
    if checkConvergence(g_xd,x0) == true
        stopCheck = false;
        n=0;
        while stopCheck == false && n ~= N
            x_n = x0;
            x_n1 = g_x(x_n);
            iteration = 1;
            for n=0:N
                x_n = x_n1;
                x_n1 = g_x(x_n);
                iteration = iteration+1;
                relativeError = relativeErrorCalc(x_n1,x_n);
                stopCheck = stoppingCriteria(relativeError,eps);
                if stopCheck == true
                    break
                end
            end
        end
    else
        disp('DOES NOT CONVERGE. SELECT A DIFFERENT G(x):')
    end
    root = x_n1;
    iterations = iteration;
end


function convergenceResults = checkConvergence(g_xd,x0)
    if g_xd(x0) <= 1
        convergenceResults = true;
    else
        convergenceResults = false;
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