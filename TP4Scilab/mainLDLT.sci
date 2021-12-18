A = [4,12,-16;12,37,-43;-16,-43,98]
exec("src/factoLDLT.sci")
[L,D] = factoLDLT(A)

exec("src/factoLDLT2.sci")
factoLDLT2(A)