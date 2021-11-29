% Clean data
clc;
clf;
clear;


% Parameters
global m j_max a0 ratio coef;

m = 101;
j_max = 56;

a = zeros(m,j_max+1);
u = zeros(m,j_max+1);
X = zeros(m,1);

a0 = 340;
h = 0.02;
gamma = 1.4;
tau = 0.5 * h / a0;
ratio = tau / h;


% Initial conditions
amplitude = a0 / 2;
coef = (gamma - 1) / 2;
propagation = 'right';
shift = 'no';

switch propagation
    case 'right'
        switch shift
            case 'yes'
                for i = 1:m
                    u(i,1) = 0;

                    if i > 51 && i <= 63
                        u(i,1) = amplitude * (i - 51) / 62;
                    elseif i > 63 && i <= 89
                        u(i,1) = amplitude * (76 - i) / 63;
                    elseif i > 89 && i <= m
                        u(i,1) = amplitude * (i - m) / 62;
                    end

                    a(i,1) = a0 + coef * u(i,1);
                end
                
            case 'no'
                for i = 1:m
                    u(i,1) = 0;

                    if i > 1 && i <= 13
                        u(i,1) = amplitude * (i - 1) / 12;
                    elseif i > 13 && i <= 39
                        u(i,1) = amplitude * (26 - i) / 13;
                    elseif i > 39 && i <= 51
                        u(i,1) = amplitude * (i - 51) / 12;
                    end

                    a(i,1) = a0 + coef * u(i,1);
                end
        end
        
    case 'left'
        for i = 1:m
            u(i,1) = 0;

            if i > 1 && i <= 13
                u(i,1) = amplitude * (i - 1) / 12;
            elseif i > 13 && i <= 39
                u(i,1) = amplitude * (26 - i) / 13;
            elseif i > 89 && i <= m
                u(i,1) = amplitude * (i - 51) / 12;
            end

            a(i,1) = a0 - coef * u(i,1);
        end
end


% Boundary conditions
for j = 1:j_max
    u(1,j+1) = 0;
    a(m,j+1) = a0;
end


% Compute the solution
u = numerical_scheme(u, a);


% Compute grid points coordinates
X(1) = 0;

for i = 2:m
    X(i) = X(i-1) + h;
end


% Plot results
iter = 1;
j_ind = 1;
count = 1;

while j_ind <= j_max
    if count == 7
        iter = 1;
        count = 1;
        figure();
    end

    subplot(6, 1, iter);
    plot(X, u(:,j_ind));
    xlim([0, 2]);
    ylim([-150, 150]);
    xticks([0, 0.5, 1, 1.5, 2]);
    yticks([-150, 0, 150]);
    grid on;
    title([int2str(j_ind-1), '\tau = ', num2str((j_ind-1)*tau), ...
        ' seconds']);

    iter = iter + 1;
    j_ind = j_ind + 5;
    count = count + 1;
end