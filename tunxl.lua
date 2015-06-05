os.loadAPI("nav")

arg = {...}

function clearForward(count)
	nav.forward()
	nav.clearDown()
	nav.clearUp()
end

depth = arg[1]
width = arg[2] or 1