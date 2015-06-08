arg = {...}

os.loadAPI("nav")
os.loadAPI("inv")

xSize = arg[1]
zSize = arg[2]
ySize = arg[3] or 1

function forwardDown(count)
    count = count or 1
    for i=1,count do
        nav.forward()
        turtle.placeDown()
    end
end

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
