-- ComputerCraft file sync library
-- by Brian Kennedy 2015

currentDir = "/" .. shell.dir()
if currentDir ~= "/" then
	currentDir = currentDir .. "/"
end

function download(url, file)
  local content = http.get(url).readAll()
  if not content then
        error("Could not connect to " .. url)
  end
  local f = fs.open(currentDir .. file, "w")
  f.write(content)
  f.close()
end

base = "https://raw.githubusercontent.com/bakennedy"
branch = "/ballin-octo-tribble/master"
files = {
	nav = "/nav.lua",
	grid = "/grid.lua",
	indexer = "/indexer.lua",
}


for localName, remotePath in pairs(files) do
	local url = base .. branch .. remotePath
	download(url, localName)
end
