function R = F(t, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global beta U_type V_type;
    
    
    % Assign the required values
    Z = y(1);
    V = set_V(t, y(2), V_type);
    U = set_U(t, U_type);
    cl = c_l(V, t);
    
    
    % Right parts
    R1 = V;
    R2 = -(2 * pi)^2 * Z + beta * cl * U * ...
        sqrt(U * U + V * V);
    
    R = [R1; R2];
    
end
