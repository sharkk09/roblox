local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "BERLIN V2",
    Footer = "Scripted by ivan, ii_shark on dc",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true,
})

local Players = game:GetService("Players")
local groupId = 32447797

-- notify when admin joins
Players.PlayerAdded:Connect(function(player)
    if player:IsInGroup(groupId) then
        Library:Notify({
            Title = "Admin Joined",
            Description = player.Name .. " !WARNING! admin joined",
            Time = 5,
            SoundId = 1570162306
        })
    end
end)

-- notify when admin leaves

-- Notify when a group member leaves
Players.PlayerRemoving:Connect(function(player)
    if player:IsInGroup(groupId) then
        Library:Notify({
            Title = "Admin Left",
            Description = player.Name .. " admin left",
            Time = 5,
            SoundId = 1570162306
        })
    end
end)


local mainTab = Window:AddTab("Main", "house")
local mainBox = mainTab:AddLeftGroupbox("Spawn Gamepass Cars")

local oldtimersDropdown = mainBox:AddDropdown("Oldtimer Cars", {
    Values = {"1982 BMW Oldtimer", "1975 Porsche 911 Oldtimer"},
    Default = 1, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Oldtimers",
    Tooltip = "Select a car and it will spawn.",
    Callback = function(Value)
        local args = {
    [1] = game:GetService("ReplicatedStorage"):WaitForChild("Cars", 9000000000):WaitForChild("Citizen", 9000000000):WaitForChild(Value, 9000000000);
    [2] = workspace:WaitForChild("CarSpawner", 9000000000):GetChildren()[12];
}

    game:GetService("ReplicatedStorage"):WaitForChild("CarSpawner", 9000000000):WaitForChild("SpawnCar", 9000000000):FireServer(unpack(args))
    end
})

local japaneseDropdown = mainBox:AddDropdown("Japanese Cars", {
    Values = {"2017 Nissan R35 Japanese"},
    Default = 1, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Japanese Cars",
    Tooltip = "Select a car and it will spawn.",
    Callback = function(Value)
        local args = {
    [1] = game:GetService("ReplicatedStorage"):WaitForChild("Cars", 9000000000):WaitForChild("Citizen", 9000000000):WaitForChild(Value, 9000000000);
    [2] = workspace:WaitForChild("CarSpawner", 9000000000):GetChildren()[12];
}

    game:GetService("ReplicatedStorage"):WaitForChild("CarSpawner", 9000000000):WaitForChild("SpawnCar", 9000000000):FireServer(unpack(args))
    end
})


local sportsCar = mainBox:AddDropdown("Sports Cars", {
    Values = {"2020 Ferrari 812 Sport", "2021 Porsche GT3 Sport"},
    Default = 1, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Sports Car",
    Tooltip = "Select a car and it will spawn.",
    Callback = function(Value)
        local args = {
    [1] = game:GetService("ReplicatedStorage"):WaitForChild("Cars", 9000000000):WaitForChild("Citizen", 9000000000):WaitForChild(Value, 9000000000);
    [2] = workspace:WaitForChild("CarSpawner", 9000000000):GetChildren()[12];
}

    game:GetService("ReplicatedStorage"):WaitForChild("CarSpawner", 9000000000):WaitForChild("SpawnCar", 9000000000):FireServer(unpack(args))
    end
})

local luxuryCar = mainBox:AddDropdown("Luxury Cars", {
    Values = {"Bentley Luxury", "2020  Urus Luxury"},
    Default = 1, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Luxury Cars",
    Tooltip = "Select a car and it will spawn.",
    Callback = function(Value)
        local args = {
    [1] = game:GetService("ReplicatedStorage"):WaitForChild("Cars", 9000000000):WaitForChild("Citizen", 9000000000):WaitForChild(Value, 9000000000);
    [2] = workspace:WaitForChild("CarSpawner", 9000000000):GetChildren()[12];
}

    game:GetService("ReplicatedStorage"):WaitForChild("CarSpawner", 9000000000):WaitForChild("SpawnCar", 9000000000):FireServer(unpack(args))
    end
})


local carTab = Window:AddTab("Car Tune", "car")
local carTabTuneBox = carTab:AddLeftGroupbox("Tune")

-----------
-- Add speed multiplier slider
local carSlider = carTabTuneBox:AddSlider("Speed Multiplier", {
    Text = "Speed Multiplier",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        speed = Value
        print("Slider changed to:", speed)
    end
})



-- Add toggle checkbox
local carCheckbox = carTabTuneBox:AddCheckbox("Toggle Speed Multiplier", {
    Text = "Toggle Speed Multiplier",
    Default = false,
    Callback = function(Value)
        on = Value
        print("Checkbox changed to:", on)
    end
})

local WrappedLabel = carTabTuneBox:AddLabel({
    Text = "This doesn't work on gamepass cars.",
    DoesWrap = true
})

-- Metatable override to scale AV and maxTorque
local met = getrawmetatable(game)
setreadonly(met, false)
local old = met.__newindex

met.__newindex = function(t, k, v)
    if tostring(t) == "#AV" then
        if not on then return old(t, k, v) end
        if k == "angularvelocity" or k == "maxTorque" then
            return old(t, k, Vector3.new(v.X * speed, v.Y * speed, v.Z * speed))
        end
    end
    return old(t, k, v)
end
------------

--MISC
local miscTab = Window:AddTab("Misc", "settings")
local bypassGroupbox = miscTab:AddLeftGroupbox("Bypass")
local otherGroupbox = miscTab:AddRightGroupbox("Other")

-- Bypass groupbox
local acButton = bypassGroupbox:AddButton({
    Text = "Bypass Anticheat",
    Func = function()
        local eventbypass

eventbypass = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() and self.Name == "SendExploiterData" and method == "FireServer" then
        print("SHARK'S AC BYPASS : (SendExploiterData)")
        return wait(9000000000);
    end

    return eventbypass(self, ...)
end)
Library:Notify("AC Bypassed", 5)
    end,
    DoubleClick = false
})

local logButton = bypassGroupbox:AddButton({
    Text = "Bypass SendLogUI",
    Func = function()
        local eventbypass

eventbypass = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() and self.Name == "SendLogUI" and method == "FireServer" then
        print("SHARK'S AC BYPASS : (SendLogUI)")
        return wait(9000000000);
    end

    return eventbypass(self, ...)
end)
Library:Notify("SendLogUI Bypassed", 5)
    end,
    DoubleClick = false
})

--Other  groupbox
local staffCheckbox = otherGroupbox:AddCheckbox("Staff Panel", {
    Text = "Staff Panel",
    Default = false,
    Callback = function(Value)
        local modUi = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ModUi")
		modUi.Enabled = Value
    end
})

local yieldButton = otherGroupbox:AddButton({
    Text = "Infinite Yield",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
    DoubleClick = false
})



local callTab = Window:AddTab("Remote", "phone")
local callGroup = callTab:AddLeftGroupbox("Notruf")

-- Initialize variables
-- Initialize variables
local reason = ""
local feuerwehr = false
local polizei = false
local rettungsdienst = false
local adac = false

-- Grund (Reason) input box
local reasonBox = callGroup:AddInput("ReasonBox", {
    Text = "Grund",
    Default = "",
    Placeholder = "z.B. Verkehrsunfall",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        reason = Value
        print("Grund gesetzt auf:", reason)
    end
})

-- Checkboxes für die Einsatzkräfte
local feuerwehrCheckbox = callGroup:AddCheckbox("Feuerwehr", {
    Text = "Feuerwehr",
    Default = false,
    Callback = function(Value)
        feuerwehr = Value
        print("Feuerwehr ausgewählt:", feuerwehr)
    end
})

local polizeiCheckbox = callGroup:AddCheckbox("Polizei", {
    Text = "Polizei",
    Default = false,
    Callback = function(Value)
        polizei = Value
        print("Polizei ausgewählt:", polizei)
    end
})

local rettungsdienstCheckbox = callGroup:AddCheckbox("Rettungsdienst", {
    Text = "Rettungsdienst",
    Default = false,
    Callback = function(Value)
        rettungsdienst = Value
        print("Rettungsdienst ausgewählt:", rettungsdienst)
    end
})

local adacCheckbox = callGroup:AddCheckbox("ADAC", {
    Text = "ADAC",
    Default = false,
    Callback = function(Value)
        adac = Value
        print("ADAC ausgewählt:", adac)
    end
})

-- Send Notruf button
callGroup:AddButton({
    Text = "Send Notruf",
    Func = function()
        -- Falls callback nicht getriggert wurde
        reason = reasonBox.Value or ""

        if reason == nil or reason == "" then
            Library:Notify("Bitte gib einen Grund ein!", 3)
            return
        end

        -- Argumente vorbereiten
        local args = {
            [1] = reason;                                           -- Grund
            [2] = Vector3.new(1028.6512451171875, 7.176443099975586, 1731.07177734375); -- Position
            [3] = "12";                                             -- ID oder anderer Parameter
            [4] = feuerwehr;                                        -- Feuerwehr
            [5] = polizei;                                          -- Polizei
            [6] = rettungsdienst;                                   -- Rettungsdienst
            [7] = adac;                                             -- ADAC
        }

        -- Event feuern
        game:GetService("ReplicatedStorage")
            :WaitForChild("Emergency", 9000000000)
            :WaitForChild("EM", 9000000000)
            :FireServer(unpack(args))

        -- Bestätigung
        Library:Notify("🚨 Notruf gesendet: " .. reason, 3)
    end,
    DoubleClick = false
})

Library.ShowCustomCursor = false

--  Setup
local teams = {
    "ADAC",
    "Autobahnamt",
    "LKA",
    "Citizen",
    "Feuerwehr",
    "Polizei",
    "Rettungsdienst",
    "SEK",
    "Zoll",
    "Mafia",
    "BVE",
    "Policja",
    "Bundespolizei"
}

local selectedTeam = "Citizen"

--  Tab hinzufügen
local teamTab = Window:AddTab("Team", "users")


--  Groupbox im Tab
local teamGroup = teamTab:AddLeftGroupbox("Team Auswahl")

--  Dropdown-Menü für Team-Auswahl
local teamDropdown = teamGroup:AddDropdown("TeamDropdown", {
    Text = "Team wechseln",
    Values = teams,
    Default = "Citizen",
    Multi = false,
    Callback = function(Value)
        selectedTeam = Value
        print("Team ausgewählt:", selectedTeam)
    end
})

--  Button: Team wechseln
teamGroup:AddButton({
    Text = "Team wechseln",
    Func = function()
        if not selectedTeam or selectedTeam == "" then
            Library:Notify("⚠️ Bitte wähle zuerst ein Team!", 3)
            return
        end

        Library:Notify("🔄 Wechsle Team zu: " .. selectedTeam, 3)

        --Charakter neu laden
        local args1 = {}
        game:GetService("ReplicatedStorage")
            :WaitForChild("ReloadCharacter", 9000000000)
            :FireServer(unpack(args1))

        task.wait()

        -- Team setzen
        local args2 = { [1] = selectedTeam }
        game:GetService("ReplicatedStorage")
            :WaitForChild("SetPlayerTeam", 9000000000)
            :FireServer(unpack(args2))

        task.wait()

        -- Collapse ausführen
        local args3 = {}
        game:GetService("ReplicatedStorage")
            :WaitForChild("ACS_Engine", 9000000000)
            :WaitForChild("Events", 9000000000)
            :WaitForChild("MedSys", 9000000000)
            :WaitForChild("Collapse", 9000000000)
            :FireServer(unpack(args3))

        -- Bestätigung
        Library:Notify("✅ Team erfolgreich gewechselt zu " .. selectedTeam, 3)
    end,
    DoubleClick = false
})

-- Tab erstellen
local musicTab = Window:AddTab({
    Name = "Musik",
    Icon = "music"
})

local LeftTabBox = musicTab:AddLeftTabbox("Left Tabbox")
local AudioGroupbox = LeftTabBox:AddTab("Audio Controls")

-- Variablen
local musicID = "" -- nur die reine ID
local pitch = 1
local volume = 100

-- Funktion, um das Auto des Spielers zu finden
local function getPlayerCar()
    local playerName = game.Players.LocalPlayer.Name
    local autosFolder = workspace:WaitForChild("Autos", 9000000000)
    for _, car in pairs(autosFolder:GetChildren()) do
        if car.Name:find(playerName) then
            return car
        end
    end
    return nil
end

-- Funktion: fügt automatisch "rbxassetid://" hinzu, falls nötig
local function formatMusicID(id)
    id = tostring(id)
    if not id:find("rbxassetid://") then
        id = "rbxassetid://" .. id
    end
    return id
end

-- Inputs
AudioGroupbox:AddInput("MusicIDInput", {
    Text = "Musik ID",
    Default = musicID,
    Placeholder = "ID",
    Callback = function(value)
        musicID = value
    end
})

AudioGroupbox:AddInput("PitchInput", {
    Text = "Pitch",
    Default = tostring(pitch),
    Placeholder = "1",
    Numeric = true,
    Callback = function(value)
        pitch = tonumber(value) or 1
    end
})

AudioGroupbox:AddInput("VolumeInput", {
    Text = "Volume",
    Default = tostring(volume),
    Placeholder = "1000000000",
    Numeric = true,
    Callback = function(value)
        volume = tonumber(value) or 1000000000
    end
})

-- Play Audio Button (unendliche Schleife)
AudioGroupbox:AddButton({
    Text = "Play Audio",
    Func = function()
        task.spawn(function()
            local playerCar = getPlayerCar()
            if not playerCar then
                warn("Kein Auto für "..game.Players.LocalPlayer.Name.." gefunden!")
                return
            end

            local carSounds = playerCar:WaitForChild("AC6_FE_Sounds", 9000000000)

            while true do
                local args = {
                    [1] = "updateSound",
                    [2] = "Rev",
                    [3] = formatMusicID(musicID), -- automatisch rbxassetid:// davor
                    [4] = pitch,
                    [5] = volume
                }
                carSounds:FireServer(unpack(args))
                task.wait()
            end
        end)
    end
})

-- Stop Audio Button (löscht Auto)
AudioGroupbox:AddButton({
    Text = "Stop Audio (Delete Car)",
    Func = function()
        local delCarEvent = game:GetService("ReplicatedStorage"):WaitForChild("DelCar", 9000000000)
        delCarEvent:FireServer()
        print("Auto gelöscht!")
    end
})