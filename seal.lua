arg = {...}

os.loadAPI("nav")

distance = tonumber(arg[1])

maxY = tonumber(arg[2])
maxZ = tonumber(arg[3])

function readyItem()
	local slot, count
	repeat
		slot = turtle.getSelectedSlot()
		count = turtle.getItemCount(slot)
		if count == 0 then
			if slot == 16 then 
				return false 
			end
			turtle.select(slot+1)
		end
	until count > 0 or slot == 16
	return slot
end
		

function checkMove(detect, move)
	if not detect() then
		return move()
	end
	return false
end

function checkForward() return checkMove(turtle.detect, nav.forward) end
function checkUp() return checkMove(turtle.detectUp, nav.up) end
function checkDown() return checkMove(turtle.detectDown, nav.down) end

function placeChecked(detect, place)
	if not detect() then
		readyItem()
		return place()
	end
	return false
end

function placeForward()
	print("placeForward")
	return placeChecked(turtle.detect, turtle.place) 
end
function placeUp() return placeChecked(turtle.detectUp, turtle.placeUp) end
function placeDown() return placeChecked(turtle.detectDown, turtle.placeDown) end

function seal() 
	if nav.getY() == maxY then
		placeUp()
	end
	if nav.getY() == 0 then
		placeDown()
	end

	if (nav.getZ() == 0 and nav.getFace() == 3) or 
		(nav.getZ() == maxZ and nav.getFace() == 1) then
		placeForward()
	end
end

function calibrate()
	maxY = 0
	maxZ = 0
	while checkUp() do
		maxY = maxY + 1
		print("my = " .. nav.getY() .. " maxY = " .. maxY)
	end
	nav.right(1)
	while checkForward() do
		maxZ = maxZ + 1
		print("mz = " .. nav.getZ() .. " maxZ = " .. maxZ)
	end
end


if not maxY or not maxZ then
	calibrate()
	nav.goAbsolute(0,0,0)
	nav.turnFace(0)
end

maxBlocks = (maxZ + 1) * 2 + (maxY + 1) * 2 - 4
print(string.format("Tunnel is %d x %d", maxZ, maxY))
print("Max Blocks = " .. maxBlocks)

while nav.getX() < distance do
	print(string.format("Outer While mx = %d distance = %d", nav.getX(), distance))
	nav.dumpCoords()
	nav.forward()
	nav.left()

	for i = 1, maxBlocks do
		seal()
		if nav.getZ() == 0 then
			if nav.getY() >= maxY then
				nav.right(2)
				nav.forward()
			else
				nav.up()
			end
		elseif nav.getZ() == maxZ then
			if nav.getY() == 0 then
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

