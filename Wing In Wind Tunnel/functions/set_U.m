function U = set_U(T, U_type)
% U Calculation of dimensionless horizontal velocity depending on its 
% type (fluctuating or not)
    
    % Parameters
    global given_U a omega
    
    
    % Horizontal velocity (based on case)
    switch U_type
        case "~fluc"
            U = given_U;
        case "fluc"
            U = given_U * (1 + a * sin(omega * T));
    end

end

