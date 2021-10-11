function [rho, rho_f, g, h, T0, X0, Y0, W0, rho_bar, nu, d, A, B, C, ...
    u_f, v_f, theta0, x_r, delta_theta, epsilon] = ...
    set_properties(u_v_type, y_height)
% SET_PROPERTIES Initialization of construction and medium properties

    % rho - body density [kg/m^3]
    % rho_f - fluid density [kg/m^3]
    % g - gravitational acceleration [m/s^2]
    % h - time step [s]
    % X0 - initial X position [m]
    % Y0 - initial Y position [m]
    % T0 - initial time instant [s]
    % W0 - initial velocity [m^2/s]
    % nu - kinematic viscosity [m^2/s]
    % d - body diameter [m]
    % x_r - distance between the origin and the intersection point of
    % trajectory and X-axis [m]
    % delta_theta - angle step [°]
    % epsilon - residual [°]
    % u_f - horizontal component of fluid velocity [m/s]
    % v_f - vertical component of fluid velocity [m/s]
    
    % Given constants
    rho = 8000;
    rho_f = 1.22 * exp(-0.000118 * y_height);
    g = 9.8;
    h = 0.1;
    X0 = 0;
    Y0 = 0;
    T0 = 0;
    W0 = 50;
    theta0 = 30;
    nu = 1.49e-5;
    d = 0.05;
    x_r = 40;
    delta_theta = 10;
    epsilon = 1e-3;
    
    
    % Set velocity components calculation type
    switch u_v_type
        case 'eq'
            u_f = W0 * cos(theta0 * pi / 180);
            v_f = W0 * sin(theta0 * pi / 180);
        case '~eq'
            u_f = 20;
            v_f = 0;
    end
    
    
    % Problem parameters
    rho_bar = rho_f / rho;
    A = 1 + rho_bar * 0.5;
    B = (1 - rho_bar) * g;
    C = 3 * rho_bar / (4 * d);
    
end
