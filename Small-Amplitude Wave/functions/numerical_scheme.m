function u = numerical_scheme(u, m, j_max)
% NUMERICAL_SCHEME Compute the solution for the fluid properties using 
% leapfrog numerical scheme
    
    % Leapfrog method
    for j = 2:j_max-1
        for i = 2:m-1
            u(i,j+1) = u(i-1,j) + u(i+1,j) - u(i,j-1);
        end

        u(m,j+1) = 2 * u(m-1,j) - u(m,j-1);
    end

end

