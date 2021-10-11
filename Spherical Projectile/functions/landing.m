function [T, X, Y, U, V] = landing(T0, X0, Y0, U0, V0)
% LANDING Calculation of projectile parameters from the throw to the 
% moment of landing

    % Parameters
    global h;
    
    
    % Iterator
    i = 1;
    
    
    % Initial parameters
    T(i) = T0;
    X(i) = X0;
    Y(i) = Y0;
    U(i) = U0;
    V(i) = V0;
     
    
    % Calculation
    while Y(i) >= 0
       [t, y] = ode45(@F, [T(i), T(i)+h], [X(i), Y(i), U(i), V(i)]);
       i = i + 1;
       
       T(i) = t(end);
       X(i) = y(end, 1);
       Y(i) = y(end, 2);
       U(i) = y(end, 3);
       V(i) = y(end, 4);
    end
    
end

