function [d, nu, A, B, C, h, t_max] = set_properties(material)
% SET_PROPERTIES Initialization of body and medium properties

    % rho - body density [kg/m^3]
    % rho_f - fluid density [kg/m^3]
    % g - gravitational acceleration [m/s^2]
    % nu - kinematic viscosity [m^2/s]
    % d - body diameter [m]
    % h - time step [s]
    % t_max - time limit [s]

    switch material
        case ['Steel', 'Air'] % steel spheres in air
            rho = 8000;
            rho_f = 1.22;
            g = 9.8;
            nu = 1.49e-5;
            d = 0.01;
            h = 0.1;
            t_max = 10;
        case ['Air', 'Water'] % "air" spheres in water
            rho = 1.22;
            rho_f = 1000;
            g = 9.8;
            nu = 1e-6;
            d = 0.036;
            h = 0.1;
            t_max = 10;
        case ['Lead', 'Glycerin'] % lead spheres in glycerin
            rho = 1540;
            rho_f = 1260;
            g = 9.8;
            nu = 1e-3;
            d = 0.03;
            h = 0.05;
            t_max = 10;
        case ['Wood', 'Isopropanol'] % wooden spheres in isopropyl alcohol
            rho = 1540;
            rho_f = 786;
            g = 9.8;
            nu = 3e-6;
            d = 0.05;
            h = 0.1;
            t_max = 10;
     end


    % Coefficients
    rho_dash = rho_f / rho;
    A = 1 + 0.5 * rho_dash;
    B = (1 - rho_dash) * g;
    C = 3 * rho_dash / (4 * d);

end