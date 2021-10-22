function [r, s, z, z_dash] = coordinates(a)
% COORDINATES Compute the position of the source segments end points (or 
% discrete point sources) and the surface points coordinates

    % Parameters
    phi = zeros(9, 1);
    r = zeros(9, 1);
    s = zeros(10,1);

    z = zeros(9, 1);
    z_dash = zeros(11, 1);

    
    % Position of the source segments end points or discrete point sources
    z_dash(1) = -0.8 * a;

    for i = 2:11
        z_dash(i) = z_dash(i-1) + 0.16 * a;
        s(i-1) = 0.16 * a;
    end


    % Coordinates of the surface points
    for i = 1:9
        phi(i) = (10 - i) * pi / 10;
        r(i) = a * sin(phi(i));
        z(i) = a * cos(phi(i));
    end
    
end

