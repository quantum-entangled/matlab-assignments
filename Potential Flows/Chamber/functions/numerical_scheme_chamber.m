function [PSI_new] = numerical_scheme_chamber(PSI_guessed)
% NUMERICAL_SCHEME Solve Poisson equation for the flow through the chamber

    % Parameters
    global m n last_j_val;
    
    iter = 0;
    error = 1;
    max_err = 1e-3;
    
    alpha = cos(pi/m) + cos(pi/n);
    omega = (8 - 4 * sqrt(4 - alpha^2)) / alpha^2;
    PSI_new = zeros(m, n);
    
    
    % PSI boundary conditions
    for j = 1:n
        PSI_new(1,j) = 1;
    end

    for j = 1:9
        PSI_new(m,j) = 1;
    end

    for i = 2:m-1
        if i > 7 && i < 22
            PSI_new(i,1) = 0;
        else
            PSI_new(i,1) = 1;
        end

        j = last_j_val(i);
        PSI_new(i,j) = 1;
    end
    
    
    % Guessed values for PSI
    for i = 2:m-1
        last = last_j_val(i) - 1;

        for j = 2:last
            PSI_new(i,j) = PSI_guessed;
        end
    end
    
    
    % Overrelaxation scheme
    while error > max_err
    iter = iter + 1;
    error = 0;
    
        for i = 2:m-1
            last = last_j_val(i) - 1;

            for j = 2:last
                PSI_old = PSI_new(i,j);
                PSI_new(i,j) = (1 - omega) * PSI_new(i,j) + omega * ...
                    (PSI_new(i-1,j) + PSI_new(i+1,j) + ...
                    PSI_new(i,j-1) + PSI_new(i,j+1)) / 4;

                error = error + abs(PSI_new(i,j) - PSI_old);
            end
        end
    end
    
    
    % Number of iterations
    disp(['Number of iterations: ', num2str(iter), '.']);

end