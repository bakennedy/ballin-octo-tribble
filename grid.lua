arg = {...}

os.loadAPI("nav")

program = "bore"
index = arg[1]
xSize = 2
ySize = 1
yRange = 2
xOffset = 2
yOffset = 0
zOffset = 0
endFacing = 1

print("Starting index = " .. index)

dx = index * xSize
dy = (index % yRange) * ySize
nav.goRelative(dx, zOffset, dy)
nav.turnFace(endFacing)

shell.run(program)