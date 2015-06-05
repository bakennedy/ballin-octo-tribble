-- ComputerCraft file sync library
-- by Brian Kennedy 2015

currentDir = "/" .. shell.dir()
if currentDir ~= "/" then
	currentDir = currentDir .. "/"
end
print("Syncing " .. currentDir)

function getUrl(url)
  local response = http.get(url)
  if not response then
        return nil
  end
  return response.readAll()
end

function download(url, file)
  local content = getUrl(url)
  if not content then
    print(file .. "  Failed")
    return
  end
  local f = fs.open(currentDir .. file, "w")
  f.write(content)
  f.close()
  print(file .. "  Ok")
end

function getFileList(url)
  local content = getUrl(url)
  return textutils.unserialize(content)
end

base = "https://raw.githubusercontent.com/bakennedy"
branch = "/ballin-octo-tribble/master/"
root = base .. branch

syncListUrl = "syncList.table"
files = getFileList(root .. syncListUrl)

for localName, remotePath in pairs(files) do
	local url = root .. remotePath
	download(url, localName)
end
