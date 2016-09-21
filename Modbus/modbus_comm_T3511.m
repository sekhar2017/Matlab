function [Temp,RelHu] = modbus_comm_T3511(IP_address) 
% Function for initializing a serial communication using Modbus TCP protocol in matlab
% Used with Comet web sensors e.g., T3511  
% Returns the Temperature, Relative Humindity level
% usage e.g., [Temp,RelHu] = modbus_comm_T3511('129.242.174.100'); % for
% T3511
 
 
port = 502;   
% Create TCP/IP client or server object
s = tcpip(IP_address,port);   
set(s,'InputBufferSize',3000000); 
 
% Specify Terminator 
s.terminator='CR/LF';
 
% try catch routine is used to catch exceptions e.g., if we are unable to
% establish a connection with the web sensor
try
 
    % Open connection  
    fopen(s);
    
%In case of an exception     
catch MException
    warning('Unable to open the connection, please check the IP address and port no.');
    Temp = [];
    RelHu = [];
    return;
end
 
 
% 0x00 0x00 0x00 0x00 0x00 - transaction ID + protocol ID, where fwrite writes to the TCP
% object
fwrite(s,0,'char'); fwrite(s,0,'char'); fwrite(s,0,'char'); fwrite(s,0,'char');fwrite(s,0,'char'); 
%   0x00 0x06 - length of following bytes
fwrite(s,0,'char'); fwrite(s,6,'char');
%   0x01 - unit ID
fwrite(s,1,'char');
%   0x03 - function code (read holding registers)
fwrite(s,3,'char');
%   0x00 0x30 - register address (from the Comet user guide or manual)
val1 = hex2dec('50');
val2 = hex2dec('00');

fwrite(s,val1,'char'); fwrite(s,val2,'char');
%   0x00 0x02           - number of words (registers) for reading 
fwrite(s,0,'char'); fwrite(s,2,'char');

% try catch routine is used to catch exceptions e.g, if the TCP object is 
% unable to read the data from the port due to disconnection of the device, 
try    
    % read 13 pairs of hexadecimal numbers ( note that this is a standard
    % for T3511 
    out = fread(s,13); 
    % Convert to hex format
    out = dec2hex(out);
    % byte count = 3 X 2 = 6
    byte_count = hex2dec(out(9,:));
    % Temperature ( in Centigrade or Celsius)
    Temp = hex2dec(strcat(out(10,:),out(11,:)))/10;
    % Relative Humidity (in %)
    RelHu = hex2dec(strcat(out(12,:),out(13,:)))/10;
    
   
%In case of an exception     
catch MException 
    
    % Close the TCP object after reading, leads to unstable behavior if not
    % closed
    fclose(s); 
    delete(s);
    clear s;
    Temp = [];
    RelHu = [];
    warning('Unable to read the data from the web sensor');
    
end
 
 
% Close the TCP object after reading, leads to unstable behavior if not
% closed
fclose(s); 
delete(s);
clear s;
 
fprintf(' Temperature ( in Celsius) = %3.1f \n',Temp);
fprintf(' Relative Humidity (in Percentage) = %3.1f \n',RelHu);
 
end
