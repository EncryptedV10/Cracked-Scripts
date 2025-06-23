local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Nova-Library/refs/heads/main/Library.lua", true))()

local window = Library:AddWindow("Adopt's Private Script")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer

local main = window:CreateTab("Main")

local function unequipAllPets()
    local petsFolder = player:WaitForChild("petsFolder")
    for _, folder in pairs(petsFolder:GetChildren()) do
        if folder:IsA("Folder") then
            for _, pet in pairs(folder:GetChildren()) do
                ReplicatedStorage.rEvents.equipPetEvent:FireServer("unequipPet", pet)
            end
        end
    end
    task.wait(0.1)
end

local function equipUniquePet(petName)
    unequipAllPets()
    task.wait(0.01)
    for _, pet in pairs(player.petsFolder.Unique:GetChildren()) do
        if pet.Name == petName then
            ReplicatedStorage.rEvents.equipPetEvent:FireServer("equipPet", pet)
        end
    end
end

local function formatNumber(number)
    if not number then return "0" end
    local formatted = tostring(math.floor(number))
    local k
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function formatLargeNumber(num)
    if num >= 1e9 then
        return string.format("%.2fB", num / 1e9)
    elseif num >= 1e6 then
        return string.format("%.2fM", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.2fK", num / 1e3)
    else
        return string.format("%.0f", num)
    end
end

local startRebirths = player.leaderstats.Rebirths.Value
local startTime = os.time()

main:AddToggle("SpeedGrind", function(state)
    isSpeedGrinding = state
    if not state then
        unequipAllPets()
        return
    end

    equipUniquePet("Swift Samurai")
    for i = 1, 125 do
        task.spawn(function()
            while isSpeedGrinding do
                for j = 1, 2 do
                    player.muscleEvent:FireServer("rep")
                end
                task.wait(0.01)
            end
        end)
    end
end)

main:AddToggle("PackFarm", function(state)
    isRunning = state
    if state then
        task.spawn(function()
            while isRunning do
                local currentRebirths = player.leaderstats.Rebirths.Value
                local rebirthCost = 10000 + (5000 * currentRebirths)

                if player.ultimatesFolder:FindFirstChild("Golden Rebirth") then
                    local goldenRebirths = player.ultimatesFolder["Golden Rebirth"].Value
                    rebirthCost = math.floor(rebirthCost * (1 - (goldenRebirths * 0.1)))
                end

                local targetStrength = rebirthCost + 1000000

                unequipAllPets()
                task.wait(0.1)
                equipUniquePet("Swift Samurai")

                while isRunning and player.leaderstats.Strength.Value < targetStrength do
                    for i = 1, 20 do
                        player.muscleEvent:FireServer("rep")
                    end
                    task.wait(0.01)
                end

                unequipAllPets()
                task.wait(0.1)
                equipUniquePet("Tribal Overlord")

                local initialRebirths = player.leaderstats.Rebirths.Value
                repeat
                    ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    task.wait(0.1)
                until player.leaderstats.Rebirths.Value > initialRebirths

                if not isRunning then break end
                task.wait(0.01)
            end
        end)
    end
end)

main:AddToggle("AutoEgg", function(state)
    _G.AutoEgg = state
    if state then
        task.spawn(function()
            while _G.AutoEgg do
                local proteinEgg = player.Backpack:FindFirstChild("Protein Egg")
                if proteinEgg then
                    proteinEgg.Parent = player.Character
                    for i = 1, 5 do
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait()
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        task.wait(0.1)
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

main:AddToggle("HideFrames", function(state)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not state
        end
    end
end)
