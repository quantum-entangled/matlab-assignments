function PSI = F(X, Y)
% F Computation of the right-hand side of dimensionless stream function
% equation
    
    % Uniform and five doublets
    c = [0.15, 0.3, 0.2, 0.1, 0.05];
    d = [-1, -0.5, 0, 0.5, 1];

    PSI = Y;
    
    for i = 1:length(d)
        PSI = PSI - c(i) * Y / ((X - d(i) - 1e-6)^2 + Y^2); 
    end

    
%     % Uniform and source
%     PSI = Y - 3 / (2 * pi) * atan((Y - 1e-6) / X) / pi;
    
    
%     % Uniform and sink
%     PSI = Y + 3 / (2 * pi) * atan((Y - 1e-6) / X) / pi;

    
%     % Source and doublet
%     PSI = 3 / (2 * pi) * atan((Y - 1e-6) / (X + 2)) / pi - ...
% 	    1.5 / (2 * pi) * Y / ((X - 1e-6)^2 + Y^2);

    
%     % Uniform and two doublets (X)
%     d = 2;
%     
%     PSI = Y - 1.5 / (2 * pi) * (Y / ((X - 0.1 - 1e-6)^2 + Y^2) + ...
%         Y / ((X - 0.1 - d - 1e-6)^2 + Y^2));

    
%     % Two vortices
%     d = 1;
%     G = 4;
%     
%     PSI = G / (2 * pi) * 0.5 * log(X^2 + (Y - d - 1e-6)^2) - ...
%         G / (2 * pi) * 0.5 * log(X^2 + (Y + d - 1e-6)^2);

    
%     % Uniform and two doublets (Y)
%     PSI = Y - 3 / (2 * pi) * (Y / ((X - 1e-6)^2 + (Y - 1)^2) + ...
%         Y / ((X - 1e-6)^2 + (Y + 1)^2));

    
%     % Uniform (30°) and doublet
%     PSI = (Y * cosd(30) - X * sind(30)) - 0.3 * Y / ((X - 1e-6)^2 + Y^2);
    
end
