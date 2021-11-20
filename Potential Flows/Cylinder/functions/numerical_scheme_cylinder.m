function PSI_new = numerical_scheme_cylinder(PSI_guessed)
% NUMERICAL_SCHEME Solve Laplace equation for the flow around the circular 
% cylinder

    % Parameters
    global m n h first_j_val;
    
    iter = 0;
    error = 1;
    max_err = 1e-3;
    
    PSI_new = zeros(m, n);
    id = zeros(m, n);
    
    a = zeros(m, n);
    b = zeros(m, n);
    c = zeros(m, n);
    d = zeros(m, n);
    
    
    % PSI boundary conditions
    for i = 1:m
        first = first_j_val(i) - 1;

        for j = 1:first
            PSI_new(i,j) = 0;
        end
    end

    for i = 1:m
        PSI_new(i,n) = 1;
    end

    for j = 2:(n-1)
        PSI_new(1,j) = 1;
    end
    
    
    % Guessed values for PSI
    for i = 2:m
        for j = first_j_val(i):(n-1)
            PSI_new(i,j) = PSI_guessed;
        end
    end
    
    
    % ID numbers
    for i = 2:m
        for j = first_j_val(i):n-1
            id(i,j) = 0;

            if i == m
                id(i,j) = -1;
            end
        end
    end

    for i = 9:17
        j = first_j_val(i);
        id(i,j) = 1;
    end

    id(9,3) = 1;
    id(13,6) = 0;
    id(17,3) = 1;


    % Compute a, b, c, d
    for i = 9:17
        for j = 2:5
            if id(i,j) == 1
                a(i,j) = h;
                b(i,j) = h;
                c(i,j) = h;
                d(i,j) = h;

                if i == 9 || i == 10
                    b(i,j) = (13 - i) * h - sqrt(1 - ((j - 1) * h)^2);
                elseif i == 16 || i == 17
                    a(i,j) = (i - 13) * h - sqrt(1 - ((j - 1) * h)^2);
                elseif i >= 10 && i <= 16
                    c(i,j) = (j - 1) * h - sqrt(1 - ((13 - i) * h)^2);
                end
            end
        end
    end
    
    
    % Liebmann's method
    while error > max_err
        iter = iter + 1;
        error = 0;

        for i = 2:m
            for j = first_j_val(i):(n-1)
                PSI_old = PSI_new(i,j);

                if id(i,j) == -1
                    PSI_new(i,j) = (2 * PSI_new(i-1,j) + ...
                        PSI_new(i,j-1) + PSI_new(i,j+1)) / 4;
                elseif id(i,j) == 0
                    PSI_new(i,j) = (PSI_new(i-1,j) +  PSI_new(i+1,j) + ...
                        PSI_new(i,j-1) + PSI_new(i,j+1)) / 4;
                elseif id(i,j) == 1
                    tmp1 = a(i,j) + b(i,j);
                    tmp2 = c(i,j) + d(i,j);

                    PSI_new(i,j) = (PSI_new(i-1,j) / (a(i,j) * tmp1) + ...
                        PSI_new(i+1,j) / (b(i,j) * tmp1) + ...
                        PSI_new(i,j-1) / (c(i,j) * tmp2) + ...
                        PSI_new(i,j+1) / (d(i,j) * tmp2)) / ...
                        (1 / (a(i,j) * b(i,j)) + 1 / (c(i,j) * d(i,j)));
                end

                error = error + abs(PSI_new(i,j) - PSI_old);
            end
        end
    end
    
    
    % Number of iterations
    disp(['Number of iterations: ', num2str(iter), '.']);

end
