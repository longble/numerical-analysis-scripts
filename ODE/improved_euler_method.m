clc; clear; close all;

%   INPUT
f = @(x,y) y+x;   
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
        k1 = h*f(x(n),y(n));
        k2 = h*f(x(n+1), y(n) + k1);
        y(n+1) =  y(n) + ((k1 + k2)/2);
    end
    [x,y];
end