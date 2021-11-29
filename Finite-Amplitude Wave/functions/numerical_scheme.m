function u = numerical_scheme(u, a)
% NUMERICAL_SCHEME Compute the solution for the fluid properties using 
% Courant-Isaacson-Rees numerical scheme
    
    % Parameters
    global m j_max a0 ratio coef;
    
    check = 0;
    
    
    % Courant-Isaacson-Rees method
    for j = 1:j_max
        cond1 = ratio * (u(1,j) + a(1,j));
        cond2 = ratio * (u(1,j) - a(1,j));

        if abs(cond1) <= 1 || abs(cond2) <= 1
            u_b = u(1,j) - cond2 * (u(2,j) - u(1,j));
            a_b = a(1,j) - cond2 * (a(2,j) - a(1,j));
            a(1,j+1) = a_b - coef * u_b;

            for i = 2:(m-1)
                cond1 = ratio * (u(i,j) + a(i,j));
                cond2 = ratio * (u(i,j) - a(i,j));

                if abs(cond1) <= 1 || abs(cond2) <= 1
                    u_a = u(i,j) + cond1 * (u(i-1,j) - u(i,j));
                    a_a = a(i,j) + cond1 * (a(i-1,j) - a(i,j));
                    u_b = u(i,j) - cond2 * (u(i+1,j) - u(i,j));
                    a_b = a(i,j) - cond2 * (a(i+1,j) - a(i,j));
                    u(i,j+1) = 0.5 * ((u_a + u_b) + (a_a - a_b) / coef);
                    a(i,j+1) = 0.5 * (coef * (u_a - u_b) + (a_a + a_b));
                else
                    break;
                end
            end

            if check == 0
                cond1 = ratio * (u(m,j) + a(m,j));
                cond2 = ratio * (u(m,j) - a(m,j));

                if abs(cond1) <= 1 || abs(cond2) <= 1
                    u_a = u(m,j) + cond1 * (u(m-1,j) - u(m,j));
                    a_a = a(m,j) + cond1 * (a(m-1,j) - a(m,j));
                    u(m,j+1) = u_a + (a_a - a0) / coef;
                else
                    break;
                end
            end
        else
            break;
        end
    end

end