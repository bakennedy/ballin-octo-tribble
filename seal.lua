arg = {...}

os.loadAPI("nav")

distance = tonumber(arg[1])

maxY = tonumber(arg[2])
maxZ = tonumber(arg[3])

function checkMove(detect, move)
	if not detect() then
		return move()
	end
	return false
end

function checkForward() return checkMove(turtle.detect, nav.forward) end
function checkUp() return checkMove(turtle.up, nav.up) end
function checkDown() return checkMove(turtle.down, nav.down) end

function placeChecked(detect, place)
	if not turtle.detect() then
		return turtle.place()
	end
	return false
end

function placeForward() return placeChecked(turtle.detect, turtle.place) end
function placeUp() return placeChecked(turtle.detectUp, turtle.placeUp) end
function placeDown() return placeChecked(turtle.detectDown, turtle.placeDown) end

function seal() 
	if nav.my == maxY then
		placeUp()
	elseif nav.my == 0 then
		placeDown()
	end
	if (nav.mz == 0 and nav.face == 3) or 
		(nav.mz == maxZ and nav.face == 1) then
		placeForward()
	end
end

function calibrate()
	maxY = 0
	maxZ = 0
	while checkUp() do
		maxY = maxY + 1
		print("my = " .. nav.my .. " maxY = " .. maxY)
	end
	nav.right(1)
	while checkForward() do
		maxZ = maxZ + 1
		print("mz = " .. nav.mz .. " maxZ = " .. maxZ)
	end
	print(string.format("Calibrated Tunnel is %d x %d", 
		maxZ, maxY))
end


if not maxY or not maxZ then
	calibrate()
	nav.goAbsolute(0,0,0)
	nav.turnFace(0)
end

nav.dumpCoords()

while nav.mx < distance do
	nav.forward()
	nav.left()
	maxBlocks = maxZ *2 + maxY*2 - 4
	for i = 1, maxBlocks do
		seal()
		if nav.mz == 0 then
			if nav.my >= maxY then
				nav.right(2)
				nav.forward()
			else
				nav.up()
			end
		elseif nav.mz == maxZ then
			if nav.my == 0 then
				nav.left(2)
				nav.forward()
			else
				nav.down()
			end
		else
			nav.forward()
		end
		nav.dumpCoords()
	end
	nav.right()
end

nav.goAbsolute(0,0,0)

