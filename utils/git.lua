local tArgs = { ... }

if #tArgs < 2 then
    print("Usage: git <user> <repo>")
    return
end

local user = tArgs[1]
local repo = tArgs[2]

local handle = fs.open(".token", "r")
local token = handle.readLine()

local headers = {
    ["User-Agent"] = "ComputerCraft 1.8",
    ["Authorization"] = "token " .. token
}

local handle = http.get("https://api.github.com/repos/" .. user .. "/" .. repo .. "/contents/", headers)
local contents = textutils.unserialiseJSON(handle.readAll())

if fs.exists(repo) then
    fs.delete(repo)
end

fs.makeDir(repo)

for _, entry in pairs(contents) do
    local path = entry["path"]
    local fh = fs.open(repo .. "/" .. path, "w")
    local url = entry["download_url"]

    local handle = http.get(url, headers)
    local data = handle.readAll()

    fh.write(data)

    fh.close()
end
