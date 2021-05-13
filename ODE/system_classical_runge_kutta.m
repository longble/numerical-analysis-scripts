clc; clear; close all;

%   INPUT
f = @(x,y) [y(2); x*y(1)];
h = .2;
x = [0:h:1];
y = [0.35502805; -.25881940]; 


%   Main
for n=1:5
    calculatedY = RungeKuttaMethod(f,x(n),y(:,n),h);
    y(:,n+1) = calculatedY;
end
plot(x,y)


function calculatedY = RungeKuttaMethod(f,x,y,h)
    k1 = h*f(x,y);
    k2 = h*f(x + (1/2)*h, y + (1/2)*k1);
    k3 = h*f(x + (1/2)*h, y + (1/2)*k2);
    k4 = h*f(x + h, y + k3);
    calculatedY = y + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
end
