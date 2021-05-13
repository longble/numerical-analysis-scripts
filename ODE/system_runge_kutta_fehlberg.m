clc; clear; close all;


%   INPUT
f = @(t,y) [y(2); y(3); -4*sin(t) - 3*y(3) - 3*y(2) - y(1)];
h = .01;
t = [0:h:2];
y = [1;1;-1]; 
y_star = y;


%   Main
for n=1:length(t)-1
    [calculatedY, calculatedY_Star] = RungeKuttaMethod(f,t(n),y(:,n),h);
    y(:,n+1) = calculatedY;
    y_star(:,n+1) = calculatedY_Star;
end
error = y - y_star;


%   Plots
figure(1);
plot(t,y)
grid on;
xlabel('t') 
ylabel('y')
title("Solutions of y''' + 3y'' + 3y' + y = -4sin(t), y(0) = 1, 1, -1")

figure(2);
plot(t,error)
grid on;
xlabel('t') 
ylabel('Error y - y*')
title('Error vs t')


function [calculatedY,calculatedY_Star] = RungeKuttaMethod(f,x,y,h)
    k1 = h*f(x,y);
    k2 = h*f(x + (1/4)*h, y + (1/4)*k1);
    k3 = h*f(x + (3/8)*h, y + (3/32)*k1 + (9/32)*k2);
    k4 = h*f(x + (12/13)*h, y + (1932/2197)*k1 - (7200/2197)*k2 + (7296/2197)*k3);
    k5 = h*f(x + h, y + (439/216)*k1 - 8*k2 + (3680/513)*k3 - (845/4104)*k4);
    k6 = h*f(x + (1/2)*h, y - (8/27)*k1 + 2*k2 + (3544/2565)*k3 - (1859/4104)*k4 - (11/40)*k5);
    calculatedY = fehlbergsFifthOrderRK(y,k1,k2,k3,k4,k5,k6);
    calculatedY_Star = fehlbergsFourthOrderRK(y,k1,k2,k3,k4,k5);
end


function yn1 = fehlbergsFifthOrderRK(y,k1,k2,k3,k4,k5,k6)
    gamma = [16/135 0 6656/12825 28561/56430 -9/50 2/55];
    yn1 = y + gamma(1)*k1 + gamma(2)*k2 + gamma(3)*k3 + gamma(4)*k4 + gamma(5)*k5 + gamma(6)*k6;
end


function yn1star = fehlbergsFourthOrderRK(y,k1,k2,k3,k4,k5)
    gamma = [25/216 0 1408/2565 2197/4104 -1/5];
    yn1star = y + gamma(1)*k1 + gamma(2)*k2 + gamma(3)*k3 + gamma(4)*k4 + gamma(5)*k5;
end