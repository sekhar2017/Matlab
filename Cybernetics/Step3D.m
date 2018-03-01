i = 6;
t = 0:0.2:12;

% Preamble
y = zeros(1,i);

for n = 1:i
num = 1;
den = [1 2*(n-1)*0.2 1];
[y(1:61,n),x,t] = step(num,den,t);
end

% Print out the transfer function
tf(num,den)

mesh(y)
title('3D plott av togskinne vektorer')
xlabel('n, where n = 1,2,3,4,5,6')
ylabel('Computation Time Points')
zlabel('Outputs')
