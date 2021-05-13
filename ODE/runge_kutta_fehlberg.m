clc; clear; close all;

%   INPUT
f = @(x,y) (y-x-1)^2 + 2;   
y0 = 1;
x0 = 0;
h = .1;
N = 1;

%   Main
x = x0;
y = y0;
y_star = y0;
error = 0;
[x,y,y_star,error] = RKF(f,x,y,h,N);
x
y
y_star
error


function [x,y,y_star,error] = RKF(f,x,y,h,N)
format longg
    for n=1:N
        k1 = h*f(x(n),y(n));
        k2 = h*f(x(n) + 1/4*h, y(n) + 1/4*k1);
        k3 = h*f(x(n) + 3/8*h, y(n) + 3/32*k1 + 9/32*k2);
        k4 = h*f(x(n) + 12/13*h, y(n) + 1932/2197*k1 - 7200/2197*k2 + 7296/2197*k3);
        k5 = h*f(x(n) + h, y(n) + 439/216*k1 - 8*k2 + 3680/513*k3 - 845/4104*k4);
        k6 = h*f(x(n) + 1/2*h, y(n) - 8/27*k1 + 2*k2 - 3544/2565*k3 + 1859/4104*k4 - 11/40*k5);
        x(n+1) = x(n) + h;
        y(n+1) =  fehlbergFifthOrder(y(n),k1,k2,k3,k4,k5,k6);
        y_star(n+1) = fehlbergFourthOrder(y(n),k1,k2,k3,k4,k5);
        error(n+1) = y(n+1) - y_star(n+1);
    end
end


function y_n1 = fehlbergFifthOrder(yn,k1,k2,k3,k4,k5,k6)
    coeff = [16/135 0 6656/12825 28561/56430 -9/50 2/55];
    a = coeff(1)*k1;
    b = coeff(2)*k2;
    c = coeff(3)*k3;
    d = coeff(4)*k4;
    e = coeff(5)*k5;
    f = coeff(6)*k6;
    y_n1 = (yn + a + b + c + d + e + f);
end


function y_star_n1 = fehlbergFourthOrder(yn,k1,k2,k3,k4,k5)
    coeff = [25/216 0 1408/2565 2197/4104 -1/5];
    a = coeff(1)*k1;
    b = coeff(2)*k2;
    c = coeff(3)*k3;
    d = coeff(4)*k4;
    e = coeff(5)*k5;
    y_star_n1 = (yn + a + b + c + d + e);
end