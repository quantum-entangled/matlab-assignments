% Clean data
clc;
clear;
clf;


% Parameters
global m n k h;

x_max = 3;
x_min = -3;
y_max = 2;
y_min = -2;

h = 0.25;
m = (x_max - x_min) / h + 1;
n = (y_max - y_min) / h + 1;
k = 100;

PSI_new = zeros(m, n);
PSI_old = zeros(m, n);
zeta = zeros(m, n);

zeta0 = 100;
X0 = 1;
Y0 = 1;
PSI_guessed = 0.5;
max_iter = 300;
max_err = 1e-4;
method = 'sor';
streamlines = [0.05, 0.2, 0.5, 1, 1.5];

plot_markers = ['d', 'o', 's', 'v', '^', '+'];


% Compute grid points coordinates
X = linspace(x_min, x_max, m);
Y = linspace(y_min, y_max, n);


% Compute vortices coordinates and zeta values
x_vort1_coord = (X0 - x_min) / h + 1;
y_vort1_coord = (Y0 - y_min) / h + 1;

for i = 1:m
    for j = 1:n
        zeta(i,j) = 0;
    end
end

zeta(x_vort1_coord,y_vort1_coord) = zeta0;

x_vort2_coord = (-X0 - x_min) / h + 1;
y_vort2_coord = (-Y0 - y_min) / h + 1;

zeta(x_vort2_coord,y_vort2_coord) = zeta0;


% Calculate PSI
PSI = numerical_scheme(zeta, PSI_guessed, max_iter, max_err, method);


% Plot results
hold on;

for i = 1:length(streamlines)
    [X_intersec, Y_intersec, elem_num] = points_search_mod(X, Y, ...
        PSI, streamlines(i));
    plot(X_intersec(1:elem_num), Y_intersec(1:elem_num), plot_markers(i));
end

plot(X0, Y0, plot_markers(end));
hold off;
title('Streamlines of a vortex bounded by a rectangular wall');
xlabel('X');
ylabel('Y');
legend([repmat('\Psi = ', length(streamlines), 1), ...
    num2str(streamlines(:))]);