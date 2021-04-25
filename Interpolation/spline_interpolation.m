clc; clear; close all;

%   INPUT 
x = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
f = [0 0.1 0.5 1 1.5 3 2.5 1.5 1 0.7 0.9 1.2 1.8 2 1.9 1.6 1.3 1 0.9 0.8 0.7];
n = length(x);
fp0 = 0.1;
fpn = -0.1;


%   Calculate h
h = [];
for i=1:n-1
    h(i) = x(i+1)-x(i);
end


%   Constructs A matrix for simultaneous equations
A = eye(n);
A(1,1) = 2*h(1);        %   added for clamped splines
A(1,2) = h(1);          %   added for clamped splines
A(n,n-1) = h(n-1);      %   added for clamped splines
A(n,n) = 2*h(n-1);      %   added for clamped splines

for i=2:n-1
    A(i,i)= 2*(h(i-1) + h(i));
    A(i,i-1) = h(i-1);
    A(i,i+1) = h(i);
end
A;


%   Constructs B Vector for simultaneous equations
B=zeros(4,1);
B(1) = 3*(f(2)-f(1))/(x(2)-x(1)) - 3*fp0;       %   added for clamped spline
B(n) = 3*fpn - 3*(f(n)-f(n-1))/(x(n)-x(n-1));   %   added for clamped spline

for i=2:n-1
    B(i) = 3*((f(i+1)-f(i))/(x(i+1)-x(i)) - (f(i)-f(i-1))/(x(i)-x(i-1)));
end
B;


%   solve for c coefficients
c = inv(A)*B;


%   solves for b and d coefficients
d = [];
b = [];
for i=1:n-1
   d(i) = (c(i+1)-c(i))/(3*(h(i)));
   b(i) = ((f(i+1) - f(i))/h(i)) - (h(i)/3)*(2*c(i) + c(i+1));
end


%   construct spline model
yy=[];
xx=linspace(x(1),x(n),200);
j=1;
for i=1:n-1
    while j<= length(xx) && xx(j) <= x(i+1)
        yy(j) = cubicPolynomial(i,xx(j),x,f,b,c,d);
        j = j+1;
    end
end
yy;

%   Plots data points and spline model
figure;
plot(x,f,'ro');
hold on;
plot(xx,yy,'b','LineWidth',1.5);
grid on;
legend('Data Points', 'Spline Model')


%   Calculates polynomials
function s = cubicPolynomial(i,xx,x,a,b,c,d)
    e = (xx-x(i));
    s = a(i) + b(i)*e + c(i)*e^2 + d(i)*e^3;
end


