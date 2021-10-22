% Clean data and set display format
clc;
clear;
format shortEng;


% Parameters
global m n k dy;

x_max = 3;
x_min = -3;
y_max = 2;
y_min = -2;
dx = 0.2;
dy = 0.2;
X = (x_min:dx:x_max)';
Y = (y_min:dy:y_max)';
m = length(X);
n = length(Y);
k = 100;

PSI = zeros(m, n);
streamlines = [-1, -0.5, 0, 0.5, 1];


% Evaluate stream function
for i = 1:m
    for j = 1:n
        PSI(i,j) = F(X(i), Y(j), 'unif+5doub');
    end
end


% Search for all the points at which a vertical grid line intersects with 
% the streamline
hold on;
plot_markers = ['d', 'o', 's', 'v', '^'];

for i = 1:length(streamlines)
    PSI_a = streamlines(i);
    
    % Points on the streamlines
    [X_intersec, Y_intersec, elem_num] = points_search(X, Y, PSI, PSI_a);
    
    % Plot points coordinates
    disp(table(X_intersec(1:elem_num), Y_intersec(1:elem_num), ...
        'VariableNames', {['X, PSI = ', num2str(PSI_a)], ...
        ['Y, PSI = ', num2str(PSI_a)]}));
    plot(X_intersec(1:elem_num), Y_intersec(1:elem_num), ...
        plot_markers(i), 'MarkerSize', 3)    
end

hold off;
title('Flow generated by superposition of elementary flows');
legend([repmat('\Psi = ', 5, 1), num2str(streamlines(:))]);