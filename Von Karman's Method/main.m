% Clean data and set display format
clc;
clear;
format shortEng;


% Parameters
a = 1;
U = 1;
approx_type = 'segments'; % 'segments', 'discrete'


% Position of the source segments end points or discrete point sources and
% coordinates of the surface points
[r, s, z, z_dash] = coordinates(a);


% Source strengths
[Q, d, d_delta, right_part] = source_strengths(r, s, z, z_dash, ...
    approx_type);


% Exact and computed velocity and pressure coefficient
[V, V_exac, V_err, c_p, c_p_exac, c_p_err] = values(r, z, z_dash, Q, ...
    d, U, a, approx_type);


% Print results
data_table = table(r, z, V, V_exac, V_err, c_p, c_p_exac, c_p_err);
disp(data_table);