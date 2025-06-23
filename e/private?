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

local Killer = window:CreateTab("Killing")

Killer:AddToggle("Auto Good Karma", function(bool)
    autoGoodKarma = bool

    if autoGoodKarma then
        spawn(function()
            while autoGoodKarma do
                local player = game.Players.LocalPlayer
                local playerChar = player.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(game.Players:GetPlayers()) do
                        if target ~= player then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")

                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and evilKarma.Value > goodKarma.Value then
                                local targetChar = target.Character
                                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    end
end)

Killer:AddToggle("Auto Bad Karma", function(bool)
    autoBadKarma = bool

    if autoBadKarma then
        spawn(function()
            while autoBadKarma do
                local player = game.Players.LocalPlayer
                local playerChar = player.Character
                local rightHand = playerChar and playerChar:FindFirstChild("RightHand")
                local leftHand = playerChar and playerChar:FindFirstChild("LeftHand")

                if playerChar and rightHand and leftHand then
                    for _, target in ipairs(game.Players:GetPlayers()) do
                        if target ~= player then
                            local evilKarma = target:FindFirstChild("evilKarma")
                            local goodKarma = target:FindFirstChild("goodKarma")

                            if evilKarma and goodKarma and evilKarma:IsA("IntValue") and goodKarma:IsA("IntValue") and goodKarma.Value > evilKarma.Value then
                                local targetChar = target.Character
                                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                                if rootPart then
                                    firetouchinterest(rightHand, rootPart, 1)
                                    firetouchinterest(leftHand, rootPart, 1)
                                    firetouchinterest(rightHand, rootPart, 0)
                                    firetouchinterest(leftHand, rootPart, 0)
                                end
                            end
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    end
end)

Killer:AddLabel("Whitelisting")
local playerWhitelist = {}
Killer:AddTextBox("Whitelist", function(text)
    local targetPlayer = game.Players:FindFirstChild(text)
    if targetPlayer then
        playerWhitelist[targetPlayer.Name] = true
    end
end)

Killer:AddTextBox("UnWhitelist", function(text)
    local targetPlayer = game.Players:FindFirstChild(text)
    if targetPlayer then
        playerWhitelist[targetPlayer.Name] = nil
    end
end)

Killer:AddLabel("Auto Killing")
local autoKill = false
Killer:AddToggle("Auto Kill", function(bool)
    autoKill = bool

    while autoKill do
        local player = game.Players.LocalPlayer

        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and not playerWhitelist[target.Name] then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")

                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end

        wait(0.01)
    end
end)

Killer:AddLabel("Targeting")
local targetPlayerName = nil
Killer:AddTextBox("Target Name", function(text)
    targetPlayerName = text
end)

local targetDropdown = Killer:AddDropdown("Select Target", function(selected)
    targetPlayerName = selected
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    targetDropdown:Add(player.Name)
end

game.Players.PlayerAdded:Connect(function(player)
    targetDropdown:Add(player.Name)
end)

game.Players.PlayerRemoving:Connect(function(player)
    targetDropdown:Remove(player.Name)
end)

local killTarget = false
Killer:AddToggle("Kill Target", function(bool)
    killTarget = bool

    while killTarget do
        local player = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetPlayerName)

        if target and target ~= player then
            local targetChar = target.Character
            local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

            if rootPart then
                local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")

                if rightHand and leftHand then
                    firetouchinterest(rightHand, rootPart, 1)
                    firetouchinterest(leftHand, rootPart, 1)
                    firetouchinterest(rightHand, rootPart, 0)
                    firetouchinterest(leftHand, rootPart, 0)
                end
            end
        end

        wait(0.01)
    end
end)

local spying = false
Killer:AddToggle("Spy Player", function(bool)
    spying = bool

    if not spying then
        local player = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or player
        return
    end

    while spying do
        local player = game.Players.LocalPlayer
        local target = game.Players:FindFirstChild(targetPlayerName)

        if target and target ~= player then
            local targetChar = target.Character
            local targetHumanoid = targetChar and targetChar:FindFirstChild("Humanoid")

            if targetHumanoid then
                local camera = workspace.CurrentCamera
                camera.CameraSubject = targetHumanoid
            end
        end

        wait(0.1)
    end
end)

Killer:AddLabel("Punching Tool")
local autoEquipPunch = false
Killer:AddToggle("Auto Equip Punch", function(state)
    autoEquipPunch = state

    while autoEquipPunch do
        local player = game.Players.LocalPlayer
        local punchTool = player.Backpack:FindFirstChild("Punch")

        if punchTool then
            punchTool.Parent = player.Character
        end

        wait(0.1)
    end
end)

local autoPunchNoAnim = false
Killer:AddToggle("Auto Punch [No Animation]", function(state)
    autoPunchNoAnim = state

    while autoPunchNoAnim do
        local player = game.Players.LocalPlayer
        local playerName = player.Name
        local punchTool = player.Backpack:FindFirstChild("Punch") or game.Workspace:FindFirstChild(playerName):FindFirstChild("Punch")

        if punchTool then
            if punchTool.Parent ~= game.Workspace:FindFirstChild(playerName) then
                punchTool.Parent = game.Workspace:FindFirstChild(playerName)
            end

            player.muscleEvent:FireServer("punch", "rightHand")
            player.muscleEvent:FireServer("punch", "leftHand")
        else
            warn("Punch tool not found")
            autoPunchNoAnim = false
        end

        wait(0.01)
    end
end)

Killer:AddToggle("Auto Punch", function(Value)
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
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end)

Killer:AddToggle("Fast Punch", function(Value)
    _G.fastHitActive = Value
    if Value then
        local function equipAndModifyPunch()
            while _G.fastHitActive do
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                wait(0.1)
            end
        end

        local function fastPunchAction()
            while _G.fastHitActive do
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                wait(0.1)
            end
        end

        coroutine.wrap(equipAndModifyPunch)()
        coroutine.wrap(fastPunchAction)()
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end)

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

local Label = main:AddLabel("Statistics")
local statsDisplay = Tabs.Timer:CreateParagraph("Statistics", {
    Title = "Statistics",
    Content = "Tracking stats..."
})

task.spawn(function()
    while true do
        local currentRebirths = player.leaderstats.Rebirths.Value
        local rebirthsGained = currentRebirths - startRebirths
        local elapsedTime = os.time() - startTime

        local perMinute = rebirthsGained / (elapsedTime / 60)
        local perHour = perMinute * 60
        local perDay = perHour * 24

        local days = math.floor(elapsedTime / 86400)
        local hours = math.floor((elapsedTime % 86400) / 3600)
        local minutes = math.floor((elapsedTime % 3600) / 60)
        local seconds = elapsedTime % 60

        statsDisplay:SetContent(string.format([[
+--------- %s Stats ---------+

+----------------------------+
|        STATS OVERVIEW      |

   Rebirths       | %s
   Rebirth Gain   | %s
   
   Timer: %d D | %02d H | %02d M | %02d S

+----------------------------+
|        PROGRESS RATES      |

   Per Minute     | %s
   Per Hour       | %s
   Per Day        | %s

+----------------------------------------+]],
            displayName,
            formatNumber(currentRebirths) .. " (" .. formatLargeNumber(currentRebirths) .. ")",
            formatNumber(rebirthsGained) .. " (" .. formatLargeNumber(rebirthsGained) .. ")",
            days, hours, minutes, seconds,
            formatNumber(perMinute) .. " (" .. formatLargeNumber(perMinute) .. ")",
            formatNumber(perHour) .. " (" .. formatLargeNumber(perHour) .. ")",
            formatNumber(perDay) .. " (" .. formatLargeNumber(perDay) .. ")"
        ))
        task.wait(1)
    end
end)

local Teleport = window:CreateTab("Teleport")

Teleport:AddButton("Tiny Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-31.8626194, 6.0588026, 2087.88672)
end)

Teleport:AddButton("Starter Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226.252472, 8.1526947, 219.366516)
end)

Teleport:AddButton("Legend Beach", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-365.798309, 44.5082932, -501.618591)
end)

Teleport:AddButton("Frost Gym", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2933.47998, 29.6399612, -579.946045)
end)

Teleport:AddButton("Mythical Gym", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2659.50635, 21.6095238, 934.690613)
end)

Teleport:AddButton("Eternal Gym", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7176.19141, 45.394104, -1106.31421)
end)

Teleport:AddButton("Legend Gym", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4446.91699, 1004.46698, -3983.76074)
end)

Teleport:AddButton("Jungle Gym", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8137, 28, 2820)
end)

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local title = Instance.new("TextLabel", gui)
title.Active = true
title.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
title.Draggable = true
title.Position = UDim2.new(0.7, 0, 0.1, 0)
title.Size = UDim2.new(0, 370, 0, 52)
title.Font = Enum.Font.SourceSansSemibold
title.Text = "Anti Afk"
title.TextColor3 = Color3.new(0, 1, 1)
title.TextSize = 22

local frame = Instance.new("Frame", title)
frame.BackgroundColor3 = Color3.new(0.196, 0.196, 0.196)
frame.Position = UDim2.new(0, 0, 1.02, 0)
frame.Size = UDim2.new(0, 370, 0, 107)

local credit = Instance.new("TextLabel", frame)
credit.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
credit.Position = UDim2.new(0, 0, 0.8, 0)
credit.Size = UDim2.new(0, 370, 0, 21)
credit.Font = Enum.Font.Arial
credit.Text = "Made by luca#5432"
credit.TextColor3 = Color3.new(0, 1, 1)
credit.TextSize = 20

local status = Instance.new("TextLabel", frame)
status.BackgroundColor3 = Color3.new(0.176, 0.176, 0.176)
status.Position = UDim2.new(0, 0, 0.16, 0)
status.Size = UDim2.new(0, 370, 0, 44)
status.Font = Enum.Font.ArialBold
status.Text = "Status: Active"
status.TextColor3 = Color3.new(0, 1, 1)
status.TextSize = 20

Players.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
    status.Text = "Roblox tried kicking you but I stopped it!"
    task.wait(2)
    status.Text = "Status: Active"
end)
