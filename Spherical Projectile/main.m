% Clean data
clc;
clear;


% Initialize the parameters
global A B C d nu rho_bar u_f v_f h;

[rho, rho_f, g, h, T0, X0, Y0, W0, rho_bar, nu, d, A, B, C, ...
    u_f, v_f, theta0, x_r, delta_theta, epsilon] = ...
    set_properties('eq', 5);

% Switch type of main task
main_type = 'find_trajectory';

switch main_type
    case 'find_trajectory'
        % Solve the projectile trajectory
        [T, X, Y, U, V] = landing(T0, X0, Y0, u_f, v_f);


        % Plot the results
        figure();
        plot(X, Y);
        grid on;
        xlabel('Range X, m');
        ylabel('Height Y, m');
        title('Projectile trajectory');
    case 'find_opt_angle'
        % Find the maximum range and optimum shooting angle for different 
        % sphere diameters
        [diam, max_range, opt_angle] = interval_halving_method(5, ...
            delta_theta, epsilon, T0, X0, Y0, W0);
        
        disp("Max range for different diameters: ");
        disp([diam, max_range]);


        % Plot the results
        figure();
        semilogx(diam, opt_angle, 'o');
        grid on;
        xlabel('Diameter, m');
        ylabel('Angle, °');
        title('Optimum shooting angle');
end