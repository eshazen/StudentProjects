%% Clear everything 

clear; 
clc;

%% File Name 

sensor_designation = input("Enter sensor designation: ", "s"); 
test_name = input("Enter test name: ", "s"); 
trial = input("Enter trial #: ", "s"); 

filename = append('Sensor_', sensor_designation, '_', test_name, '_Trial_', trial, '.mat');

%% Set up DAQ Communication
dq1 = daq("ni"); 

SG0_Output = addinput(dq1,"Dev1", "ai0","Voltage");
SG0_Ref = addinput(dq1,"Dev1", "ai8","Voltage");
SG1_Output = addinput(dq1,"Dev1", "ai1","Voltage");
SG1_Ref = addinput(dq1,"Dev1", "ai9","Voltage");
SG2_Output = addinput(dq1,"Dev1", "ai2","Voltage");
SG2_Ref = addinput(dq1,"Dev1", "ai10","Voltage");
SG3_Output = addinput(dq1,"Dev1", "ai3","Voltage");
SG3_Ref = addinput(dq1,"Dev1", "ai11","Voltage");
SG4_Output = addinput(dq1,"Dev1", "ai4","Voltage");
SG4_Ref = addinput(dq1,"Dev1", "ai12","Voltage");
SG5_Output = addinput(dq1,"Dev1", "ai5","Voltage");
SG5_Ref = addinput(dq1,"Dev1", "ai13","Voltage");

%% Set up Arduino Communication

arduino = serialport("COM7",9600);

fopen(arduino)

%% Collect Data 

% Create empty "master" matrices to store data from sensors and save to file

force_sensor_matrix = [];
proximal_magnet_sensor_matrix = [];
distal_magnet_sensor_matrix = [];

% Keeps track of how many iterations the overall while loop has gone through
cycle_count = 0 ; 

% Creates real time plots
prox_magnet_Z_graph = animatedline;
prox_magnet_Z_graph.Color = 'red'; 

dist_magnet_Z_graph = animatedline;
dist_magnet_Z_graph.Color = 'blue'; 

force_Z_graph = animatedline; 
force_Z_graph.Color = 'green';

while true

    tic

    % Records force sensor and magnetometer readings 
    force_sensor_reading = read(dq1, "OutputFormat", "Matrix"); 
    magnet_reading_str = fscanf(arduino,'%s');  

    str_vector = []; 
    comma_count = 0; 
    
    % The following for loop is necessary because the Arduino outputs a string
    for i = 1:length(magnet_reading_str)
    
        if magnet_reading_str(i) ~= ','
            str_vector = [str_vector magnet_reading_str(i)]; 
    
        elseif magnet_reading_str(i) == ',' 
            comma_count = comma_count + 1; 
            switch comma_count
                case 1 
                    prox_X = str2double(str_vector); 
                case 2 
                    prox_Y = str2double(str_vector);
                case 3 
                    prox_Z = str2double(str_vector); 
                case 4
                    dist_X = str2double(str_vector); 
                case 5 
                    dist_Y = str2double(str_vector); 
                case 6 
                    dist_Z = str2double(str_vector); 
            end 
    
            str_vector = []; 
    
        end 

    end 

    % Store values in matrices and save

    force_sensor_matrix = [force_sensor_matrix; force_sensor_reading];
    proximal_magnet_sensor_matrix = [proximal_magnet_sensor_matrix; prox_X prox_Y prox_Z];
    distal_magnet_sensor_matrix = [distal_magnet_sensor_matrix; dist_X dist_Y dist_Z];

    save(filename,'proximal_magnet_sensor_matrix','distal_magnet_sensor_matrix','force_sensor_matrix');

    % Update real-time plot

    cycle_count = cycle_count + 1; 

    addpoints(prox_magnet_Z_graph, cycle_count, prox_Z);
    addpoints(dist_magnet_Z_graph, cycle_count, dist_Z);
    addpoints(force_Z_graph, cycle_count, force_sensor_reading(5)*1000);
    drawnow; 

    toc

end 
