--Its coded kinda shitty with things it dont needs to do but it works so im happy with it
warn("[DEBUG] LOADING XENIJOS UNHASER V-1")
local hashTable = {}

for i, v in pairs(getgc()) do
    if type(v) == "function" and debug.getinfo(v).name == "get_remote_from_cache" then
        wait(0.5)
        local info = debug.getinfo(v)
        local upvalues = debug.getupvalues(v)
        
        local functionName = info.name
        local hash = ""

        if next(upvalues) ~= nil and type(upvalues[1]) == "table" then
            local remoteTable = upvalues[1]
            
            hashTable[functionName] = {}

            for key, value in pairs(remoteTable) do
                hashTable[functionName][key] = value
            end
        end
    end
end

local remotes = {}
local hashes = {}


for functionName, tableContents in pairs(hashTable) do
    for key, value in pairs(tableContents) do
        remotes[value] = key
        hashes[key] = value
    end
end

local apiFolder = game:GetService("ReplicatedStorage").API
for _, remoteTable in pairs(apiFolder:GetDescendants()) do
    if remoteTable:IsA("RemoteEvent") or remoteTable:IsA("RemoteFunction") then
        local originalName = remotes[remoteTable]
        if originalName then
            remoteTable.Name = originalName
        end
    end
end

for _, remoteTable in pairs(apiFolder:GetDescendants()) do
    if remoteTable:IsA("RemoteEvent") or remoteTable:IsA("RemoteFunction") then
        print(remoteTable.Name)
    end
end
warn("Loaded")
