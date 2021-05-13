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
[x,y] = RKM(f,x,y,h,N)
plot(x,y)


function [x,y] = RKM(f,x,y,h,N)
    for n=1:N
        k1 = h*f(x(n),y(n));
        k2 = h*f(x(n) + 1/2*h, y(n) + 1/2*k1);
        k3 = h*f(x(n) + 1/2*h, y(n) + 1/2*k2);
        k4 = h*f(x(n) + h, y(n) + k3);
        x(n+1) = x(n) + h;
        y(n+1) =  y(n) + ((k1 + 2*k2 + 2*k3 + k4)/6);
    end
    [x,y];
end