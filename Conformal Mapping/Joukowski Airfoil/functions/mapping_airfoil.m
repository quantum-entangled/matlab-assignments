function [x_map, y_map, elem_num_map] = mapping_airfoil(x_intersec, y_intersec, ...
    elem_num, x_min, x_max, y_min, y_max)
% MAPPING Examine each intersection point and return its mapped form if 
% satisfies the mapping conditions

    % Parameters
    global a b z_p_dash;

    x_map = zeros(elem_num);
    y_map = zeros(elem_num);
    
    
    % Number of mapped points
    elem_num_map = 0;
    
    
    % Examine each point and put away ones which map inside the airfoil or
    % are outside the domain boundaries
    for i = 1:elem_num
        z_dash = x_intersec(i) + 1i*y_intersec(i);
        z_dash2 = z_dash - z_p_dash;
        
        
        % Complex number modulus
        r = abs(z_dash2);
        
        
        % Check if point is outside the circle
        if r >= 0.99 * a
            z = z_dash + b^2 / z_dash;
            x = real(z);
            y = imag(z);
        end
        
        
        % Check the domain boundary conditions
        if x >= x_min || x <= x_max || y >= y_min || y <= y_max
            elem_num_map = elem_num_map + 1;
            x_map(elem_num_map) = x;
            y_map(elem_num_map) = y;
        end
    end

end