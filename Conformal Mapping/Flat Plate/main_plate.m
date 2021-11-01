% Clean data and set display format
clc;
clear;


% Parameters
global m n k dy;

x_max = 3;
x_min = -3;
y_max = 3;
y_min = -3;
x_max_dash = 3;
x_min_dash = -3;
y_max_dash = 3;
y_min_dash = -3;

dx_dash = 0.05;
dy_dash = 0.05;

m = (x_max_dash - x_min_dash) / dx_dash + 1;
n = (y_max_dash - y_min_dash) / dy_dash + 1;
k = 250;

x = zeros(k, 1);
y = zeros(k, 2);
psi = zeros(m, n);
streamlines = zeros(10, 1);
phi = zeros(k, 1);
c_p = zeros(k, 1);

alpha = 10;
U = 1.0;
dy = dy_dash;


% Define grid points (z_dash-plane) and evaluate stream function
x_dash = linspace(x_min_dash, x_max_dash, m)';
y_dash = linspace(y_min_dash, y_max_dash, n)';

for i = 1:m
    for j = 1:n
        z_dash = x_dash(i) + 1i*y_dash(j);
        psi(i,j) = U * imag(z_dash * exp(-1i*alpha) + exp(1i*alpha) / ...
            z_dash);
    end
end


% Search for points on the first streamline (z_dash-plane), map it and plot
% results
streamlines(1) = -2;

[x_intersec, y_intersec, elem_num] = points_search(x_dash, y_dash, ...
    psi, streamlines(1));

[x_map, y_map, elem_num_map] = mapping_plate(x_intersec, y_intersec, ...
    elem_num, x_min, x_max, y_min, y_max);

figure(1);
plot(x_map(1:elem_num_map), y_map(1:elem_num_map), '.k', 'MarkerSize', 3);
xlim([x_min, x_max]);
ylim([y_min, y_max]);
title('Flat Plate');
xlabel('X');
ylabel('Y');


% Search for points on every other streamline (z_dash-plane), map it and 
% plot results
hold on;

for i = 2:length(streamlines)
    streamlines(i) = streamlines(i-1) + 0.5;
    
    [x_intersec, y_intersec, elem_num] = points_search(x_dash, y_dash, ...
        psi, streamlines(i));
    
    [x_map, y_map, elem_num_map] = mapping_plate(x_intersec, ...
        y_intersec, elem_num, x_min, x_max, y_min, y_max);
    
    plot(x_map(1:elem_num_map), y_map(1:elem_num_map), '.k', ...
        'MarkerSize', 3);
end

hold off;


% Coordinates of the circular cylinder surface points (z_dash2-plane) and
% calculation of velocity and pressure coefficient
d_phi = pi / 100;

for i = 1:k
    if i > 1
        phi(i) = phi(i-1) + d_phi;
    else
        phi(i) = 0;
    end

    z_dash = exp(1i*phi(i));
    
    z = z_dash + 1 / z_dash;
    x(i) = real(z);
    y(i) = imag(z);
    
    V = U * abs((exp(-1i*alpha) - exp(1i*alpha) / z_dash^2) / ...
        (1 - (1 / z_dash)^2));
    c_p(i) = 1 - (V / U)^2;
end


% Print results
figure(2);
plot(x, c_p, '.k', 'MarkerSize', 3);
ylim([y_min, y_max]);
title('Pressure distribution around the airfoil');
xlabel('X');
ylabel('Pressure coefficient c_p');