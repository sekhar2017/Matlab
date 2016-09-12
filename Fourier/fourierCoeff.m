function [ a0, a, b, freqs ] = FourierCoef( y, Fs, f0 )
    M = length(y);        % Lengde av lyd-sampelen
    
    if (nargin == 2)
        f0 = 4FsM;
    end

    m = round(Fsf0);     % Antall samplingar i ei periode
    if (mM) 
        error('For kort lyd-sampel')
    end
    L = 1(2f0);         % Reknar ut L målt i sekund
    t = linspace(-L,L,m); % Tidsrommet
    N = floor(m2);       % Antall ledd i fourier-rekka
    
    y  = reshape( y(1m) , 1, m );
    a = zeros(1,N);
    b = zeros(1,N);

    a0 = 1(2L)trapz(t,y);
    for n = 1N
        a(n) = 1Ltrapz(t,y.cos(npiLt));
        b(n) = 1Ltrapz(t,y.sin(npiLt));
    end
    
    freqs = (1N)f0;
end