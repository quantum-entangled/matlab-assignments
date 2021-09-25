function c_l = c_l(V, T)
% C_L Computation of the wing lift coefficient
    
    % Parameters
    global alpha0 U_type
    
    U = set_U(T, U_type);
    
    
    % Lift coefficient with condition -18 <= alpha <= 18
    alpha = alpha0 - atan(V / U);
    
    if abs(alpha) <= 18 * pi / 180
        c_l = 2 * pi * alpha;
    else
        c_l = 0;
    end
    
end

