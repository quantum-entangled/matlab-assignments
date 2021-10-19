function [t, y] = my_ode45_rocket(F, tspan, y0)
% MY_ODE45 Implementation of Runge-Kutta method for solving ODE
    
    % Parameters
    global h;
    
    
    % Vectors initialization
    n = round((tspan(2) - tspan(1)) / h);
    
    y = zeros(n+1, 2);
    t = zeros(n+1, 1);
    
    
    % Initial conditions
    t(1) = tspan(1);
    y(1, 1) = y0(1);
    y(1, 2) = y0(2);
    
    
    % Runge-Kutta method
    for i = 1:n
       t(i+1) = t(i) + h;
       
       tmp1 = y(i, 2);
       d1_z = h * tmp1;
       tmp2 = F(t(i), [y(i, 1), tmp1]);
       d1_v = h * tmp2(2);
       
       tmp1 = y(i, 2) + 0.5 * d1_v;
       d2_z = h * tmp1;
       tmp2 = F(t(i), [y(i, 1) + 0.5 * d1_z, tmp1]);
       d2_v = h * tmp2(2);
       
       tmp1 = y(i, 2) + 0.5 * d2_v;
       d3_z = h * tmp1;
       tmp2 = F(t(i), [y(i, 1) + 0.5 * d2_z, tmp1]);
       d3_v = h * tmp2(2);
       
       tmp1 = y(i, 2) + d3_v;
       d4_z = h * tmp1;
       tmp2 = F(t(i), [y(i, 1) + d3_z, tmp1]);
       d4_v = h * tmp2(2);
       
       y(i+1, 1) = y(i, 1) + (d1_z + 2 * d2_z + 2 * d3_z + d4_z) / 6;
       y(i+1, 2) = y(i, 2) + (d1_v + 2 * d2_v + 2 * d3_v + d4_v) / 6;
    end
    
end