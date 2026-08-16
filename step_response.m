%% QUESTION 2: Unit-Step Response of a Mass-Spring-Damper System

clc;
clear;
close all;

%% System parameters
m = 4;          % Mass (kg)
c = 20;         % Damping coefficient (N.s/m)
k = 30;         % Spring stiffness (N/m)

%% Transfer function
% G(s) = X(s)/F(s) = 1/(m*s^2 + c*s + k)

num = 1;
den = [m c k];

G = tf(num, den);

%% Display transfer function
disp('Transfer Function G(s) = X(s)/F(s):');
G

%% Unit-step response
figure;
step(G);
grid on;

title('Unit-Step Response of Mass-Spring-Damper System');
xlabel('Time (s)');
ylabel('Displacement x(t) (m)');

%% Step response information
info = stepinfo(G);

disp('Step Response Information:');
disp(info);

%% Poles of the system
poles = pole(G);

disp('System Poles:');
disp(poles);

%% Damping ratio and natural frequency
wn = sqrt(k/m);                 % Natural frequency
zeta = c/(2*sqrt(m*k));         % Damping ratio
wd = wn*sqrt(1-zeta^2);         % Damped natural frequency

fprintf('Natural frequency, wn = %.4f rad/s\n', wn);
fprintf('Damping ratio, zeta = %.4f\n', zeta);
fprintf('Damped natural frequency, wd = %.4f rad/s\n', wd);

%% Analytical unit-step response
t = 0:0.01:5;

x = (1/k) * (1 - exp(-zeta*wn*t) .* ...
    (cos(wd*t) + (zeta*wn/wd)*sin(wd*t)));

%% Plot analytical response
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;

title('Analytical Unit-Step Response');
xlabel('Time (s)');
ylabel('Displacement x(t) (m)');