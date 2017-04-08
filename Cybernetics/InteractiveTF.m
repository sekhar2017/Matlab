%% Interactive step response, decrease/increas of damping ratio.

w_0 = 2; % Natural Frequency (Omega_n)
z = 0.5; % Damping Ratio (zeta)

% Standard second order oscillatory differential equation
sys = tf(w_0^2,[1,2*z*w_0,w_0^2]);

f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
h = stepplot(ax,sys);
setoptions(h,'XLim',[0,10],'YLim',[0,2]);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',z, 'min',0, 'max',1);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','Damping Ratio','BackgroundColor',bgcolor);

% Set the callback function for the UI update          
b.Callback = @(es,ed) updateSystem(h,tf(w_0^2,[1,2*(es.Value)*w_0,w_0^2])); 