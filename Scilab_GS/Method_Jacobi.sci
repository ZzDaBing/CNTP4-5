function [x,k] = method_iter_Jacobi(A,b)
    n = size(A)(1);
    x = zeros(n,1);
    r = 1;
    k=1;
    while norm(r) > 1.0e-8
        r = b-A*x;
        x = x + (r/2);
        k = k+1;
    end
endfunction
