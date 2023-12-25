% Create a function to initialize and display the GUI
function wheelchair_GMI()

    % Create a figure
    fig = figure('Name', 'G.M.I', 'Position', [50, 50, 360, 600], 'NumberTitle', 'off', 'MenuBar', 'none');

    batteryback = uicontrol('Style', 'text', 'String', '', 'Position', [20, 552, 55, 15], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'BackgroundColor', 'black', 'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'blue');
    batterybacki = uicontrol('Style', 'text', 'String', '', 'Position', [20, 550, 50, 20], 'HandleVisibility', 'on', 'Tag', 'myMessageLabel', 'BackgroundColor', 'black', 'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'blue');
    

     % declare a whole new set of colors;
    darkButtonColor = [1, 1, 1]; % Slightly lighter than the background
    redButtonColor = [1, 0, 0]; % red border color


    % power system generation
    textStatement  = uicontrol('Style', 'text', 'String', 'H.M.I signals', 'Position', [0, 300, 70, 40], 'ForegroundColor', 'black');
    Processors = uicontrol('Style', 'text', 'String', 'G.M.I (processor)', 'Position', [0, 180, 70, 40], 'ForegroundColor', 'black');
    Processorsx = uicontrol('Style', 'text', 'String', 'Actuation System', 'Position', [0, 70, 70, 40], 'ForegroundColor', 'black');
    DistanceSectioni = uicontrol('Style', 'text', 'String', '', 'Position', [30, 120, 60, 60], 'BackgroundColor', 'black', 'ForegroundColor', 'black');
    line1 = uicontrol("Style",'text','String','','Position',[70, 170, 5, 90], 'BackgroundColor', 'black');
    line2 = uicontrol("Style",'text','String','','Position',[70, 60, 5, 90], 'BackgroundColor', 'black');

    ActionScreen = uicontrol('Style', 'text', 'String', 'None', 'Position', [30, 230, 80, 80], 'BackgroundColor', 'black',  'FontSize', 10, 'FontWeight', 'bold', 'ForegroundColor', 'green');
    ActionScreen2 = uicontrol('Style', 'text', 'String', 'None', 'Position', [30, 0, 80, 80], 'BackgroundColor', 'black',  'FontSize', 7, 'FontWeight', 'bold', 'ForegroundColor', 'green');
    DistanceSection = uicontrol('Style', 'text', 'String', 'STATUS UPDATE: not moving', 'Position', [120, 270, 200, 30], 'ForegroundColor', 'black');
   
    batteryLabel = uicontrol('Style', 'text', 'String', '?', 'Position', [22, 552, 45, 16], 'FontWeight','bold');


    image = uiimage('Position', [190, 110, 200, 200]);
    image.ImageSource = 'MATLAB_codes/assets/upviewant.png';

    battery_capacity = 120;

    function updateBatteryStatus(battery_capacity)
        newCapi = (battery_capacity/120)*100;
        newCap = round(newCapi);
        if newCap > 26
        set(batteryLabel, 'String', newCap,  'BackgroundColor', 'green');
        else
            set(batteryLabel, 'String', newCap, 'BackgroundColor', 'red');
        end
    end

    % Simulate receiving control signals (for demonstration)
    function simulateControlSignal()
        if battery_capacity > 10
        % Simulated control signal (randomly choose Forward, Backward, or Stop)
        signals = {'Forward', 'Backward', 'Left', 'Right', 'Stop'};
        signal = signals{randi(length(signals))};
        receiveControlSignals(signal);
        else
            receiveControlSignals('Stop');
        end
    end
function updateCurrentAction(signal)
        if strcmp(signal, 'Forward')
            set(ActionScreen, 'String', 'Forward', 'ForegroundColor', 'white');
            set(ActionScreen2, 'String', 'heading Forward', 'ForegroundColor', 'green');

            set(DistanceSection, 'String', 'STATUS UPDATE: moving Forward');
            image.ImageSource = 'MATLAB_codes/assets/animefwd.gif';

        elseif strcmp(signal, 'Backward')
            set(ActionScreen, 'String', 'Backward', 'ForegroundColor', 'white');
            set(ActionScreen2, 'String', 'going back', 'ForegroundColor', 'green');
            set(DistanceSection, 'String', 'STATUS UPDATE: moving Backward');
            image.ImageSource = 'MATLAB_codes/assets/animebwd.gif';
        elseif strcmp(signal, 'Left')
            set(ActionScreen, 'String', '< Left', 'ForegroundColor', 'white');
            set(ActionScreen2, 'String', 'Forward', 'ForegroundColor', 'white');
            set(ActionScreen2, 'String', 'going Left', 'ForegroundColor', 'green');
            set(DistanceSection, 'String', 'STATUS UPDATE: moving Left');
            image.ImageSource = 'MATLAB_codes/assets/animelft.gif';
        elseif strcmp(signal, 'Right')
            set(ActionScreen, 'String', 'Right >', 'ForegroundColor', 'white');
            set(ActionScreen2, 'String', 'going Right', 'ForegroundColor', 'green');
            set(DistanceSection, 'String', 'STATUS UPDATE: moving Right');
            image.ImageSource = 'MATLAB_codes/assets/animerght.gif';
        elseif strcmp(signal, 'Stop')
            set(ActionScreen, 'String', 'Stopped', 'ForegroundColor', 'red');
            set(ActionScreen2, 'String', 'Stopped', 'ForegroundColor', 'red');
            set(DistanceSection, 'String', 'STATUS UPDATE: Obstacle Encountered, System Stopped');
            image.ImageSource = 'MATLAB_codes/assets/upviewant.png';
        else
            set(actionLabel, 'String', 'Unknown', 'ForegroundColor', 'red');
            set(DistanceSection, 'String', 'STATUS UPDATE: unknown signal detected');
        end
    end

function receiveControlSignals(signal)
        set(ActionScreen, 'String', signal);
        % Implement code here to interpret and act on the received control signal
        % For simulation purposes, we'll just display the signal.
        disp(['Received Control Signal: ' signal]);
        
        % Update the current action label based on the received signal
        updateCurrentAction(signal);
end

 function simulateBatteryStatusUpdate()
        % Simulated battery status (replace with actual reading code)
        % simulating power usage ... 
        newCapacity = PowerReduction(battery_capacity);  % Simulated battery capacity between 50% and 100%
        battery_capacity = newCapacity;
        updateBatteryStatus(newCapacity);
    end

% Periodically simulate battery status update
    batteryTimer = timer('ExecutionMode', 'fixedRate', 'Period', 10, 'TimerFcn', @(~,~) simulateBatteryStatusUpdate());
    start(batteryTimer);

    % Periodically simulate receiving control signals
    controlTimer = timer('ExecutionMode', 'fixedRate', 'Period', 5, 'TimerFcn', @(~,~) simulateControlSignal());
    start(controlTimer);

end
