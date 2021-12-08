function [res,AA,JA,IA] = prodmatc_vec(A,x)
exec("src/csr.sci")
[AA,JA,IA] = toCSR(A);
n = size(x)(1);
res = zeros(n,1);

for i = 1 : n
    for j = IA(i) : IA(i+1)
        res(i) = res(i) + AA(j) * x(JA(j));
    end
end
endfunction
