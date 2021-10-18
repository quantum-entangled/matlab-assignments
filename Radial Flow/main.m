% Clean data and set display format
clc;
clear;
format shortEng;


% Set the domain limits and interior points properties
R_min = 1;
R_max = 4;
intervals = 30;
n = intervals - 1;
h = (R_max - R_min) / intervals;


% Coefficients of standard form
A = @(x) 1 / x;
B = @(x) 0 * x;
D = @(x) 9 * x;


% Compute discrete parameters and exact PHI and U values
R = zeros(n, 1);
C = zeros(n, 4);
PHI_exac = zeros(n, 1);
U_exac = zeros(n, 1);

for i = 1:n
    R(i) = R_min + i * h;
    C(i,1) = 1 - h * A(R(i)) / 2;
    C(i,2) = -2 + h^2 * B(R(i));
    C(i,3) = 1 + h * A(R(i)) / 2;
    C(i,4) = h^2 * D(R(i));
    PHI_exac(i) = R(i)^3 - 24 * log(R(i));
    U_exac(i) = 3 * R(i)^2 - 24 / R(i); 
end


% Boundary conditions, coefficients modification
PHI_low_bound = R_min;
PHI_up_bound = 64 - 24 * log(R_max);
C(1,4) = C(1,4) - C(1,1) * PHI_low_bound;
C(1,1) = 0;
C(n,4) = C(n,4) - C(n,3) * PHI_up_bound;
C(n,3) = 0;


% Compute PHI and U at the interior points
[C, PHI] = preceding_coefs(C, n);

U = zeros(n, 1);
U(1) = (PHI(2) - PHI_low_bound) / (2 * h);

for j=2:n-1
    U(j) = (PHI(j+1) - PHI(j-1)) / (2 * h);
end

U(n) = (PHI_up_bound - PHI(n-1)) / (2 * h);


% Display results with comparision to the exact solution
PHI_err = round(abs(PHI - PHI_exac) / 100, 4);
U_err = round(abs(U - U_exac) / 100, 4);

data_table = table(R, PHI, PHI_exac, PHI_err, U, U_exac, U_err);
disp(data_table);


% Plot results
figure(1);
plot(R, U, '-b');
title('Radial flow caused by distributed sources and sinks');
xlabel('Radius, R');
ylabel('Dimensionless velocity, U');

figure(2);
plot(R, PHI, '-r');
title('Radial flow caused by distributed sources and sinks');
xlabel('Radius, R');
ylabel ('Dimensionless velocity potential, \Phi');