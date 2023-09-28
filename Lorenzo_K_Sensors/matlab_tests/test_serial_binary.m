%
% test/demo serial binary data transfer from e.g. Arduino
%

arduino = serialport("/dev/ttyACM0", 115200);

lasts = 0;

while true

    % wait for synch value
    sentinel = read(arduino, 1, "uint8");

    if (lasts == 57 && sentinel == 91)
        break;
    end

    lasts = sentinel;
end


while true

    tic

    for i=1:100
        sentinel = read(arduino,1,"uint8");
        if( not(sentinel == 23))
            % make an error
            error("Unexpected data from arduino");
        end
        
        p1 = read( arduino, 3, "single");
        p2 = read( arduino, 3, "single");
    end
    
    toc
end
