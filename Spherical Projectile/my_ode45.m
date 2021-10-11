function [t, y] = my_ode45(F, tspan, y0)
% MY_ODE45 Implementation of Runge-Kutta method for solving ODE
    
    % Parameters
    global h;
    
    
    % Vectors initialization
    n = round((tspan(2) - tspan(1)) / h);
    
    t = zeros(n+1, 1);
    y = zeros(n+1, 4);
    
    
    % Initial conditions
    t(1) = tspan(1);
    y(1, 1) = y0(1);
    y(1, 2) = y0(2);
    y(1, 3) = y0(3);
    y(1, 4) = y0(4);
    
    
    % Runge-Kutta method
    for i = 1:n
       t(i+1) = t(i) + h;
       
       X = y(i, 1);
       Y = y(i, 2);
       U = y(i, 3);
       V = y(i, 4);
       
       d1_x = h * y(i, 3);
       d1_y = h * y(i, 4);
       tmp = F(t(i), [X, Y, U, V]);
       d1_u = h * tmp(3);
       d1_v = h * tmp(4);
       
       d2_x = h * (U + d1_u/2);
       d2_y = h * (V + d1_v/2);
       tmp = F(t(i), [X + d1_x/2, Y + d1_y/2, U + d1_u/2, V + d1_v/2]);
       d2_u = h * tmp(3);
       d2_v = h * tmp(4);
       
       d3_x = h * (U + d2_u/2);
       d3_y = h * (V + d2_v/2);
       tmp = F(t(i), [X + d2_x/2, Y + d2_y/2, U + d2_u/2, V + d2_v/2]);
       d3_u = h * tmp(3);
       d3_v = h * tmp(4);
       
       d4_x = h * (U + d3_u);
       d4_y = h * (V + d3_v);
       tmp = F(t(i), [X + d3_x, Y + d3_y, U + d3_u, V + d3_v]);
       d4_u = h * tmp(3);
       d4_v = h * tmp(4);
       
       y(i+1, 1) = X + (d1_x + 2*d2_x + 2*d3_x + d4_x) / 6;
       y(i+1, 2) = Y + (d1_y + 2*d2_y + 2*d3_y + d4_y) / 6;
       y(i+1, 3) = U + (d1_u + 2*d2_u + 2*d3_u + d4_u) / 6;
       y(i+1, 4) = V + (d1_v + 2*d2_v + 2*d3_v + d4_v) / 6;
    end
    
end
