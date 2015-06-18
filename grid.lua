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
yUnits = 3
xOffset = 2
yOffset = 0
zOffset = 0
endFacing = 1




print("Starting index = " .. index)

dx = math.floor((index - 1) / yUnits) * 2 + (index - 1) % (yUnits)
dy = ((index - 1) % yUnits) * 3 + math.floor((index - 1) / yUnits) % 3
nav.goRelative(dx, zOffset, dy)
nav.turnFace(endFacing)
print("Running " .. program)
shell.run(program, unpack(extraArguments))
