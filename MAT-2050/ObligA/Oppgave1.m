%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   MAT-1051                          %
%           Obligatorisk innlevering "A"              %
%               Automasjon Y-veien                    %
% Fredrik Eilertsen, Morten Bertheussen, Sondre Aspmo %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VEKT  =  1300;   %Vekt p� bilen [kg]
FARTB =  75/3.6; %Fart p� bilen [m/s]
FARTA =  2.7;    %Akselerasjon  [m/s^2]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OPPGAVE A          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ekinetisk = (VEKT*FARTB^2)/2; %Kinetisk energi [Joule]

fprintf('a) Den kinetiske energien er %g KJoule.\n\n', fix(Ekinetisk/1000))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OPPGAVE B          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TID = (FARTB/FARTA);    % FARTA = FARTB, l�ser med hensyn p� T
A = (1/2)*FARTA*TID^2; % 1/2*m/s^2
B = FARTB*TID;

TOTAL = A+B;

fprintf('b) Strekningen m� v�re %g m for at de skal f� samme fart.\n', TOTAL)

if(A>B) fprintf('   Bil A kj�rer lengst, %g m.\n\n', A) 
end
if(A<B) fprintf('   Bil B kj�rer lengst, %g m.\n\n', B)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OPPGAVE C          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
FARTA = 2.7; %m/s^2

v = 75/3.6; %m/s

v0 = 0; %m/s

for TID = 1:0.01:1000
    B = v*TID;
    A = (1/2)*FARTA*TID^2;
    
    if(A>B)
        
        break;
    end
    
end

fprintf('c) Bil A passerer Bil B etter %g sekunder.\n\n\n\n',TID)