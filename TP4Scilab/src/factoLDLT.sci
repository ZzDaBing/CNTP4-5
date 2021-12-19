function [L,d] = factoLDLT(A)
n = size(A)(1);
L = tril(A);
d = diag(A);
v = zeros(n,1);

v(1) = d(1);
L(2:n,1) = A(2:n,1) / d(1);
for j = 2 : n
    for i = 1 : j-1
        v(i) = L(j,i) * d(i);
    end
    d(j) = A(j,j) - L(j,1:j-1) * v(1:j-1);
    L(j+1:n,j) = (A(j+1:n,j) - L(j+1:n,1:j-1) * v(1:j-1)) / d(j);
end
for i = 1 : n
    L(i,i) = 1;
end
endfunction
