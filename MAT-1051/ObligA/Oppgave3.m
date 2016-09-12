%% Areal ved hjelp av simpsons metode

%%%%%%%%%%%%%%%%%%%%%%%%%
%  f.m funksjonsfil:    %
%   function y = f( x ) %
%     y = 1/(1+x^2);    %
%   end                 %
%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear
a    = 0; 
b    = 3;
areal= 0;

k  = 5;
dx = (b-a)/(2*k) %Skivebredden dx (nøyaktighet)

for m=1:k
 %Beregner funksjonsverdien
 f1 = f(a+(2*m-2)*dx); 
  f2 = f(a+(2*m-1)*dx);
   f3 = f(a+2*m*dx);
 sum = (f1+(4*(f2))+f3 )*dx/3;
 areal  = areal + sum;    
end
fprintf('Arealet er: %.10f \n\n', areal);


% Beregner analytisk verdi
syms fx
fx = 1/(1+fx^2);
fx = matlabFunction(fx);
analytisk_areal = integral(fx,0,3)


feilprosent = (analytisk_areal-areal)/analytisk_areal;
feilprosent = feilprosent*100;

fprintf('Feilprosent: %.3f%% \n\n', feilprosent)
