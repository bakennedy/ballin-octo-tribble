defaultFileName = "/disk/grid_last_index.dat"

function nextIndex(fileName)
    fileName = fileName or defaultFileName
    index = 0
    if fs.exists(fileName) then
        input = fs.open(fileName, "rb")
        index = input.read()
        input.close()
    end
    index = index + 1
    output = fs.open(fileName, "wb")
    output.write()
    output.close()
    return index
end