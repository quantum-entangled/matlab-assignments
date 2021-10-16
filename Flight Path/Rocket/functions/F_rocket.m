function R = F_rocket(~, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global alpha beta g v_e;
    
    
    % Assign the required values
    Z = y(1);
    V = y(2);
    
    
    % Right parts
    R1 = V;
    R2 = -g + alpha * v_e - 0.5 * beta * V * abs(V);
    
    R = [R1; R2];
    
end

