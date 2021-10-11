% Clean data
clc;
clear;


% Initialize the parameters
global alpha0 beta U_type V_type given_U a omega h t_max;

[alpha0, beta, T0, V0, Z0, U_type, V_type, given_U, a, omega, ...
    h, t_max] = set_properties('fluctuatingU', 'fluctuatingV');


% Solve
[t1, y1] = my_ode45(@F, [T0 t_max], [Z0 V0]); % self-constructed solver
[t2, y2] = ode45(@F, [T0 t_max], [Z0 V0]); % MATLAB solver


% Assign the required values
z1 = y1(:, 1);
v1 = y1(:, 2);
z2 = y2(:, 1);
v2 = y2(:, 2);


% Plot
figure(1);
plot(t1, z1, 'r--', t2, z2, 'b-');
title('Z(T)');
xlabel('Time T, nondimensional');
ylabel('Displacement Z, nondimensional');
xlim([0 t_max]);
legend('my\_ode45', 'ode45', 'Location', 'best');