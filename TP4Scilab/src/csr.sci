function [AA,JA,IA] = toCSR(A)
n = size(A)(1);
m =  size(A)(2);
AA = zeros(n*m);
JA = zeros(n*m);
IA = zeros((n*m)+1);
cmp = 1;
for i = 1 : n
    IA(i) = cmp;
    for j = 1 : m
        if A(i,j) ~= 0 then
            AA(cmp) = A(i,j);
            JA(cmp) = j;
            cmp = cmp+1;
        end
    end
end
IA(i+1) = cmp;
endfunction
