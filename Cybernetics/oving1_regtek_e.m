% Oppgave 1e)
R2 =  10e3;  % k[ohm]
R1 = 100e3;  % k[ohm]
C1 = 30e-6;  % micro[F]

s = tf('s');
t = 0:pi/100:2*pi;

% Sinuser
v1 = 5 * sin(2*pi*0.2*t);
v2 = 5 * sin(2*pi*1.0*t);

% Krets A)             
A_h = 1/(R1*C1*s + 1);  

% Krets B)
B_h = (R1*C1*s)/(R1*C1*s + 1);

% Krets C)
C_h = R2*(1+s*C1*R1)/(R1+R2*(1+s*C1*R1));

% Plott er flott
lsim(A_h, B_h, C_h, v1, t)

