%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   Fredrik Eilertsen  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Gyroscope      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

% Checks if mobile is facing up or down


% Application properties
port       = 31415;       % Standard port(31415)
password   = 'password';  % Password for iOS app
numOfLoops = 50;         % Number of datapoints 


% Sensor properties:
accelerationSensor = 0;    %0 = off, 1 = on;
orientationSensor  = 1;
angularVelocity    = 0;
magneticSensor     = 0;
positionSensor     = 0;
sampleRate         = 'Low';  %high, medium, low



%%%%% Script starting here. %%%%%%%%%%%%%%%%%%%%%%%%%
connector on
m = mobiledev;


m.AccelerationSensorEnabled     = accelerationSensor;
m.AngularVelocitySensorEnabled	= angularVelocity;
m.MagneticSensorEnabled         = magneticSensor;
m.OrientationSensorEnabled      = orientationSensor;
m.PositionSensorEnabled         = positionSensor;
m.SampleRate                    = sampleRate;


% Start logging
m.Logging = 1;


% Run a loop, checking for orientation
for k = 1:numOfLoops
    
    % Pause to aquire data
    pause(0.2)
    
    % Read orientationSensor log into o, t.
    [o, t] = orientlog(m);
    
    % Discard orientationSensor log
    discardlogs(m)
    
    
    if ~isempty(o)         %~ not operator 
        
        % Compute mean value of the third column, roll/z-axis.
        z = mean(o(:,3));  % in degrees 
        
        % Check Z-axis to determine which way phone is facing
        if (z > 70 && z < 98)
            disp('Right Side:')
            disp(z)
        elseif (z < -70 && z > - 98)
            disp('Left Side:')
            disp(z)
        elseif z > -100 && z < 100
            disp('Facing Up:')
            disp(z)
        else
            disp('Facing Down:')
            disp(z)
          
        end   
     end
 end


% Clean up
clear m

