function [V, V_exac, V_err, c_p, c_p_exac, c_p_err] = values(r, z, ...
    z_dash, Q, d, U, a, approx_type)
% VALUES Compute velocity and pressure coefficient at each surface point 
% and compare it with exact solutions

    % Parameters
    V = zeros(9, 1);
    V_exac = zeros(9, 1);
    V_err = zeros(9, 1);
    c_p = zeros(9, 1);
    c_p_exac = zeros(9, 1);
    c_p_err = zeros(9, 1);
    
    
    % Computation
    for i = 1:9
        % Velocity components
        u_r = 0;
        u_z = 1;

        for j = 1:10
            switch approx_type
                case 'segments'
                    u_r = u_r + Q(j) / r(i) * ((z(i) - z_dash(j+1)) / ...
                        d(i,j+1) - (z(i) - z_dash(j)) / d(i,j));
                    u_z = u_z + Q(j) * (1 / d(i,j+1) - 1 / d(i,j));
                case 'discrete'
                    u_r = u_r + Q(j) * r(i) / d(i,j)^(3/2);
                    u_z = u_z + Q(j) * (z(i) - z_dash(j)) / d(i,j)^(3/2);
            end
        end

        V(i) = U * sqrt(u_r^2 + u_z^2);
        V_exac(i) = 3 * U * r(i) / (2 * a);
        V_err(i) = abs(V(i) - V_exac(i)) / 100;

        c_p(i) = 1 - (u_r / U)^2 - (u_z / U)^2;
        c_p_exac(i) = 1 - (9 / 4) * (r(i) / a)^2;
        c_p_err(i) = abs(c_p(i) - c_p_exac(i)) / 100;
    end
    
end

