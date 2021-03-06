arg = {...}

os.loadAPI("nav")
os.loadAPI("inv")

function reliableDown(item)
    if turtle.detectDown() then
            nav.clearDown()
        end
        inv.readyItem(item)
        turtle.placeDown()
end

function forwardDown(count, item)
    count = count or 1
    for i=1,count do
        nav.forward()
        reliableDown(item)
    end
end

function rectangleWall(xSize, zSize, ySize)
    for y=1, ySize do
        nav.up()
        for n=1,4 do
            if n % 2 == 1 then
                forwardDown(xSize)
            else
                forwardDown(zSize)
            end
            nav.right()
        end
    end
end

function threeSidedWall(xSize, zSize, ySize)
    for y=1, ySize do
        nav.up()
        for n=1,3 do
            if n % 2 == 1 then
                forwardDown(xSize)
            else
                forwardDown(zSize)
            end
            if y % 2 == 1 then
                nav.right()
            else
                nav.left()
            end
        end
        nav.turnFace(0)
    end
end

function rectangleFloor(xSize, zSize, item)
    for z=1,zSize do
        if z > 1 then
            nav.turnFace(1)
        end
        for x=1,xSize do
            forwardDown(item)
            if nav.getFace() == 1 then
                if z % 2 == 0 then
                    nav.turnFace(2)
                else
                    nav.turnFace(0)
                end
            end
        end
    end
end

argHandler = {
    forwardDown = function () forwardDown(arg[2]) end,
    rectangleWall =  function () rectangleWall(arg[2], arg[3], arg[4] or 1) end,
    threeSidedWall =  function () threeSidedWall(arg[2], arg[3], arg[4] or 1) end,
    rectangleFloor = function () rectangleFloor(arg[2], arg[3], arg[4]) end
}

argHandler[arg[1]]()
