% Create a function to initialize and display the GUI
function wheelchair_hmi()

    % Create a figure
    fig = figure('Name', 'H.M.I', 'Position', [50, 50, 360, 600], 'NumberTitle', 'off', 'MenuBar', 'none');

    batteryback = uicontrol('Style', 'text', 'String', '', 'Position', [20, 552, 55, 15], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'BackgroundColor', 'black', 'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'blue');
    batterybacki = uicontrol('Style', 'text', 'String', '', 'Position', [20, 550, 50, 20], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'BackgroundColor', 'black', 'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'blue');
    
    % power system generation
    powersection  = uicontrol('Style', 'text', 'String', 'Battery Current Capacity: Unknown', 'Position', [100, 550, 200, 30], 'ForegroundColor', 'black');
    powersectioni = uicontrol('Style', 'text', 'String', 'Battery Initial Capacity: 120 W', 'Position', [100, 530, 200, 30], 'ForegroundColor', 'black');
    DistanceSection = uicontrol('Style', 'text', 'String', 'Total Distance covered: 0.00 m', 'Position', [100, 510, 200, 30], 'ForegroundColor', 'black');
    % declare a whole new set of colors;
    darkButtonColor = [0.2, 0.2, 0.2]; % Slightly lighter than the background
    redButtonColor = [1, 0, 0]; % red border color

    image = uiimage('Position', [190, 110, 200, 200]);
    image.ImageSource = 'MATLAB_codes/assets/upviewant.png';




    % Convert the image to double im_sized = imresize(upIcon,[20,20]);precision and scale it to [0, 1]
    
    
    % Create buttons for controlling the wheelchair
    btnForward = uicontrol('Style', 'pushbutton', 'String', 'F', 'Position', [150, 210, 50, 50], 'FontWeight','bold', 'Callback', @forwardCallback);
    btnBackward = uicontrol('Style', 'pushbutton', 'String', 'B', 'Position', [150, 90, 50, 50], 'FontWeight','bold', 'Callback', @backwardCallback);
    btnLeft = uicontrol('Style', 'pushbutton', 'String', 'L', 'Position', [80, 150, 50, 50], 'FontWeight','bold', 'Callback', @LeftCallback);
    btnRight = uicontrol('Style', 'pushbutton', 'String', 'R', 'Position', [220, 150, 50, 50], 'FontWeight','bold', 'Callback', @RightCallback);
    btnStop = uicontrol('Style', 'pushbutton', 'String', 'X', 'Position', [150, 150, 50, 50], 'FontWeight','bold', 'Callback', @stopCallback);
    

    % set(btnForward,'CData',im_sized);
    
    
    
    
    % Calculate the screen width
    screenWidth = get(0, 'ScreenSize');
    labelWidth = 350;  % Set the desired width for the label
    labelHeight = 30;  % Set the desired height for the label

    % Calculate the x-coordinate for centering the label horizontally
    xPosition = (screenWidth(3) - labelWidth) / 2;

    % Create a text label for the other warning message...
    
    messageLabeli = uicontrol('Style', 'text', 'String', 'Device Is Not Moving ...', 'Position', [25, 440, labelWidth, labelHeight], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'blue');


    % Create a text label to display battery status
    % batteryLabel = uicontrol('Style', 'text', 'String', 'Battery Status: Unknown', 'Position', [20, 10, 150, 30]);
    
    % Function for batterylabel ...
    DeviceCapacity = wheelchair_powerSystem();
    isMoving = 0;
    distanceinsec = 0;
    disp(DeviceCapacity);
    DevicePercent = CalcBatteryPercent(DeviceCapacity);
    disp(DevicePercent);
    CheckLowPower = detectLowPower(DevicePercent);
    disp(CheckLowPower);
    % Define a function to update the battery status
    function updateBatteryStatus(messageLabel, batteryLabel, DevicePercent, CheckLowPower)
    if strcmp(CheckLowPower, 'okay')
        % Update the battery status display in the uicontrol
        set(batteryLabel, 'String', DevicePercent, 'ForegroundColor', 'black', 'BackgroundColor', 'green');
    else
        set(messageLabel, 'String', 'Device Is Low And May Not Function properly', 'BackgroundColor', 'red');
        set(batteryLabel, 'String', DevicePercent, 'ForegroundColor', 'black');
    end
end
    % Create a text label for displaying messages at the bottom center of the screen
    messageLabel = uicontrol('Style', 'text', 'String', '', 'Position', [25, 480, labelWidth, labelHeight], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'FontSize', 10, 'FontWeight', 'bold');
    
    
% Create the uicontrol for displaying battery status
batteryLabel = uicontrol('Style', 'text', 'String', '?', 'Position', [22, 552, 45, 16], 'FontWeight','bold');

% Call the function to update the battery status
updateBatteryStatus(messageLabel, batteryLabel, DevicePercent, CheckLowPower);

% Define the time interval in seconds (e.g., 5 seconds)
timeInterval = 1;
secondsTime = 1;
direction = 'none';
assignin("caller",'isMoving', false);
notMoving = true;


% Create an infinite loop
while true
    % Call your function here
    resultx = wheelchair_actuation(DevicePercent, isMoving, distanceinsec);  % Replace 'yourFunction()' with your actual function call
    disp(isMoving);
    if isMoving
        newDistance = TotalDistanceInSecs(distanceinsec);
        distanceinsec = newDistance;
        result = PowerUsage(DeviceCapacity);
        powerpercent = CalcBatteryPercent(result);
        DeviceCapacity = result;
        disp(result);
        powerAlert = detectLowPower(powerpercent);
        updateBatteryStatus(messageLabel, batteryLabel, powerpercent, powerAlert);
        set(powersection, 'String', sprintf('Battery Current Capacity: %d%s', DeviceCapacity,'W'));
        set(DistanceSection, 'String', sprintf('Total Distance covered: %d%s', distanceinsec,' m'));

    else
        result = PowerWastage(DeviceCapacity);
        powerpercent = CalcBatteryPercent(result);
        DeviceCapacity = result;
        powerAlert = detectLowPower(powerpercent);
        updateBatteryStatus(messageLabel, batteryLabel, powerpercent, powerAlert);
        set(powersection, 'String', sprintf('Battery Current Capacity: %d%s', DeviceCapacity,'W'));
        set(DistanceSection, 'String', sprintf('Total Distance covered: %d%s', distanceinsec,' m'));

        image.ImageSource = 'MATLAB_codes/assets/upviewant.png';

    end
    if strcmp(resultx, 'low power')
        direction = 'none';
        isMoving = 0;
        set(messageLabeli, 'String', 'Low Battery, Please Charge');
        image.ImageSource = 'MATLAB_codes/assets/upviewant.png';
    else
        if strcmp(resultx, 'detected')
            direction = 'none';
            isMoving = 0;
            set(messageLabeli, 'String', 'Obstacle Detected, try again.');
        else
            disp('hold');
        end
        
    end
    % Display the result or perform other tasks
    
    % Pause for the specified time interval
    pause(timeInterval);
end
    
    % Function to handle the "Forward" button click
    function forwardCallback(~, ~)
        isMoving = 1;

        movement = moveForward(DeviceCapacity, direction);
        if strcmp(movement, 'low power')
            direction = 'none';
            set(messageLabeli, 'String', 'Low Battery, Please Charge');
            image.ImageSource = 'MATLAB_codes/assets/upviewant.png';
        else
            isMoving = 1;
        if strcmp(movement, 'Already Going Forward')
            direction = movement;
            set(messageLabeli, 'String', sprintf('Similar Action...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animefwd.gif';

        else
            direction = movement;
            set(messageLabeli, 'String', sprintf('Device Is Moving...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animefwd.gif';

        end
        end
    end

    % Function to handle the "Backward" button click
    function backwardCallback(~, ~)
        movement = moveBackward(DeviceCapacity, direction);
        if strcmp(movement, 'low power')
            direction = 'none';
            set(messageLabeli, 'String', 'Low Battery, Please Charge');
            image.ImageSource = 'MATLAB_codes/assets/upviewant.png';

        else
            isMoving = true;

        if strcmp(movement, 'Already Going Backward')
            direction = movement;
            set(messageLabeli, 'String', sprintf('Similar Action...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animebwd.gif';
        else
            direction = movement;
            set(messageLabeli, 'String', sprintf('Device Is Moving...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animebwd.gif';

        end
        end
    end

    % Function to handle the "Stop" button click
    function stopCallback(~, ~)
        
        if strcmp(direction, 'none')
            isMoving = 0;
        else
            isMoving = 1;
        end
        movement = Stop(isMoving);
        if strcmp(movement, 'unnecess')
            direction = 'none';
            isMoving = 0;
            set(messageLabeli, 'String', 'Device Is Not Moving ...');
        else
            direction = 'none';
            isMoving = 0;
            set(messageLabeli, 'String', 'Device Has Stopped');
        end
    end
    function LeftCallback(~, ~)
        movement = moveLeft(DeviceCapacity, direction);
        if strcmp(movement, 'low power')
            direction = 'none';
            set(messageLabeli, 'String', 'Low Battery, Please Charge');
            image.ImageSource = 'MATLAB_codes/assets/upviewant.png';

        else
            isMoving = true;

        if strcmp(movement, 'Already Going Left')
            direction = movement;
            set(messageLabeli, 'String', sprintf('Similar Action...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animelft.gif';

        else
            direction = movement;
            set(messageLabeli, 'String', sprintf('Device Is Moving...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animelft.gif';

        end
        end

    end
    function RightCallback(~, ~)
        
        movement = moveRight(DeviceCapacity, direction);
        if strcmp(movement, 'low power')
            direction = 'none';
            set(messageLabeli, 'String', 'Low Battery, Please Charge');
            image.ImageSource = 'MATLAB_codes/assets/upviewant.png';

        else
            isMoving = true;

        if strcmp(movement, 'Already Going Right')
            direction = movement;
            set(messageLabeli, 'String', sprintf('Similar Action...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animerght.gif';

        else
            direction = movement;
            set(messageLabeli, 'String', sprintf('Device Is Moving...: %s', movement));
            image.ImageSource = 'MATLAB_codes/assets/animerght.gif';

        end
        end
    end
end
