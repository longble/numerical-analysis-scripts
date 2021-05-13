clc; clear; close all;

%   INPUT
f1 = @(x,y) y;
f2 = @(x,y) -2*y2 - 0.75*y1;
y0 = 0;
x0 = 0;
h = .2;
N = 5;

%   Main
x = x0;
y = y0;
[x,y] = eulerMethod(f,x,y,h,N)


function [x,y] = eulerMethod(f,x,y,h,N)
format longg
    for n=1:N
        x(n+1) = x(n) + h;
        y(n+1) =  y(n) + h*f(x(n),y(n))
    end
    [x,y];
end