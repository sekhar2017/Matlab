%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% OPPGAVE 2         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


x = -2:0.001:2;
g = atan(x).*exp(-x.^2)-(x/2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(x,g), hold on

for n = 1:length(g)
    if(g(n)<0)
        break
    end
end

for m = n+1:length(g)
    if(g(m)>0)
        break
    end
end

for o = m+1:length(g)
    if(g(o)<0)
        break
    end
end

plot([x(n) x(m) x(o)], [0 0 0], 'ok')

fprintf('-----------------OPPGAVE 2-----------------\n\n')
fprintf('Nullpunkter: (0,%g), (0, %g), (0, %g)\n',x(n),x(m),x(o))


x = -2:0.1:2;
g = atan(x).*exp(-x.^2)-(x/2);

g_max = g(1);
x_max = x(1);
g_min = g(1);
x_min = x(1);

for i = 1:length(g)
    if (g(i)>g_max)
        g_max = g(i);
        x_max = x(i);
    elseif (g(i)<g_min)
        g_min = g(i);
        x_min = x(i);
        
    end
end

plot([x_max x_min], [g_max g_min], 'og')
fprintf('Globale ekstremalpunkt: (%g, %g), (%g,%g)\n',x_max, g_max, x_min, g_min)


x = -0.7:0.1:0.7;
g = atan(x).*exp(-x.^2)-(x/2);

g_max = g(1);
x_max = x(1);
g_min = g(1);
x_min = x(1);

for i = 1:length(g)
    if (g(i)>g_max)
        g_max = g(i);
        x_max = x(i);
    elseif (g(i)<g_min)
        g_min = g(i);
        x_min = x(i);
        
    end
end

plot([x_max x_min], [g_max g_min], 'or')
fprintf('Lokale ekstremalpunkt: (%g, %g), (%g, %g)\n',x_max, g_max, x_min, g_min)
legend('g(x)','Nullpunkt' ,'Global Ekstremal', 'Lokal Etremal')
line(xlim, [0 0],'color','k')%x-akse
line([0 0], ylim,'color','k')%y-akse
ylabel('y') % label for x axis
xlabel('x') % label for y axis
hold off