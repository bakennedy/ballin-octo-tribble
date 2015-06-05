arg = {...}

os.loadAPI("nav")

distance = arg[1]
side = arg[2]
vertical = arg[3]
turn, unTurn = nav.left, nav.right
if side == "right" then
	turn, unTurn = nav.right, nav.left
end
for i=1,distance do
	nav.forward()
	if vertical == "up" then
		turtle.placeUp()
	elseif vertical == "down" then
		turtle.placeDown()
	end
	turn()
	turtle.place()
	unTurn()
end

