clc; clear; close all;

A0 = [6 4 1 1;
    4 6 1 1;
    1 1 5 2;
    1 1 2 5];

B0 = householderTrid(A0);
eigEstimate = QRfactor(B0)

eig(A0)