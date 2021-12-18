TestMatrix = [15,0,0,22,0,-15,0,0;0,11,3,0,0,0,2,0;0,0,0,-6,0,0,0,0;0,0,0,0,0,0,0,0;91,0,0,0,0,0,25,7;0,0,28,0,0,0,0,-2]

exec("src/csr.sci")
exec("src/prodmatc_vec.sci")

//Test Matrix * Vector filled with 1
y = [1,1,1,1,1,1,1,1]'
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(TestMatrix,y);
end
t1 = toc()/100

tic()
for i = 1 : 100
	res2=TestMatrix*y;
end
t2 = toc()/100

//Test Matrix * Vector with 0,0,1 chain
y = [0,0,1,0,0,1,0,0]'
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(TestMatrix,y);
end
t3 = toc()/100

tic()
for i = 1 : 100
	res2=TestMatrix*y;
end
t4 = toc()/100

RandMatrix_100 = sprand(100,100,0.1);
//Random Matrix size 100 * Vector filled with 1
y2 = ones(100,1);
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_100,y2);
end
t5 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_100*y2;
end
t6 = toc()/100

y2 = [0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0]';
//Random Matrix size 100 * Vector with 0,0,1 chain
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_100,y2);
end
t7 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_100*y2;
end
t8 = toc()/100

//Rand Matrix size of 50
RandMatrix_50 = sprand(50,50,0.1);
//Random Matrix * Vector filled with 1
y2 = ones(50,1);
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_50,y2);
end
t9 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_50*y2;
end
t10 = toc()/100

y2 = [0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0]';
//Random Matrix * Vector with 0,0,1 chain
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_50,y2);
end
t11 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_50*y2;
end
t12 = toc()/100


//Rand Matrix size of 200
RandMatrix_200 = sprand(200,200,0.1);
//Random Matrix * Vector filled with 1
y2 = ones(200,1);
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_200,y2);
end
t13 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_200*y2;
end
t14 = toc()/100

y2 = [0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0]';
//Random Matrix * Vector with 0,0,1 chain
tic()
for i = 1 : 100
	[res,AA,JA,IA] = prodmatc_vec(RandMatrix_200,y2);
end
t15 = toc()/100

tic()
for i = 1 : 100
	res2=RandMatrix_200*y2;
end
t16 = toc()/100

//fCSR = [t1,t5,t9,t13];
//fEx = [t2,t6,t10,t14];
//fCSR2 = [t3,t7,t11,t15];
//fEx2 = [t4,t8,t12,t16];
//plot([48,50,100,200],fCSR);
//plot([48,50,100,200],fEx);
//plot([48,50,100,200],fCSR2);
//plot([48,50,100,200],fEx2);
