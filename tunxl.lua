os.loadAPI("nav")

arg = {...}

function clearForward()
	nav.forward()
	nav.clearDown()
	nav.clearUp()
end

depth = arg[1] or 1
width = arg[2] or 1

for z=1,width do
	local distance = depth
	if z % 2 == 0 then
		nav.right()
		nav.clearForward()
		nav.right()
		distance = distance - 1
	elseif z > 1 then
		nav.left()
		nav.clearForward()
		nav.left()
		distance = distance - 1
	for i=1, distance do
		clearForward()
	end
end
if width % 2 == 1 then
	nav.goX( -1 * depth)
end