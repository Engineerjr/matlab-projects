clear; clc; close all;
num = [10];
den = [1 1 0];
sys=tf(num,den)
nyquist(sys)