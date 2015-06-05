arg = {...}

os.loadAPI("nav")
os.loadAPI("indexer")
indexFile = "index_gridBore"
index = indexer.command(arg[1], indexFile)
program =  "bore"

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