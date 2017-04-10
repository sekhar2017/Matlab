% Global

t = 0.2;
T1 = 1;
T2 = 0.5;

Hp = tf(t, [T1*T2 (T1+T2) 1 0])

%% Oppgave 1a)
rltool(Hp)