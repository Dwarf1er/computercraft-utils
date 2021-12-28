function check_blocks()
    blocks = {
        ["Up"] = turtle.inspectUp(),
        ["Down"] = turtle.inspectDown(),
        ["Forward"] = turtle.inspect()
    }

    turtle.turnLeft()
    blocks["Left"] = turtle.inspect()
    turtle.turnLeft()
    blocks["Back"] = turtle.inspect()
    turtle.turnLeft()
    blocks["Right"] = turtle.inspect()
    turtle.turnLeft()

    return blocks
end

function mine_main()
    print(check_blocks())
end
