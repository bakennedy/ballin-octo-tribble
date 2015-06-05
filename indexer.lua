function nextIndex(fileName)
    if not fileName then
        print("Missing index file name!")
        exit()
    end
    path = "/disk/" .. fileName
    index = 0
    if fs.exists(path) then
        input = fs.open(path, "rb")
        index = input.read()
        input.close()
    end
    index = index + 1
    output = fs.open(path, "wb")
    output.write(index)
    output.close()
    return index
end

function resetIndex(fileName, index)
    if not fileName then
        print("Missing index file name!")
        exit()
    end
    path = "/disk/" .. fileName
    if not index then
        index = 0
    end
    output = fs.open(path, "wb")
    output.write(index)
    output.close()
end

function command(cmd, indexFile)
    cmd = cmd or "auto"
    if cmd == "reset" then
        return resetIndex(indexFile)
    end
    if cmd == "auto" then
        return indexer.nextIndex(indexFile)
    end
    return cmd