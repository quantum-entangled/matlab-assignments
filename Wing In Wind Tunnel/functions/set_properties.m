function [alpha0, beta, T0, V0, Z0, U_type, V_type, given_U, a, omega, ...
    h, t_max] = set_properties(type1, type2)
% SET_PROPERTIES Initialization of construction and medium properties

    % rho_f - fluid density [kg/m^3]
    % k - spring constant [kg/s^2]
    % g - gravitational acceleration [m/s^2]
    % S - projected wing area [m^2]
    % a - amplitude coefficient
    % omega - frequency coefficient
    % given_alpha0 - angle between airfoil and horizontal [°]
    % given_U - dimensionless horizontal wind speed
    % given_h - time step [s]
    % given_t_max - time limit [s]
    
    
    % Given constants
    rho_f = 1.22;
    k = 980;
    g = 9.8;
    S = 0.3;
    a = 0.2;
    omega = 1;
    given_alpha0 = 10;
    given_U = 100;
    given_h = 0.1;
    given_t_max = 20;
    
    
    % Problem parameters
    alpha0 = given_alpha0 * pi / 180;
    beta = rho_f * g * S / (2 * k);
    T0 = 0;
    V0 = 0;
    Z0 = 0;
    h = 0 + given_h;
    t_max = 0 + given_t_max;
    
    
    % Set the type of fluctuating or not fluctuating horizontal velocity
    switch type1
        case "~fluctuatingU"
            U_type = "~fluc";
        case "fluctuatingU"
            U_type = "fluc";
    end
    
    
    % Set the type of fluctuating or not fluctuating vertical velocity
    switch type2
        case "~fluctuatingV"
            V_type = "~fluc";
        case "fluctuatingV"
            V_type = "fluc";
    end
    
end

