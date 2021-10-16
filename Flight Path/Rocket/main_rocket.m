clc;
clear;


% Parameters
global alpha beta g h v_e


% Assign the required values
g = 9.8;
m_c = 500 / g;
m_p0 = 1000 / g;
m_p = m_p(m_p0);
rho = 1.23;
A = 0.1;
v_e = 360;
c_d = 0.15;
h = 0.01;
alpha = m_p / (m_c + m_p);
beta = rho * A * c_d / (m_c + m_p);

n = 500;
T = zeros(n, 1);
Z = zeros(n, 1);
V = zeros(n, 1);


% Initial conditions
T(1) = 0;
Z(1) = 600;
V(1) = 250;


% Main loop
for j = 2:n
    [t, y] = ode45(@F_rocket, [T(j-1), T(j-1)+h], [Z(j-1), V(j-1)]);

    T(j) = t(end);
    Z(j) = y(end, 1);
    V(j) = y(end, 2);
end


% Plot results
title('Height of a rocket flight');
xlabel('T');
ylabel('Z');
xlim([min(T)-0.05, max(T)+0.05])
ylim([min(Z)-1, max(Z)+1])
hold on;

for i = 2:n
    plot([T(i-1), T(i)], [Z(i-1), Z(i)], '--b');
    pause(0.01);
end