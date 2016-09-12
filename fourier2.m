% Helping function to turn a regular function into a periodic function
% periodic = @(f,p) @(x) f(mod(x-p(1),p(2)-p(1))+p(1));
PeriodicFunction = @(f,p) @(x) f(x - (p(2)-p(1))*floor((x-p(1))/(p(2)-p(1)))); 

% Definition of the function
f = @(x) -1+2*heaviside(x);
% Repeating x-interval
Interval = [-pi pi];
% Calculating period p, and half period L.
p = Interval(2) - Interval(1);
L = p/2;


% Periodic version of function f, repeating the interval P
f_periodic = PeriodicFunction(f, Interval);

% Number of coefficients to calculate. N should be less than half the
% number of samples: 2*N < samples
N = 100;
samples = 200;

% Calculating the coefficients with trapezoid-method.
x = linspace(-L, L, samples);
a = zeros(1,N);
b = zeros(1,N);

a0 = 1/(2*L)*trapz(x, f(x));


for n = 1:N
 a(n) = 1/L*trapz(x,f(x).*cos(pi*n/L*x));
 b(n) = 1/L*trapz(x,f(x).*sin(pi*n/L*x));
end


% Using the coefficients to generate a plot with the repeated function
% and the fourier series in the same coordinate system.
% The plot-interval.
W = 5*Interval;
X = linspace(W(1),W(2),1001);
Y = a0*ones(size(X));

for n = 1:N
 Y = Y + a(n)*cos(pi*n/L*X) + b(n)*sin(pi*n/L*X);
end

figure(1)
plot(X,f_periodic(X),X,Y), grid on, xlabel('x [s]')

