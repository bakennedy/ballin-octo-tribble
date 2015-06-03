arg = {...}

os.loadAPI("nav")
os.loadAPI("index")

index = arg[1]
if index == "auto" then
	index = index.nextIndex()
end
program = arg[2] or "bore"
extraArguments = {}
for i=3, #arg do
	extraArguments.append(arg[i])
end

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

shell.run(program, unpack(extraArguments))