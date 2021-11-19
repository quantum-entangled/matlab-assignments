% Clean data
clc;
clf;
clear;


% Parameters
m = 51;
j_max = 116;

f = zeros(m, 1);
g = zeros(m, 1);
u = zeros(m, j_max);
X = zeros(m, 1);

a = 340;
h = 0.02;
tau = h / a;


% Define f and g
for i = 1:m
    f(i) = 0;
    g(i) = 0;
    
    if i >= 11 && i <= 31
        f(i) = sin(5 * pi * ((i - 1) * h - 0.2));
    end
end


% Initial conditions
for i = 1:m
    u(i,1) = f(i);
end


% Coundary conditions at the closed left end
for j = 2:j_max
    u(1,j) = 0;
end


% Compute the solution at j = 2
for i = 2:m-1
    u(i,2) = (f(i-1) + f(i+1)) / 2 + tau * g(i);
end

u(m,2) = f(m-1) + tau * g(m);


% Compute the solution at subsequent time steps
for j = 2:j_max-1
    for i = 2:m-1
        u(i,j+1) = u(i-1,j) + u(i+1,j) - u(i,j-1);
    end
    
    u(m,j+1) = 2 * u(m-1,j) - u(m,j-1);
end

for j = 1:j_max
    for i = 1:m
        if abs(u(i,j)) < 1e-10
            u(i,j) = 0;
        end
    end
end


% Compute grid points coordinates
X(1) = 0;

for i = 2:m
    X(i) = X(i-1) + h;
end


% Plot results
iter = 1;
j_ind = 1;
count = 0;

while j_ind <= j_max
    if count == 20
        iter = 1;
        count = 0;
        figure();
    end

    subplot(4, 1, iter);
    plot(X, u(:,j_ind));
    xlim([0, 1]);
    ylim([-1, 1]);
    xticks([-0, 0.5, 1]);
    yticks([-1, 0, 1]);
    grid on;
    title([int2str(j_ind-1), '\tau = ', num2str((j_ind-1)*tau), ...
        ' seconds']);

    iter = iter + 1;
    j_ind = j_ind + 5;
    count = count + 5;
end