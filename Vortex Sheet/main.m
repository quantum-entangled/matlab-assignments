% Clean data
clc;
clf;
clear;


% Parameters
global iter m G X Y;

m = 40;

X = zeros(m, 1);
Y = zeros(m, 1);
X_new = zeros(m/2, 1);
Y_new = zeros(m/2, 1);
U = zeros(m/2, 1);
V = zeros(m/2, 1);
U_new = zeros(m/2, 1);
V_new = zeros(m/2, 1);
T = 0;

steps_num = 0;
max_steps_num = 500;
dX = 1 / m;
dT = 1 / (25 * m);


% Set vortices coordinates and strengths
X(1) = -1 + dX;

for iter = 2:m
    X(iter) = X(iter-1) + 2 * dX;
end

for iter = 1:m/2
    Y(iter) = 0;
    G(iter) = (1 - (X(iter) + dX)^2)^0.5 - (1 - (X(iter) - dX)^2)^0.5;
end

for iter = m/2+1:m
    Y(iter) = 0;
    G(iter) = -G(m+1-iter);
end


% Iteration process over time
while steps_num <= max_steps_num

    steps_num = steps_num + 1;
    T = T + dT;
    
    
    % Compute the position of each vortex on the left half of the sheet
    for iter = 1:m/2
        [t, y] = ode45(@F, [T-dT, T], [X(iter), U(iter), ...
            Y(iter), V(iter)]);
        X_new(iter) = y(end,1);
        U_new(iter) = y(end,2);
        Y_new(iter) = y(end,3);
        V_new(iter) = y(end,4);
    end

    
    % Reassign
    for iter = 1:m/2
        X(iter) = X_new(iter);
        Y(iter) = Y_new(iter);
        U(iter) = U_new(iter);
        V(iter) = V_new(iter);
    end


    % Vortices on the right half as the mirror images
    for iter = m/2+1:m
        X(iter) = -X(m+1-iter);
        Y(iter) = Y(m+1-iter);
    end
    
    
    % Plot results
    clf;
    plot(X, Y, 'b--', X, Y, 'r.', 'MarkerSize', 6);
    title(['Evolution of an initially flat vortex sheet at T = ', ...
        num2str(T)]);
    xlabel('X');
    ylabel('Y');
    xlim([-1.5 1.5]);
    ylim([-1.2 0.2]);
    pause(0.001);

end    
    

