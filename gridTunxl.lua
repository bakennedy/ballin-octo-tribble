arg = {...}

os.loadAPI("nav")
os.loadAPI("indexer")
indexFile = "index_gridBore"
index = indexer.command(arg[1], indexFile)
program =  "tunxl"
width = arg[2] or 1

if index > 1 then
	nav.goZ((index-1) * width)
	nav.turnFace(0)
end

shell.run(program, width)

nav.goAbsolute(0, 1, -1)