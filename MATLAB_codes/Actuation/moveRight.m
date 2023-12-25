function MovingRight = moveRight(power, direction)
if power > 0.0083
if strcmp(direction, 'right')
    MovingRight = 'Already Going Right';
else
    MovingRight = 'right';
end
else
    MovingRight = 'low power';
end
end