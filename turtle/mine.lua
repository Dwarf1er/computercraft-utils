function check_blocks()
    blocks = {}

    local success, data = turtle.inspect()
    if success then
        blocks["Forward"] = data
    end

    local success, data = turtle.inspectUp()
    if success then
        blocks["Up"] = data
    end

    local success, data = turtle.inspectDown()
    if success then
        blocks["Down"] = data
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

function mine_forward()
    blocks = check_blocks()

    if blocks["Forward"] == nil then
        turtle.forward()
    end
end
