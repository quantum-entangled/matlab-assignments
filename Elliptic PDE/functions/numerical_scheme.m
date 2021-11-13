function [PSI_new] = numerical_scheme(zeta, PSI_guessed, max_iter, ...
    max_err, method)
% NUMERICAL_SCHEME Solve Poisson equation for the flow around a vortex
% using iterative formulae of different numerical schemes

    % Parameters
    global m n h;
    
    iter = 0;
    error = 0.1;
    
    PSI_new = zeros(m, n);
    PSI_old = zeros(m, n);
    
    
    % PSI boundary conditions
    for i = 1:m
        PSI_new(i,1) = 0;
        PSI_new(i,n) = 0;
    end

    for j = 2:n-1
        PSI_new(1,j) = 0;
        PSI_new(m,j) = 0;
    end
    
    
    % Guessed values for PSI
    for i = 2:m-1
        for j = 2:n-1
            PSI_new(i,j) = PSI_guessed;
        end
    end
    
    
    % Switch numerical scheme type
    switch method
        case 'richardson'
            while error > max_err && iter < max_iter
                iter = iter + 1;
                error = 0;
                
                for i = 2:m-1
                    for j = 2:n-1
                        PSI_new(i,j) = (PSI_old(i-1,j) + ...
                            PSI_old(i+1,j) + PSI_old(i,j-1) + ...
                            PSI_old(i,j+1) + h^2 * zeta(i,j)) / 4;

                        error = error + abs(PSI_new(i,j) - PSI_old(i,j));
                        
                        PSI_old(i,j) = PSI_new(i,j);
                    end
                end
            end
        case 'liebmann'
            while error > max_err && iter < max_iter
                iter = iter + 1;
                error = 0;
                
                for i = 2:m-1
                    for j = 2:n-1
                        PSI_new(i,j) = (PSI_new(i-1,j) + ...
                            PSI_old(i+1,j) + PSI_new(i,j-1) + ...
                            PSI_old(i,j+1) + h^2 * zeta(i,j)) / 4;

                        error = error + abs(PSI_new(i,j) - PSI_old(i,j));
                        
                        PSI_old(i,j) = PSI_new(i,j);
                    end
                end
            end
        case 'sor'
            alpha = cos(pi/m) + cos(pi/n);
            omega = (8 - 4 * sqrt(4 - alpha^2)) / alpha^2;
            
            while error > max_err && iter < max_iter
                iter = iter + 1;
                error = 0;
                
                for i = 2:m-1
                    for j = 2:n-1
                        PSI_new(i,j) = PSI_old(i,j) + omega * ...
                            (PSI_new(i-1,j) + PSI_old(i+1,j) + ...
                            PSI_new(i,j-1) + PSI_old(i,j+1) - ...
                            4 * PSI_old(i,j) + h^2 * zeta(i,j)) / 4;

                        error = error + abs(PSI_new(i,j) - PSI_old(i,j));
                        
                        PSI_old(i,j) = PSI_new(i,j);
                    end
                end
            end
    end
    
    disp(['Number of iterations: ', num2str(iter), '.']);

end

