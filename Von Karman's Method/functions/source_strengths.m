function [Q, d, delta_d, right_part] = source_strengths(r, s, z, ...
    z_dash, approx_type)
% SOURCE_STRENGTHS Compute the source strengths by solving the system of n 
% simultaneous algebraic equations
    
    % Parameters
    right_part = zeros(10, 1);
    d = zeros(9, 11);
    delta_d = zeros(10, 10);

    
    % Compute the distances d and delta_d for different approximation cases
    for i = 1:9
        for j = 1:11
            switch approx_type
                case 'segments'
                    d(i,j) = sqrt(r(i)^2 + (z(i) - z_dash(j))^2);
                case 'discrete'
                    d(i,j) = r(i)^2 + (z(i) - z_dash(j))^2;
            end
        end
    end
    
    for i = 1:9
        for j = 1:10
            switch approx_type
                case 'segments'
                    delta_d(i,j) = d(i,j) - d(i,j+1);
                case 'discrete'
                    delta_d(i,j) = (z(i) - z_dash(j)) / sqrt(d(i,j));
            end
        end
    end
    
    
    % Matrix form of n simultaneous algebraic equations for the unknown 
    % source strengths
    for j = 1:10
        switch approx_type
            case 'segments'
                delta_d(10,j) = s(j);
            case 'discrete'
                delta_d(10,j) = 1;
        end
    end

    for i = 1:9
        right_part(i) = r(i)^2 / 2; 
    end

    right_part(10) = 0;


    % Source strengths
    fprintf('The reciprocal condition estimate of delta_d: %f.\n\n', ...
        rcond(delta_d));

    Q = mldivide(delta_d, right_part);

end

