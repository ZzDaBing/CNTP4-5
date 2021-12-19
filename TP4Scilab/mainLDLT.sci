A = [2,4,-2,2;4,9,-1,6;-2,-1,14,13;2,6,13,35]
exec("src/factoLDLT.sci")

tic();
for i = 1:100
    [L,D] = factoLDLT(A);
end
tps_exec_LDLT = toc()/100;

tic();
for i = 1:100
    [T,U] =lu(A);
end
tps_exec_LU = toc()/100;

exec("src/factoLDLT2.sci")
tic();
for i = 1:100
    res = factoLDLT2(A);
end
tps_exec_LDLT_condensed = toc()/100;
