function m_p = m_p(m_p0)
% M_P Calculation of the instantaneous mass of the propellant at time t

    % Assign the required values
    syms t;
    c = m_p0 / 4;
    
    
    % Piecewise integration
    f(t) = piecewise((0<=t)<=1, c*t, (1<t)<3, c, (3<=t)<=5, -c*t+5*c);
    m_p = m_p0 - double(int(f, t, [0 5]));

end

