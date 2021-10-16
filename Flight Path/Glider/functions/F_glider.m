function R = F_glider(~, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global A B
    
    
    % Assign the required values
    X = y(1);
    U = y(2);
    Y = y(3);
    V = y(4);
    
    
    % Right parts
    F1 = -A * sqrt(U^2 + V^2) * (B * U + V);
    F2 = -1 + A * sqrt(U^2 + V^2) * (U - B * V);
    
    R = [U; F1; V; F2];
    
end

