% Clean data
clc;
clf;
clear;


% Parameters
global m n k h first_j_val;

m = 25;
n = 9;
k = 100;
h = 0.25;

first_j_val = zeros(m, 1);
PSI_guessed = 0.5;
X = zeros(m, 1);
Y = zeros(n, 1);
streamlines = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];


% Define along each vertical line the first j value
for i = 1:m
    first_j_val(i) = 2;
    
    if i >= 11 && i <= 15
        first_j_val(i) = 5;
    end
end

first_j_val(10) = 4;
first_j_val(13) = 6;
first_j_val(16) = 4;


% Calculate PSI
PSI = numerical_scheme_cylinder(PSI_guessed);


% Compute grid points coordinates
X(1) = 0;

for i = 2:m
    X(i) = X(i-1) + h;
end

Y(1) = 0;

for j = 2:n
    Y(j) = Y(j-1) + h;
end


% Plot results
hold on;

for i = 1:length(streamlines)
    [X_intersec, Y_intersec, elem_num] = points_search_cylinder(X, Y, ...
        PSI, streamlines(i));
    
    plot(X_intersec(1:elem_num), Y_intersec(1:elem_num), '.');
    plot(X_intersec(1:elem_num), -Y_intersec(1:elem_num), '.')
end

hold off;
title('Chanel flow past a circular cylinder');
xlabel('X');
ylabel('Y');
legend([repmat('\Psi = ', length(streamlines), 1), ...
    num2str(streamlines(:))]);