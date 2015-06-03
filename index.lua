defaultFileName = "turtle_index.dat"

function nextIndex(fileName)
    fileName = fileName or defaultFileName
    index = 0
    if fs.exists(fileName) then
        input = fs.open(fileName, "rb")
        index = input.read()
        input.close()
    output = fs.open(fileName, "w")
    output.write("" .. (index + 1))
    output.close()
    return index