local args = { ... }
local token_path = ".token"

function print_usage()
    print("Usage: git clone <user> <repo>")
    print("Usage: git token <token>")
end

if #args < 1 then
    print_usage()
    return
end

local command = args[1]

if command == "clone" then
    local user = args[2]
    local repo = args[3]

    if not fs.exists(token_path) then
        print("Add your token using: git token <token>")
        return
    end

    local fh = fs.open(".token", "r")
    local token = fh.readLine()
    fh.close()

    local headers = {
        ["User-Agent"] = "ComputerCraft 1.8",
        ["Authorization"] = "token " .. token
    }

    print("Cloning repo " .. user .. "/" .. repo)
    function download(path)
        local base_path = user .. "/" .. repo

        local wh = http.get("https://api.github.com/repos/" .. base_path .. "/contents/" .. path, headers)
        local contents = textutils.unserializeJSON(wh.readAll())

        local dir = base_path .. "/" .. path
        if fs.exists(dir) then
            fs.delete(dir)
        end

        for _, entry in pairs(contents) do
            local path = entry["path"]
            local type = entry["type"]

            if type == "file" then
                local fh = fs.open(base_path .. "/" .. path, "w")
                local handle = http.get(entry["download_url"], headers)
                local data = handle.readAll()
                fh.write(data)
                fh.close()
            elseif type == "dir" then
                download(path)
            end
        end
    end

    download("")
    print("Done cloning!")
elseif command == "token" then
    local token = args[1]

    local fh = fs.open(token_path, "w")
    fh.write(token)
    fh.close()
else
    print_usage()
    return
end
