function R = F(~, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global A B C u_f v_f;
    
    
    % Assign the required values
    U = y(3);
    V = y(4);
    
    w_r = sqrt((u_f - U)^2 + (v_f - V)^2);
    
    
    % Right parts
    R1 = C * c_d(w_r) * (u_f - U) * w_r / A;
    R2 = (-B + C * c_d(w_r) * (v_f - V) * w_r) / A;
    
    R = [U; V; R1; R2];
    
end

