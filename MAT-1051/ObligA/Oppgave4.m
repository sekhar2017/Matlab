%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% OPPGAVE 4         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear a
a(1) = 1;
a(2) = 2;
A = 0.3;
B = 0.7;

for n = 3:10
    a(n) = A*a(n-1) + B*(n-2);
end
b = mat2str(a,3);
fprintf('Oppgave 4a : %s\n',b)


syms C D lambda
k = lambda^2 - C*lambda - D;
k = solve(k);
k5 = matlabFunction(k);
k1 = matlabFunction(k(1));
k2 = matlabFunction(k(2));
clear C D lambda


lambda1 = k1(A,B);
lambda2 = k2(A,B);
fprintf('Oppgave 4b: Den generelle løsningen er: A*%.3f^n+B*%.3f^n',lambda1,lambda2)

total_matrise = [   lambda1^a(1) lambda2^a(1) 1
                    lambda1^a(2) lambda2^a(2) 2   ];
rref(total_matrise)


