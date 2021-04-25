clc; clear;


%   INPUT
% x = [0 20 40 60 80 100];                %   x-data
% y = [26.0 48.6 61.6 71.2 74.8 75.2];    %   y-data
x = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
y = [0 0.1 0.5 1 1.5 3 2.5 1.5 1 0.7 0.9 1.2 1.8 2 1.9 1.6 1.3 1 0.9 0.8 0.7];
n = length(x) - 1;                      %   order of polynomial; n-1
xp = 9.2;                                %   x location between known points

if length(x) == length(y)
    format longg
    [Pn,error] = lagrangeMethod(x,y,n,xp)
else
    disp('INVALID DATA SET')
end

plot(x,y)


function [Pn1,error] = lagrangeMethod(x,y,n,xp)
    Pn1 = 0;
    f = y;
    for i=1:n+1
        li_x =1;
        for j=1:n+1
            if j~=i
                li_x = li_x*(xp-x(j))/(x(i)-x(j));
            end
        end
        Pn = Pn1;
        Pn1 = Pn + li_x*f(i);
        error = (Pn1-Pn)/Pn;
    end
end