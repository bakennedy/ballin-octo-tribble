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
print("Going to x = " .. (dx + xOffset) .. " y = " .. (dy + yOffset)
nav.goRelative(dx + xOffset, zOffset, dy + yOffset)
nav.turnFace(endFacing)
print("Running " .. program)
shell.run(program, unpack(extraArguments))
