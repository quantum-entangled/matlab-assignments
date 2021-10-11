function [diam, max_range, opt_angle] = interval_halving_method(n, ...
    delta_theta, epsilon, T0, X0, Y0, W0)
% INTERVAL_HALVING_METHOD Implementation of half-interval method in order
% to find the maximum range and optimum shooting angle values for different
% sphere diameters
    
    % Parameters
    global C d rho_bar h
    
    
    % Vectors initialization
    diam = zeros(n, 1);
    max_range = zeros(n, 1);
    opt_angle = zeros(n, 1);
    
    
    % Calculate for different diameters
    for i = 1:n
        % Recalculate the coefficient with new diameter
        C = 3 * rho_bar / (4 * d);
        
        
        % Initial values
        theta_old = 0;
        x_r_old = 40;
        delta = delta_theta;

        
        % Half-interval method
        while abs(delta) >= epsilon
            % Change the angle by delta
            theta_new = theta_old + delta;
            
            
            % Initial values
            T = T0;
            X = X0;
            Y = Y0;
            U = W0 * cos(theta_new * pi / 180);
            V = W0 * sin(theta_new * pi / 180);
            
            
            % Call landing function to compute the point after landing
            [T, X, Y, U, V] = landing(T, X, Y, U, V);
            
            x_q = X(end);
            y_q = Y(end);
            
            
            % Step back with Runge-Kutta method to find previous point
            [~, y] = ode45(@F, [T(end), T(end)-h], [X(end), Y(end), ...
                U(end), V(end)]);
            
            x_p = y(end, 1);
            y_p = y(end, 2);
            
            
            % New range value from the equation for similarity of 
            % two shaded triangles
            x_r_new = (x_q * y_p - x_p * y_q) / (y_p - y_q);

            
            % Change the delta value or reassign the old values
            if x_r_old >= x_r_new
                delta = -delta / 2;
            else
                theta_old = theta_new;
                x_r_old = x_r_new;
            end
        end

        
        % Maximum range and optimum shooting angle values
        if (x_r_old >= x_r_new)
            x_r_max = x_r_old;
            optimum_theta = theta_old;
        else
            x_r_max = x_r_new;
            optimum_theta = theta_new;
        end


        % Save values
        diam(i) = d;
        max_range(i) = x_r_max;
        opt_angle(i) = optimum_theta;


        % Change the diameter
        d = d + 0.005;     
    end

end

