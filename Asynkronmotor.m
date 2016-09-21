clc 
clear 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Asynkronomotor momentkurve %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Motor parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R1 = 0.13;       %Stator resistans 
R2 = 1.5;       %Rotor resistans  
X1 = 0.60;       %Stator reaktans  
X2 = 1.48;       %Rotor reaktans
Xm = 20;       %Magnetiserings reaktans
Vt = 380;     %Nettspenning
Fc = 50;      %Nettfrekvens (50hz standard)
Pp = 4;       %Antall poler
Np = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Kalkulerer synkront turtall.
Vt = Vt/sqrt(3);        %Enfasespenning
ns = 120*Fc/Pp;      %Synkront turtall
omegas = 4*pi*Fc/Pp; %Vinkelhastighet 


%Kalkulerer Thevenin ekvivalent
Zleq = j*Xm*(R1+j*X1)/(R1+ j*(X1+Xm)); 
Rleq = real(Zleq); 
Xleq = imag(Zleq) ; 
Vleq = abs(Vt*j*Xm/(R1+ j*(X1+Xm))); 

%Here is the loop over rotor resistance 


%Loop for sakking

for n = 1:200 
s(n) = n/200; % slip 
snn = 1-s(n);
rpm(n) = ns*snn; %rpm 
I2 = abs(Vleq/(Zleq + j*X2 + R2/s(n))) ; %I2 
Tmech(n) = Np*I2^2*R2/(s(n)*omegas); %Elektromekanisk moment 

end %End sakking

% Plot
plot (rpm, Tmech) 
grid on
hold on
%End resistans loop
xlabel ('RPM') 
ylabel ('MOMENT')