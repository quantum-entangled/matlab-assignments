function Uold = left_angle(x, V, Courant, dh, Uinit, xStartStep, Lstep, xLeft, xRight, TextSize, t_fin)
    
    i = 1; % итерационный индекс элементов
    t(i) = 0; % статистика  времени (от итераций)
    dt = Courant * dh / abs(V); % шаг по времени
    plot_interval = round(1 / dt); % интервал вывода графиков
    plot_time = 1; % итерационный индекс графиков
    
    % Первое приближение:
    Uold = (x >= xStartStep & x <= (xStartStep + Lstep)) * Uinit;
    Unew = Uold;

    while t(i) <= t_fin
        
        % Время итерации:
        t(i+1) = t(i) + dt; 
        
        % Точное решение:
        Uexac = exact(x, t(i+1), V, Uinit, xStartStep, Lstep, xLeft, xRight);
        
        % Схема "левый уголок":
        Unew(2:end-1) = Uold(2:end-1) - V * dt / dh * (Uold(2:end-1) - Uold(1:end-2));
        
        % Периодические граничные условия:
        Unew(1) = Unew(1) - V * dt / dh * (Uold(1) - Uold(end));
        Unew(end) = Unew(end) - V * dt / dh * (Uold(end) - Uold(end-1));
    
        % Конец тела цикла:
        Uold = Unew;

        % График изменения решения:
        if i == plot_time
            
            plot_time = plot_time + plot_interval;
            figure(1), clf;
            plot(x, Uold, '-r*', x, Uexac, '-k', 'LineWidth', 3, 'MarkerSize', 5);
            grid on;
            title(['Left Angle, ', 'Time = ', num2str(t(i+1)), ', dt = ', num2str(dt)], 'FontSize', TextSize);
            xlabel('X');
            ylabel('U');
            xlim([xLeft, xRight]);
            ylim([0, Uinit*1.5]);
            pause(0.05);
            
        end

        i = i + 1;

    end
    
end