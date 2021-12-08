A = [4,12,-16;12,37,-43;-16,-43,98]
exec("src/factoLDLT.sci")
[L,D] = factoLDLT(A)

exec("src/factoLDLT2.sci")
factoLDLT2(A)

B = [15,0,0,22,0,-15,0,0;0,11,3,0,0,0,2,0;0,0,0,-6,0,0,0,0;0,0,0,0,0,0,0,0;91,0,0,0,0,0,25,7;0,0,28,0,0,0,0,-2]

exec("src/csr.sci")
[AA,JA,IA] = toCSR(B)

Mtest = [3,0,0;0,2,5;0,0,0]
[AA,JA,IA] = toCSR(Mtest)
