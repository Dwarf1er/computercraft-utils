function check_blocks()
    blocks = {}

    local success, data = turtle.inspectUp()
    if success then
        blocks["Up"] = data
    end

    local success, data = turtle.inspectDown()
    if success then
        blocks["Down"] = data
    end

    local success, data = turtle.inspect()
    if success then
        blocks["Forward"] = data
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Left"] = data
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Back"] = data
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Right"] = data
    end

    turtle.turnLeft()

    return blocks
end

function mine_direction(direction)
    if direction == "Up" then
        turtle.digUp()
    elseif direction == "Down" then
        turtle.digDown()
    elseif direction == "Forward" then
        turtle.dig()
    elseif direction == "Left" then
        turtle.turnLeft()
        turtle.dig()
        turtle.turnRight()
    elseif direction == "Right" then
        turtle.turnRight()
        turtle.dig()
        turtle.turnLeft()
    elseif direction == "Back" then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function mine_forward()
    blocks = check_blocks()

    for direction, data in pairs(blocks) do
        if data["name"]:match("ore") then
            mine_direction(direction)
        end
    end

    mine_direction("Forward")
    
    return turtle.forward()
end
