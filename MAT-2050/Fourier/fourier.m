clear 
syms x real
syms n integer
Pi = sym('pi')
PeriodicFunction = @(f,p) @(x) f(x - (p(2)-p(1))*floor((x-p(1))/(p(2)-p(1)))); 

f(x) = abs(x)
fplot(PeriodicFunction(f,[-pi,pi]),[-3*pi,3*pi]), hold on

a0 = 1/(2*Pi)*int(f(x), -Pi, Pi)
a(n) = simplify( 1/Pi * int(f(x)*cos(n*x),-Pi,Pi) )
b(n) = simplify( 1/Pi * int(f(x)*sin(n*x),-Pi,Pi) )

X = linspace(-3*pi,3*pi,500);
Y = zeros(size(X)) + double(a0);

for m = 1:3
    Y = Y + double(a(m))*cos(m*X) + double(b(m))*sin(m*X);
end
plot(X,Y), hold off
g(x) = a0 + symsum(a(n)*cos(n*x)+b(n)*sin(n*x),n,1,5)