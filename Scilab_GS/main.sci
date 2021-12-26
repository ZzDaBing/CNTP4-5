exec("Method_Jacobi.sci");

A = [2,-1,0,0;-1,2,-1,0;0,-1,2,-1;0,0,-1,2]
b = [-5,0,0,5]'
k_vec = zeros(99);
for n = 2 : 100
    A = diag(-ones(n,1),1) + diag(-ones(n,1),-1) + diag(2*ones(n+1,1));
    b = zeros(n+1,1);
    b(1) = -5;
    b(n+1) = 5;
    [X,k] = method_iter_Jacobi(A,b);
    k_vec(n-1) = k;
end

k_vec
