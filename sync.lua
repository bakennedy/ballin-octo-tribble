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
}

for localName, remotePath in pairs(files) do
	download(remotePath, localName)
end
