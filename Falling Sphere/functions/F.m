function R = F(~, y)
% F Computation of the right-hand side of ODE system
    
    % Parameters
    global d nu A B C;
    
    
    % Reynolds number
    Re = y(1) * d / nu;
    
    
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
    
    % Right parts
    R1 = (1 / A) * (B - C * y(1) * abs(y(1)) * c_d);
    R2 = y(1);
    
    R = [R1; R2];
    
end