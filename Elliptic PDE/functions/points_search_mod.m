function [X_intersec, Y_intersec, elem_num] = points_search_mod(X, Y, ...
    PSI, PSI_a)
% POINTS_SEARCH Search for all the points coordinates (X,Y) at which 
% a vertical grid line intersects with the streamline PSI = PSI_a
    
    % Parameters
    global m n k h;
    
    X_intersec = zeros(k, 1);
    Y_intersec = zeros(k, 1);

    c = 0;
    
    
    % Examine every interval on each of the grid lines
    for i = 1:m
        j = 1;
        
        while j <= n
            P = PSI(i,j) - PSI_a;
            
            % Condition for intersection
            if abs(P) <= 1e-5
                c = c + 1;
                X_intersec(c) = X(i);
                Y_intersec(c) = Y(j);
            else
                % Else examine the intervals across which P * Q <= 0
                while j < n
                    j = j + 1;
                    Q = PSI(i,j) - PSI_a;
                    
                    if P * Q > 0
                        P = Q;
                    else
                        % Compute the coordinates
                        c = c + 1;
                        X_intersec(c) = X(i);
                        Y_intersec(c) = Y(j) - h * ...
                            abs(Q) / (abs(P) + abs(Q));
                        P = PSI(i,j) - PSI_a;
                    end
                end
            end
            
            j = j + 1;
        end
    end
    
    for j = 1:n
        i = 1;
        
        while i <= m
            P = PSI(i,j) - PSI_a;
            
            % Condition for intersection
            if abs(P) <= 1e-5
                c = c + 1;
                X_intersec(c) = X(i);
                Y_intersec(c) = Y(j);
            else
                % Else examine the intervals across which P * Q <= 0
                while i < m
                    i = i + 1;
                    Q = PSI(i,j) - PSI_a;
                    
                    if P * Q > 0
                        P = Q;
                    else
                        % Compute the coordinates
                        c = c + 1;
                        X_intersec(c) = X(i) - h * ...
                            abs(Q) / (abs(P) + abs(Q));
                        Y_intersec(c) = Y(j);
                        P = PSI(i,j) - PSI_a;
                    end
                end
            end
            
            i = i + 1;
        end
    end
    
    % Number of points
    elem_num = c;

end
