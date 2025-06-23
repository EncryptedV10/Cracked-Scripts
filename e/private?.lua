local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Nova-Library/refs/heads/main/Library.lua", true))()

local window = Library:AddWindow("Adopt's Private Script")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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

local KillerTab = window:CreateTab("Killing")

KillerTab:AddLabel("Whitelist")
local TextBox = KillerTab:AddTextbox("Whitelist Player", function(text)
end)

local TextBoxUnWhitelist = KillerTab:AddTextbox("UnWhitelist Player", function(text)
end)

KillerTab:AddLabel("Killer")
local AutoKillToggle = KillerTab:AddToggle("Auto Kill", function(Value)
    _G.autoPunchActive = Value

    if Value then
        local function equipAndModifyPunch()
            while _G.autoPunchActive do
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                wait(0)
            end
        end

        local function autoPunchAction()
            while _G.autoPunchActive do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                wait(0)
            end
        end

        coroutine.wrap(equipAndModifyPunch)()
        coroutine.wrap(autoPunchAction)()

        while _G.autoPunchActive do
            for _, plr in pairs(game.Players:GetPlayers()) do
                if not table.find(whitelistedPlayers, plr.Name) then
                    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, hrp, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, hrp, 1)
                    end
                end
            end
            wait(0.1)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end)

KillerTab:AddLabel("Targeting")
local playerList = {}

game.Players.PlayerAdded:Connect(function(player)
    table.insert(playerList, player.Name)
end)

game.Players.PlayerRemoving:Connect(function(player)
    for i, v in pairs(playerList) do
        if v == player.Name then
            table.remove(playerList, i)
        end
    end
end)

local Dropdown = KillerTab:AddDropdown("Dropdown", playerList, function(selected)
end)

local KillTargetToggle = KillerTab:AddToggle("Kill Target", function(Value)
    if Value then
        while Value do
            local target = game.Players:FindFirstChild(Dropdown.Selected)
            if target then
                local hrp = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, hrp, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, hrp, 1)

                    local player = game.Players.LocalPlayer
                    local character = player.Character
                    if character then
                        local punchTool = character:FindFirstChild("Punch")
                        if punchTool then
                            punchTool:Activate()
                        end
                    end
                end
            end
            wait(0.1)
        end
    end
end)

local SpecateTargetToggle = KillerTab:AddToggle("Specate Target", function(Value)
    if Value then
        local target = game.Players:FindFirstChild(Dropdown.Selected)
        if target then
            local camera = game.Workspace.CurrentCamera
            camera.CameraSubject = target.Character.Humanoid
            game:GetService("RunService").Heartbeat:Connect(function()
                if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
                    Value = false
                    camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                end
            end)
        end
    end
end)
