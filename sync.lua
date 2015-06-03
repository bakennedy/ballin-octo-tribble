-- ComputerCraft file sync library
-- by Brian Kennedy 2015

function download(url, file)
  local content = http.get(url).readAll()
  if not content then
        error("Could not connect to " .. url)
  end
  local f = fs.open(file, "w")
  f.write(content)
  f.close()
end

base = "https://raw.githubusercontent.com/bakennedy"
branch = "/ballin-octo-tribble/master"
files = {
	nav = "/nav.lua",
	grid = "/grid.lua",
	index = "/index.lua",
}

for localName, remotePath in pairs(files) do
	local url = base .. branch .. remotePath
	download(url, localName)
end
