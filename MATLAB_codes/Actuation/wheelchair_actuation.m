% Create a function for simulating actuation
function is_Obstacle =  wheelchair_actuation(power, isMoving, distance)
distancex = 0;
obstacleDetected = 0;
if power > 5
if isMoving
    nonadist = distance - distancex;
    if nonadist == 10
        distancex = distance;
        obstacleDetected = 1;
    else
        obstacleDetected = 0;
    end
    if obstacleDetected == 1
         is_Obstacle = 'detected';
    else
         is_Obstacle = 'undetected';
    end
else
    is_Obstacle = 'irrelevant';
end
else
    is_Obstacle = 'low power';
end
end
    