-- ComputerCraft Turtle Navigation library
-- by Brian Kennedy 2015


-- Global navigation state
-- mx, my, and mz are relative coordinates from the origin
mx, my, mz = 0, 0, 0
-- face is [0,4) and indexes nav below
face = 0

-- a table of relative nagivation update functions indexed by face+1 in [1,4]
nav = {
    -- These are indexed by the face global variable
    -- some kind of other calibration routine would be needed to change this
    function() mx = mx + 1 end, -- 0 +X
    function() mz = mz + 1 end, -- 1 +Z
    function() mx = mx - 1 end, -- 2 -X
    function() mz = mz - 1 end, -- 3 -Z
    -- These are called explicitly from up and down respectively
    function() my = my + 1 end,
    function() my = my - 1 end
}

-- Generic obstruction clearing logic.
function clearWhat(detect, dig, attack)
    -- Check if there is a block and dig it
    if detect() then
        dig()
        -- If we detect a block, it's a falling sand or gravel
        -- These falling blocks can't acutally be mined for 0.8s
        if detect() then
              sleep(0.8)
        end
    else
        -- if there is no block, then we're obstructed by a mob
        attack()
    end
end

function clear()
    clearWhat(turtle.detect, turtle.dig, turtle.attack)
end

function clearUp()
    clearWhat(turtle.detectUp, turtle.digUp, turtle.attackUp)
end

function clearDown()
    clearWhat(turtle.detectDown, turtle.digDown, turtle.attackDown)
end

-- go forward and 
function forward(count)
    count = count or 1
    for i=1, count do
        while not turtle.forward() do
            clear()
        end
        nav[face+1]()
    end
    return true
end

-- back that thing up, or if that doesn't work, turn around and clear
function back(count)
    count = count or 1
    for i=1, count do
        while not turtle.back() do
            right()
            right()
            clear()
            right()
            right()
        end
        nav[(face + 2) % 4 + 1]()
    end
    return true
end

function left(count)
    count = count or 1
    for i=1, count do
        while not turtle.turnLeft() do
            clear()
        end
        face = (face - 1) % 4
    end
    return true
end

function right(count)
    count = count or 1
    for i=1, count do
        while not turtle.turnRight() do
            clear()
        end
        face = (face + 1) % 4
    end
    return true
end

function up(count)
    count = count or 1
    for i=1, count do
        while not turtle.up() do
            clearUp()
        end
        nav[5]()
    end
    return true
end

function down(count)
    count = count or 1
    for i=1, count do
        while not turtle.down() do
            clearDown()
        end
        nav[6]()
    end
    return true
end

function turnFace(newFace)
    direction = right
    if face - newFace == 1 then
        direction = left
    end
    while face ~= newFace do
        direction()
    end
    return true
end

function goX(count)
    if count < 0 then 
        turnFace(2)
        forward(count)
    elseif count > 0 then
        turnFace(0)
        forward(count)
    end
end

function goZ(count)
    if count < 0 then 
        turnFace(3)
        forward(count)
    elseif count > 0 then
        turnFace(1)
        forward(count)
    end
end

function goY(count)
    if count < 0 then
        down(-1 * count)
    elseif count > 0 then
        up(count)
    end
end

function goRelative(x, z, y)
    goY(y)
    goZ(z)
    goX(x)
end

function goAbsolute(x, z, y)
    goY(y - my)
    goZ(z - mz)
    goX(x - mx)
end

function getX() return mx end
function getY() return my end
function getZ() return mz end

function dumpCoords()
    print(string.format("Facing = %d\n  mX = %d, mZ = %d, mY = %d", face, mx, mz, my))
end

function test()
    goRelative(1, 1, 1)
    dumpCoords()
end
