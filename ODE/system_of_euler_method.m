clc; clear; close all;

%   INPUT
f1 = @(x,y1,y2) y2;
f2 = @(x,y1,y2) -2*y2 - 0.75*y1;
y1_0 = 3;
y2_0 = -2.5;
x0 = 0;
h = .2;
N = 1;

%   Main
x = x0;
y1 = y1_0;
y2 = y2_0;
% [x,y2] = eulerMethod(f1,x,y1,y2,h,N)
y1n = y1(1) + h*f1(0.2,y1_0,y2_0)
y2n = y2(1) + h*f2(0.2,y1_0,y2_0)



function [x,y] = eulerMethod(f,x,y,y2,h,N)
format longg
    for n=1:N
        x(n+1) = x(n) + h;
        y(n+1) =  y(n) + h*f(x(n),y1(n),y2(n))
    end
    [x,y];
end