function M = qSolveFun(q, k, M0) % решение нелинейного уравнения для расходной функции методом Ньютона

    M = M0 - f(q, k, M0) / df(k, M0);
    
    while abs(M - M0) > 1e-6
        
        M0 = M;
        M = M0 - f(q, k, M0) / df(k, M0);
        
    end

end