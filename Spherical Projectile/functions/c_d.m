function c_d = c_d(v)
% C_D Computation of the approximate drag coefficient of a sphere
    
    % Parameters
    global d nu;
    
    
    % Reynolds number
    Re = v * d / nu;
    
    
    % Drag coefficient approximation
    if Re == 0
        c_d = 0;
    elseif Re <= 1
        c_d = 24 / Re;
    elseif (1 < Re) && (Re <= 400)
        c_d = 24 / Re^(0.646);
    elseif (400 < Re) && (Re <= 3e5)
        c_d = 0.5;
    elseif (3e5 < Re) && (Re <= 2e6)
        c_d = 0.000366 * Re^(0.4275);
    elseif Re > 2e6
        c_d = 0.18;
    end
    
end
