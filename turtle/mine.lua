function check_blocks()
    blocks = {}

    local success, data = turtle.inspect()
    if success then
        blocks["Forward"] = data
    else
        blocks["Forward"] = nil
    end

    local success, data = turtle.inspectUp()
    if success then
        blocks["Up"] = data
    else
        blocks["Up"] = nil
    end

    local success, data = turtle.inspectDown()
    if success then
        blocks["Down"] = data
    else
        blocks["Down"] = nil
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Left"] = data
    else
        blocks["Left"] = nil
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Back"] = data
    else
        blocks["Back"] = nil
    end

    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success then
        blocks["Right"] = data
    else
        blocks["Right"] = nil
    end

    turtle.turnLeft()

    return blocks
end

function mine_main()
    print(check_blocks())
end
