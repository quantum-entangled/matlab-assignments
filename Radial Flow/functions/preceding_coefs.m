function [C, PHI] = preceding_coefs(C, n)
% PRECEDING_COEFS Solve the set of n linear algebraic equations 
% simultaneously for the n unknowns f(i).

    % Eliminating process
    for i = 2:n-1
        C(i,2) = C(i,2) * C(i-1,2) - C(i,1) * C(i-1,3);
        C(i,3) = C(i,3) * C(i-1,2);
        C(i,4) = C(i,4) * C(i-1,2) - C(i,1) * C(i-1,4);
    end

    % Compute the solution
    PHI = zeros(n, 1);
    PHI(n) = (C(n,4) * C(n-1,2) - C(n,1) * C(n-1,4)) / (C(n,2) * ...
        C(n-1,2) - C(n,1) * C(n-1,3));

    for j = n-1:-1:1
        PHI(j) = (C(j,4) - C(j,3) * PHI(j+1)) / C(j,2);
    end
    
end