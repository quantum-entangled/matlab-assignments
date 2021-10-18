function [X_intersec, Y_intersec, elem_num] = points_search(X, Y, PSI, PSI_a)
% POINTS_SEARCH Search for all the points coordinates (X,Y) at which 
% a vertical grid line intersects with the streamline PSI = PSI_a
    
    % Parameters
    global m n k dy;
    
    X_intersec = zeros(k, 1);
    Y_intersec = zeros(k, 1);

    c = 0;
    
    
    % Examine every interval on each of the grid lines
    for i = 1:m
        j = 1;
        
        while (j <= n)
            P = PSI(i,j) - PSI_a;
            
            % Condition for intersection
            if abs(P) <= 1e-5
                c = c + 1;
                X_intersec(c) = X(i);
                Y_intersec(c) = Y(j);
            else
                % Else examine the intervals across which P * Q <= 0
                while (j < n)
                    j = j + 1;
                    Q = PSI(i,j) - PSI_a;
                    
                    if P * Q > 0.0
                        P = Q;
                    else
                        % Compute coordinates
                        c = c + 1;
                        X_intersec(c) = X(i);
                        Y_intersec(c) = Y(j) - dy * ...
                            abs(Q) / (abs(P) + abs(Q));
                        P = PSI(i,j) - PSI_a;
                    end
                end
            end
            
            j = j + 1;
        end
    end

    elem_num = c;

end

