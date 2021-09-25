% Clean data
clc;
clear;


% Initialize the parameters
global d nu A B C h t_max;
[d, nu, A, B, C, h, t_max] = set_properties(['Wood', 'Isopropanol']);


% Solve
[t1, y1] = my_ode45(@F, [0 t_max], [0 0]); % self-constructed solver
[t2, y2] = ode45(@F, [0 t_max], [0 0]); % MATLAB solver
[t3, y3] = ode23(@F, [0 t_max], [0 0]); % MATLAB solver


% Plot
figure(1);
plot(t1, y1(:, 1), 'r.', t2, y2(:, 1), 'b-', t3, y3(:, 1), 'g--');
title('v(t)');
xlabel('Time t, s');
ylabel('Velocity v, m/s');
xlim([0 t_max]);
legend('my\_ode45', 'ode45', 'ode23', 'Location', 'best');

figure(2);
plot(t1, y1(:, 2), 'r.', t2, y2(:, 2), 'b-', t3, y3(:, 2), 'g--');
title('z(t)');
xlabel('Time t, s');
ylabel('Distance z, m');
xlim([0 t_max]);
legend('my\_ode45', 'ode45', 'ode23', 'Location', 'best');
