% Функция правых частей уравнения движения ЛА в поле Земли:

function F = right_part(T, Y, rho0, g0, rz, sigma, K) 
    V = Y(1); 
    theta = Y(2);
    h = Y(4); % переменные из переданного вектора
    t = T;

    rho = rho0 * exp(-h / 7800);
    g = g0 * (rz./(rz + h)).^2; % используемые параметры

    F = [-sigma * rho * V^2 / 2 - g * sin(theta);
         (1 / V) * (sigma * K * rho * V^2 / 2 - g * cos(theta) + V^2 / (rz + h) * cos(theta));
         V * cos(theta); 
         V * sin(theta);]; % правые части

end

