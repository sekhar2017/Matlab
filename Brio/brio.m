 % brio.m
clear

% Leser inn tverrsnittet av togskinne.
[objekt2D, flate] = brioskinne_tverrsnitt();

% Innstillinger
svinglengde            =  45;
doseringsvinkel_start  =   0;  
doseringsvinkel_slutt  = -25;
svingradius            = 182;

antall_steg             =  5;

% Hjelpevariabler
d_sving    = svinglengde/antall_steg;
d_dosering = (doseringsvinkel_slutt-doseringsvinkel_start)/antall_steg;

[~,antall_punkt] = size(objekt2D);

% Legger objektet inn i 3-dimensjonalt rom i xz-planet
objekt3D = [1 0; 0 0; 0 1]*objekt2D;

% Rotasjon om y-aksen
Ry = @(v) [  cosd(v)  0  sind(v) 
                0     1     0 
            -sind(v)  0  cosd(v)  ];

% Rotasjon om z-aksen
Rz = @(v) [ cosd(v) -sind(v)  0 
            sind(v)  cosd(v)  0
               0        0     1 ];

% Translasjon for å flytte togskinnen ut til korrekt svingradius
translasjon = [svingradius; 0; 0]*ones(1,antall_punkt);

% Plasserer første tverrsnitt av togskinna
punktliste = Ry(doseringsvinkel_start) * objekt3D + translasjon;
flateliste = flate;

% Genererer 3D-objektet snittflate for snittflate
for n = 1:antall_steg;
    
    % Regner ut doseringsvinkel og svingvinkel for steg nr. n
    doseringsvinkel = doseringsvinkel_start + d_dosering*n;
    svingvinkel = d_sving*n;
    
    % Genererer tverrsnitt nr. n
    rotert_objekt = Rz(svingvinkel) * (Ry(doseringsvinkel) * objekt3D + translasjon);
    
    % Legger til dei nye punkta i punktlista
    punktliste = [ punktliste, rotert_objekt ];
    
    % Genererer triangulering av sideflatene 
    for i = 1:antall_punkt
        a = i + (n-1) * antall_punkt;
        b = mod(i, antall_punkt) + 1 + (n-1) * antall_punkt;
        c = i + n * antall_punkt;
        d = mod(i, antall_punkt) + 1 + n * antall_punkt;
        flateliste = [ flateliste; b a c; c d b ];
    end
end

% Legg til endeflata
flateliste = [flateliste; flate(:,[1 3 2])+antall_steg*antall_punkt];

% Transpoerer punktlista for at formatet skal passe med 'stlwrite'
punktliste_T = transpose(punktliste); 

stlwrite('togskinne.stl',flateliste,punktliste_T,'mode','ascii')

% Viser 3D-modellen med eksternt program

% Dersom 'openscad' er installert:
%system('openscad vis_togskinne.scad &')

% Dersom Windows 10 med '3D Builder' installert (Standard app)
%winopen('togskinne,stl')
