function MovingBackward = moveBackward(power, direction)
if power > 0.0083
if strcmp(direction, 'backward')
    MovingBackward = 'Already Going Backward';
else
    MovingBackward = 'backward';
end
else
    MovingBackward = 'low power';
end
end