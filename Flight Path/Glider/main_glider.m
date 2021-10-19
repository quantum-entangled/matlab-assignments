% Clean data
clc;
clear;


% Parameters
global A B h


% Assign the required values
A = 1.5;
B = 0.06;
h = 0.05;
W0 = 1;
theta0 = zeros(2, 1);

n = 250;
X1 = zeros(n, 1);
Y1 = zeros(n, 1);
X2 = zeros(n, 1);
Y2 = zeros(n, 1);
    

% Loop for different flight angles
for i = 1:2
    
    % Angle cases
    if i == 1
        theta0(i) = -pi / 2;
    elseif i == 2 
        theta0(i) = pi;
    end

    
    % Initial conditions
    U0 = W0 * cos(theta0(i));
    V0 = W0 * sin(theta0(i));

    T = 0;
    X = 0;
    Y = 0;
    U = U0;
    V = V0;
       
    
    % Main loop
    for j = 1:n
        if i == 1
            X1(j) = X;
            Y1(j) = Y;
        elseif i == 2
            X2(j) = X;
            Y2(j) = Y;
        end

        [t, y] = my_ode45_glider(@F_glider, [T, T+h], [X, Y, U, V]);
        
        T = t(end);
        X = y(end, 1);
        Y = y(end, 2);
        U = y(end, 3);
        V = y(end, 4);
    end

end


% Plot results
title('Flight path of a glider');
xlabel('X');
ylabel('Y');
xlim([min(min(X1, X2))-0.5, max(max(X1, X2))+0.5]);
ylim([min(min(Y1, Y2))-0.05, max(max(Y1, Y2))+0.05]);
hold on;

for i = 2:n
    plot([X1(i-1), X1(i)], [Y1(i-1), Y1(i)], '--b');
    pause(0.01);
    plot([X2(i-1), X2(i)], [Y2(i-1), Y2(i)], '-g');
    pause(0.01);
end

legend(['\theta_0 = ', num2str(theta0(1)*180/pi), '°'], ...
    ['\theta_0 = ', num2str(theta0(2)*180/pi), '°']);