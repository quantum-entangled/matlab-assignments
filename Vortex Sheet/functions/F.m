function R = F(~, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global iter m G X Y;
    
    
    % Assign the required values 
    X_loc = y(1);
    Y_loc = y(3);
    F1 = 0;
    F2 = 0;
    
    
    % Right parts
    for j = 1:m
        if j ~= iter
            dX = X_loc - X(j);
            dY = Y_loc - Y(j);
            F1 = F1 + G(j) * dY / (dX^2 + dY^2);
        end
    end

    for j = 1:m
        if j ~= iter
            dX = X_loc - X(j);
            dY = Y_loc - Y(j);
            F2 = F2 - G(j) * dX / (dX^2 + dY^2);
        end
    end

    R = [F1; F1; F2; F2];
    
end

