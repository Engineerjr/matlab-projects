% MATLAB Script to Plot Polar and Nyquist Plots for G(s)H(s) = 10 / (s*(s + 1))
clear; clc; close all;

%% Define the Open-Loop Transfer Function
num = 10;
den = [1 1 0]; % s^2 + s + 0
G = tf(num, den);



%% 2. Nyquist Plot
figure('Name', 'Nyquist Plot');
nyquist(G);
title('Nyquist Plot of G(s)H(s) = 10 / (s(s + 1))');
grid on;