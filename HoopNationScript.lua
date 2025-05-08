local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()

local correctKey = "LacyIsThegood"
local keyEntered = false

local keySystem = library.new("?Jacy - Key System", 5013109572)
local keyPage = keySystem:addPage("Key", 5012544693)
local keySection = keyPage:addSection("Enter Key")

local keyMinimized = false
local keyMinimizeButton = keySection:addButton("Minimize UI", function()
    keyMinimized = not keyMinimized
    if keyMinimized then
        for _, page in pairs(keySystem.pages) do
            page.container.Visible = false
        end
        keySystem.title.Size = UDim2.new(0, 220, 0, 30)
        keySystem.title.ZIndex = 15
        keyMinimizeButton:Text("Restore UI")
    else
        for _, page in pairs(keySystem.pages) do
            page.container.Visible = true
        end
        keySystem.title.Size = UDim2.new(1, 0, 0, 30)
        keySystem.title.ZIndex = 3
        keyMinimizeButton:Text("Minimize UI")
    end
end)

keySection:addKeybind("Toggle Key UI Visibility", Enum.KeyCode.RightShift, function()
    keySystem:toggle()
end)

local keyOriginalSize = nil

keySection:addButton("Minimize Key UI", function()
    keyMinimized = not keyMinimized
    
    if keyMinimized then
        keyOriginalSize = keySystem.container.Size
        
        for _, page in pairs(keySystem.pages) do
            if page.container then
                page.container.Visible = false
            end
        end
        
        keySystem.container.Size = UDim2.new(0, 200, 0, 30)
        
        keySection:updateButton("Minimize Key UI", "Restore Key UI")
        
        keySystem:Notify("UI Minimized", "Click 'Restore Key UI' to expand")
    else
        for _, page in pairs(keySystem.pages) do
            if page.container then
                page.container.Visible = true
            end
        end
        
        if keyOriginalSize then
            keySystem.container.Size = keyOriginalSize
        end
        
        keySection:updateButton("Restore Key UI", "Minimize Key UI")
        
        keySystem:Notify("UI Restored", "Key UI has been expanded")
    end
end)

local enteredKey = ""
keySection:addTextbox("Key", "", function(value, focusLost)
    enteredKey = value
    if focusLost then
        if enteredKey == correctKey then
            keyEntered = true
            keySystem:toggle()
            wait(0.5)
            loadMainGUI()
        else
            keySystem:Notify("Error", "Invalid key entered.")
        end
    end
end)

keySection:addButton("Submit", function()
    if enteredKey == correctKey then
        keyEntered = true
        keySystem:toggle()
        wait(0.5)
        loadMainGUI()
    else
        keySystem:Notify("Error", "Invalid key entered.")
    end
end)

keySystem:SelectPage(keySystem.pages[1], true)

function loadMainGUI()
    local venyx = library.new("?Jacy", 5013109572)
    
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local themes = {
        Background = Color3.fromRGB(24, 24, 24),
        Glow = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(10, 10, 10),
        LightContrast = Color3.fromRGB(20, 20, 20),
        DarkContrast = Color3.fromRGB(14, 14, 14),  
        TextColor = Color3.fromRGB(255, 255, 255)
    }

    local function ApplyGlitchEffect()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then return end
        
        if math.random(1, 10) <= 3 then return end
        
        local intensity = _G.GlitchIntensity or 3
        local maxOffset = 0.4 * intensity
        
        coroutine.wrap(function()
            local originalCFrame = character.HumanoidRootPart.CFrame
            
            if _G.EnhancedGlitchMode then
                local offset = Vector3.new(
                    math.random(-maxOffset, maxOffset),
                    math.random(-maxOffset/2, maxOffset/2),
                    math.random(-maxOffset, maxOffset)
                )
                
                character.HumanoidRootPart.CFrame = originalCFrame + offset
                
                wait(0.03)
                
                character.HumanoidRootPart.CFrame = originalCFrame
            end
        end)()
    end

    local function ApplyRandomSpin()
        if not _G.Spin360Enabled then return end
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        coroutine.wrap(function()
            local root = character.HumanoidRootPart
            local originalCFrame = root.CFrame
            
            local targetAngle = math.random(90, 360)
            if math.random(0, 1) == 0 then targetAngle = -targetAngle end
            targetAngle = math.rad(targetAngle)
            
            local duration = 0.3
            local steps = 15
            local anglePerStep = targetAngle / steps
            
            for i = 1, steps do
                root.CFrame = root.CFrame * CFrame.Angles(0, anglePerStep, 0)
                game:GetService("RunService").Heartbeat:Wait()
            end
        end)()
    end

    local mainPage = venyx:addPage("Main", 5012544693)
    local mainSection = mainPage:addSection("Useful")

    mainSection:addToggle("Auto Timer ( Q or Shoot Button)", false, function(value)
        _G.ShootingEnabled = value

        if value then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kosta5630/Hoop-Nation/refs/heads/main/Auto%20time%20q"))()
        end
    end)

    mainSection:addToggle("Instant Shoot ( Legit )", false, function(value)
        _G.ShootingEnabled = value

        if value then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/kosta5630/Hoop-Nation/refs/heads/main/Instant%20Shoot"))()
        end
    end)

    local controlsSection = mainPage:addSection("UI Controls")

    local isMinimized = false
    local originalSize = nil

    controlsSection:addButton("Minimize UI", function()
        isMinimized = not isMinimized
        
        if isMinimized then
            originalSize = venyx.container.Size
            
            for _, page in pairs(venyx.pages) do
                if page.container then
                    page.container.Visible = false
                end
            end
            
            venyx.container.Size = UDim2.new(0, 200, 0, 30)
            
            controlsSection:updateButton("Minimize UI", "Restore UI")
            
            venyx:Notify("UI Minimized", "Click 'Restore UI' to expand")
        else
            for _, page in pairs(venyx.pages) do
                if page.container then
                    page.container.Visible = true
                end
            end
            
            if originalSize then
                venyx.container.Size = originalSize
            end
            
            controlsSection:updateButton("Restore UI", "Minimize UI")
            
            venyx:Notify("UI Restored", "UI has been expanded")
        end
    end)

    controlsSection:addKeybind("Toggle UI Visibility", Enum.KeyCode.RightControl, function()
        venyx:toggle()
    end)

    local sweatPage = venyx:addPage("Sweat", 5012544693)
    local sweatSection = sweatPage:addSection("Advanced Techniques")

    local DribbleKeybinds = {
        Move1 = {First = Enum.KeyCode.Z, Second = Enum.KeyCode.Z},
        Move2 = {First = Enum.KeyCode.C, Second = Enum.KeyCode.C},
        Move3 = {First = Enum.KeyCode.X, Second = Enum.KeyCode.X},
        Move4 = {First = Enum.KeyCode.Z, Second = Enum.KeyCode.X},
        Move5 = {First = Enum.KeyCode.C, Second = Enum.KeyCode.X}
    }

    local AllowedKeybinds = {
        Enum.KeyCode.Z,
        Enum.KeyCode.X,
        Enum.KeyCode.C,
        Enum.KeyCode.V,
        Enum.KeyCode.N,
        Enum.KeyCode.H,
        Enum.KeyCode.F
    }

    local function IsAllowedKeybind(keybind)
        for _, allowedKey in ipairs(AllowedKeybinds) do
            if keybind == allowedKey then
                return true
            end
        end
        return false
    end

    local DribbleMoves = {
        Move1 = function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Dribble = ReplicatedStorage.Events.Dribble
            local velocityX = math.random(-15, 15)
            local velocityY = math.random(-5, 5)
            local velocityZ = math.random(-15, 15)
            Dribble:FireServer(
                {DribbleKeybinds.Move1.First, DribbleKeybinds.Move1.Second},
                velocityX, velocityY, velocityZ
            )
            ApplyGlitchEffect()
            ApplyRandomSpin()
        end,
        
        Move2 = function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Dribble = ReplicatedStorage.Events.Dribble
            local velocityX = math.random(-20, 20)
            local velocityY = math.random(-3, 3)
            local velocityZ = math.random(-20, 20)
            Dribble:FireServer(
                {DribbleKeybinds.Move2.First, DribbleKeybinds.Move2.Second},
                velocityX, velocityY, velocityZ
            )
            ApplyGlitchEffect()
            ApplyRandomSpin()
        end,
        
        Move3 = function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Dribble = ReplicatedStorage.Events.Dribble
            local velocityX = math.random(-25, 25)
            local velocityY = math.random(-4, 4)
            local velocityZ = math.random(-25, 25)
            Dribble:FireServer(
                {DribbleKeybinds.Move3.First, DribbleKeybinds.Move3.Second},
                velocityX, velocityY, velocityZ
            )
            ApplyGlitchEffect()
            ApplyRandomSpin()
        end,
        
        Move4 = function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Dribble = ReplicatedStorage.Events.Dribble
            local velocityX = math.random(-18, 18)
            local velocityY = math.random(-6, 6)
            local velocityZ = math.random(-18, 18)
            Dribble:FireServer(
                {DribbleKeybinds.Move4.First, DribbleKeybinds.Move4.Second},
                velocityX, velocityY, velocityZ
            )
            ApplyGlitchEffect()
            ApplyRandomSpin()
        end,
        
        Move5 = function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Dribble = ReplicatedStorage.Events.Dribble
            local velocityX = math.random(-22, 22)
            local velocityY = math.random(-5, 5)
            local velocityZ = math.random(-22, 22)
            Dribble:FireServer(
                {DribbleKeybinds.Move5.First, DribbleKeybinds.Move5.Second},
                velocityX, velocityY, velocityZ
            )
            ApplyGlitchEffect()
            ApplyRandomSpin()
        end
    }

    local Combos = {
        Combo1 = {
            Moves = {"Move5", "Move1", "Move3", "Move2"},
            Key = Enum.KeyCode.One,
            Enabled = false,
            Name = "Ankle Breaker Pro"
        },
        Combo2 = {
            Moves = {"Move2", "Move4", "Move2", "Move1", "Move3"},
            Key = Enum.KeyCode.Two,
            Enabled = false,
            Name = "Speed Demon"
        },
        Combo3 = {
            Moves = {"Move5", "Move1", "Move5", "Move4", "Move3", "Move2"},
            Key = Enum.KeyCode.Three,
            Enabled = false,
            Name = "Ultimate Dribbler"
        },
        ComboQ = {
            Moves = {"Move1", "Move5", "Move2", "Move4", "Move3", "Move1"},
            Key = Enum.KeyCode.V,
            Enabled = true,
            Name = "V Glitch Combo"
        }
    }

    _G.ComboSystemEnabled = true
    local ComboDelayTime = 0.2
    local IsComboExecuting = false

    local function GenerateRandomCombo(comboName, keyCode)
        local availableMoves = {"Move1", "Move2", "Move3", "Move4", "Move5"}
        local moves = {}
        local moveCount = math.random(4, 6)
        
        table.insert(moves, availableMoves[math.random(1, 5)])
        
        for i = 2, moveCount do
            local lastMove = moves[i-1]
            local moveOptions = {}
            local moveAdded = false
            
            for _, move in ipairs(availableMoves) do
                if move ~= lastMove then
                    table.insert(moveOptions, move)
                end
            end
            
            if i == moveCount then
                local finishers = {"Move5", "Move3"}
                for _, finisher in ipairs(finishers) do
                    if finisher ~= lastMove then
                        table.insert(moves, finisher)
                        moveAdded = true
                        break
                    end
                end
            end
            
            if not moveAdded then
                local moveIndex = math.random(1, #moveOptions)
                table.insert(moves, moveOptions[moveIndex])
            end
        end
        
        return {
            Moves = moves,
            Key = keyCode,
            Enabled = true,
            Name = comboName
        }
    end

    local function ExecuteCombo(combo)
        if not combo.Enabled or IsComboExecuting then return end
        
        IsComboExecuting = true
        
        coroutine.wrap(function()
            local moveOrder = {}
            
            for _, move in ipairs(combo.Moves) do
                table.insert(moveOrder, move)
            end
            
            for i, moveName in ipairs(moveOrder) do
                if DribbleMoves[moveName] then
                    DribbleMoves[moveName]()
                    
                    local delayVariation = math.random(-10, 10) / 100
                    wait(ComboDelayTime + delayVariation)
                    
                    if i % 2 == 0 then
                        ApplyGlitchEffect()
                    end
                end
            end
            
            if combo.Key == Enum.KeyCode.V then
                Combos.ComboQ = GenerateRandomCombo("V Glitch Combo", Enum.KeyCode.V)
            elseif combo.Key == Enum.KeyCode.One then
                Combos.Combo1 = GenerateRandomCombo("Ankle Breaker Pro", Enum.KeyCode.One)
            elseif combo.Key == Enum.KeyCode.Two then
                Combos.Combo2 = GenerateRandomCombo("Speed Demon", Enum.KeyCode.Two)
            elseif combo.Key == Enum.KeyCode.Three then
                Combos.Combo3 = GenerateRandomCombo("Ultimate Dribbler", Enum.KeyCode.Three)
            end
            
            IsComboExecuting = false
        end)()
    end

    local function SetupComboSystem()
        if _G.InputConnection then
            _G.InputConnection:Disconnect()
        end
        
        if _G.ComboSystemEnabled then
            _G.InputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                
                if input.UserInputType ~= Enum.UserInputType.Keyboard then
                    return
                end
                
                for comboId, combo in pairs(Combos) do
                    if combo.Enabled and input.KeyCode == combo.Key then
                        print("Detected combo key: " .. combo.Key.Name .. " for " .. combo.Name)
                        ExecuteCombo(combo)
                        return
                    end
                end
                
                print("Key pressed: " .. tostring(input.KeyCode.Name))
            end)
            
            venyx:Notify("System Active", "Combo System Enabled - Keybind detection is now active")
        end
    end

    SetupComboSystem()

    sweatSection:addToggle("Enable Combo System", true, function(value)
        _G.ComboSystemEnabled = value
        SetupComboSystem()
        
        if value then
            venyx:Notify("Combo System", "Enabled")
        else
            venyx:Notify("Combo System", "Disabled")
        end
    end)

    local comboSetupSection = sweatPage:addSection("Combo Setup")

    comboSetupSection:addSlider("Combo Move Delay", 0.2, 0.1, 1, function(value)
        ComboDelayTime = value
    end)

    comboSetupSection:addToggle("Ankle Breaker Pro", Combos.Combo1.Enabled, function(value)
        Combos.Combo1.Enabled = value
    end)

    comboSetupSection:addToggle("Speed Demon", Combos.Combo2.Enabled, function(value)
        Combos.Combo2.Enabled = value
    end)

    comboSetupSection:addToggle("Ultimate Dribbler", Combos.Combo3.Enabled, function(value)
        Combos.Combo3.Enabled = value
    end)

    comboSetupSection:addToggle("V Glitch Combo", Combos.ComboQ.Enabled, function(value)
        Combos.ComboQ.Enabled = value
    end)

    local individualMovesSection = sweatPage:addSection("Individual Dribble Moves")

    individualMovesSection:addButton("Dribble Move 1 (Z+Z)", function()
        DribbleMoves.Move1()
    end)

    individualMovesSection:addButton("Dribble Move 2 (C+C)", function()
        DribbleMoves.Move2()
    end)

    individualMovesSection:addButton("Dribble Move 3 (X+X)", function()
        DribbleMoves.Move3()
    end)

    individualMovesSection:addButton("Dribble Move 4 (Z+X)", function()
        DribbleMoves.Move4()
    end)

    individualMovesSection:addButton("Dribble Move 5 (C+X)", function()
        DribbleMoves.Move5()
    end)

    individualMovesSection:addButton("Test All Dribble Moves", function()
        coroutine.wrap(function()
            DribbleMoves.Move1()
            wait(0.7)
            DribbleMoves.Move2()
            wait(0.7)
            DribbleMoves.Move3()
            wait(0.7)
            DribbleMoves.Move4()
            wait(0.7)
            DribbleMoves.Move5()
            
            venyx:Notify("Test Complete", "All dribble moves executed with current keybinds")
        end)()
    end)

    individualMovesSection:addButton("Reset All Keybinds to Default", function()
        DribbleKeybinds.Move1 = {First = Enum.KeyCode.Z, Second = Enum.KeyCode.Z}
        DribbleKeybinds.Move2 = {First = Enum.KeyCode.C, Second = Enum.KeyCode.C}
        DribbleKeybinds.Move3 = {First = Enum.KeyCode.X, Second = Enum.KeyCode.X}
        DribbleKeybinds.Move4 = {First = Enum.KeyCode.Z, Second = Enum.KeyCode.X}
        DribbleKeybinds.Move5 = {First = Enum.KeyCode.C, Second = Enum.KeyCode.X}
        
        venyx:Notify("Keybinds Reset", "All dribble move keybinds have been reset to default")
    end)

    local directKeybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.V then
            for _, combo in pairs(Combos) do
                if combo.Name == "V Glitch Combo" and combo.Enabled then
                    print("Direct V key handler for V Glitch Combo")
                    ExecuteCombo(combo)
                    return
                end
            end
        end
    end)

    local glitchSettingsSection = sweatPage:addSection("Glitch Effect Settings")

    glitchSettingsSection:addToggle("Enhanced Glitch Mode", true, function(value)
        _G.EnhancedGlitchMode = value
        
        if value then
            venyx:Notify("Glitch Mode", "Enhanced Glitch Mode Activated")
        end
    end)

    glitchSettingsSection:addToggle("Enable 360 Spin Dribble", false, function(value)
        _G.Spin360Enabled = value
        
        if value then
            venyx:Notify("Spin Mode", "360 Spin Dribble Enabled")
        end
    end)

    glitchSettingsSection:addSlider("Glitch Intensity", 3, 1, 5, function(value)
        _G.GlitchIntensity = value
    end)

    individualMovesSection:addTextbox("Allowed Keys", "Z, X, C, V, N, H, F", function(value, focusLost)
    end)

    local theme = venyx:addPage("Theme", 5012544693)
    local colors = theme:addSection("Colors")

    for theme, color in pairs(themes) do
        colors:addColorPicker(theme, color, function(color3)
            venyx:setTheme(theme, color3)
        end)
    end

    _G.EnhancedGlitchMode = true
    _G.GlitchIntensity = 3
    _G.Spin360Enabled = false

    venyx:SelectPage(venyx.pages[1], true)
end

keySystem:Notify("Key System", "Please enter the key to proceed", 5)

local version = {
    major = 1,
    minor = 0,
    patch = 0,
    display = function(self)
        return string.format("v%d.%d.%d", self.major, self.minor, self.patch)
    end
}

print("?Jacy Hub " .. version:display() .. " loaded successfully!")
print("Created by Amhim123hd | https://github.com/Amhim123hd")
