clc; clear;

%   INPUT
x = [8.0 9.0 9.5 11.0]';                         % Values for X
f = [2.079442 2.197225 2.251292 2.397895]';      % f(x)
x_i = 9.2;                                       % value of interest

% First, we find the Newton Coefficient, a. That is,
%function a = newtonCoeff(X,Y)
n = length(x(:,1));                     
a = f;                                  
for k = 2:n                           
    a(k:n) = (a(k:n) - a(k-1))./(x(k:n)- x(k-1));
end

% Given by: p(x) = a0 + (x-x0)[a1 + (x-x1)[a2 + (x-x2)[a3 + (x-x3)[a4 +
% (x-x4)[a5]]]]]
% NOTE: This is achieved by deploying a backward recursion:

p = a(n);
for k = 1:n-1;
    p = a(n-k) + (x_i - x(n-k))*p;
end
p
