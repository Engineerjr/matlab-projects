% --- BJT Characteristic Curves Simulation ---
clear; clc; close all;

% --- Transistor Parameters ---
Is = 1e-14;      % Saturation current (A)
VT = 0.026;      % Thermal voltage at 300K (~26mV)
eta = 1.0;       % Ideality factor
VA = 100;        % Early voltage (V)
beta = 100;      % Current gain

% ==========================================
% 1. Output Characteristics (Ic vs Vce)
% ==========================================
Vce = linspace(0, 10, 500);         % Vce from 0V to 10V
Ib_list_uA = [10, 20, 30, 40, 50];  % Base currents in microamps

figure('Name', 'Transistor Characteristic Curves', 'Position', [100, 100, 1100, 450]);

subplot(1, 2, 1);
hold on; grid on; box on;

for i = 1:length(Ib_list_uA)
    Ib_uA = Ib_list_uA(i);
    Ib = Ib_uA * 1e-6; % Convert to Amps
    
    % Compute Vbe required for the base current
    Vbe = VT * log((Ib * beta / Is) + 1);
    
    % Compute Ic with Early effect
    Ic = Is * (exp(Vbe / (eta * VT)) - 1) * (1 + Vce / VA);
    
    % Apply saturation transition factor
    sat_factor = 1 - exp(-Vce / 0.2);
    Ic = Ic .* sat_factor;
    
    % Plot in mA
    plot(Vce, Ic * 1000, 'LineWidth', 2, ...
        'DisplayName', sprintf('I_B = %d \\muA', Ib_uA));
end

title('Output Characteristics (I_C vs V_{CE})', 'FontSize', 11);
xlabel('Collector-Emitter Voltage V_{CE} (V)');
ylabel('Collector Current I_C (mA)');
legend('Location', 'northwest');
xlim([0, 10]);

% ==========================================
% 2. Transfer Characteristic (Ic vs Vbe)
% ==========================================
Vbe = linspace(0.4, 0.8, 500);  % Vbe from 0.4V to 0.8V
Vce_fixed = 5.0;                 % Fixed Vce

Ic_transfer = Is * (exp(Vbe / (eta * VT)) - 1) * (1 + Vce_fixed / VA);

subplot(1, 2, 2);
plot(Vbe, Ic_transfer * 1000, 'r-', 'LineWidth', 2);
grid on; box on;

title(sprintf('Transfer Characteristic (I_C vs V_{BE} at V_{CE} = %.1fV)', Vce_fixed), 'FontSize', 11);
xlabel('Base-Emitter Voltage V_{BE} (V)');
ylabel('Collector Current I_C (mA)');
xlim([0.4, 0.8]);