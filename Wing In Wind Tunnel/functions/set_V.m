function V = set_V(T, given_V, V_type)
% V Calculation of dimensionless vertical velocity depending on its 
% type (fluctuating or not)
    
    % Parameters
    global U_type a omega
    
    
    % Vertical velocity (based on case)
    switch V_type
        case "~fluc"
            V = given_V;
        case "fluc"
            V = given_V + a * set_U(T, U_type) * sin(omega * T);
    end

end
