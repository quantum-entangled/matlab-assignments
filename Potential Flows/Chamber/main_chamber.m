% Clean data
clc;
clf;
clear;


% Parameters
global m n k h last_j_val;

m = 25;
n = 17;
k = 100;
h = 0.25;

last_j_val = zeros(m, 1);
PSI_guessed = 0.5;
X = zeros(m, 1);
Y = zeros(n, 1);
streamlines = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];


% Define along each vertical line the last j value
for i = 1:n
    last_j_val(i) = n;
end

for i = n+1:m
    last_j_val(i) = n - i + n;
end


% Calculate PSI
PSI = numerical_scheme_chamber(PSI_guessed);


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
    [X_intersec, Y_intersec, elem_num] = points_search_chamber(X, Y, ...
        PSI, streamlines(i));
    
    plot(X_intersec(1:elem_num), Y_intersec(1:elem_num), '.');
end

hold off;
title('Pattern of flow through a chamber');
xlabel('X');
ylabel('Y');
legend([repmat('\Psi = ', length(streamlines), 1), ...
    num2str(streamlines(:))]);