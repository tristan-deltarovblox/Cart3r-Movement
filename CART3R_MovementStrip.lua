-- CART3R Crimson Movement Strip
-- Roblox Studio LocalScript
-- Install in StarterPlayer > StarterPlayerScripts.
-- Intended for your own Roblox experience.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local DEFAULT_SPEED = 16
local DEFAULT_JUMP = 50
local MAX_SPEED = 500
local MAX_JUMP = 500

local speedValue = DEFAULT_SPEED
local jumpValue = DEFAULT_JUMP
local humanoid

local function applyMovement()
    if not humanoid or not humanoid.Parent then
        return
    end

    humanoid.WalkSpeed = speedValue
    humanoid.UseJumpPower = true
    humanoid.JumpPower = jumpValue
end

local function setupCharacter(character)
    humanoid = character:WaitForChild("Humanoid")
    applyMovement()
end

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
    task.spawn(setupCharacter, player.Character)
end

-- Remove an older copy if the script is run again in Studio.
local oldGui = playerGui:FindFirstChild("CART3RMovementStrip")
if oldGui then
    oldGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "CART3RMovementStrip"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Strip"
panel.AnchorPoint = Vector2.new(0.5, 0)
panel.Position = UDim2.new(0.5, 0, 0, 24)
panel.Size = UDim2.new(1, -24, 0, 104)
panel.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
panel.BorderSizePixel = 0
panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(235, 35, 58)
panelStroke.Thickness = 1.5
panelStroke.Parent = panel

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MaxSize = Vector2.new(620, 104)
sizeConstraint.MinSize = Vector2.new(260, 104)
sizeConstraint.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Position = UDim2.fromOffset(12, 5)
title.Size = UDim2.new(1, -58, 0, 20)
title.BackgroundTransparency = 1
title.Text = "CART3R  /  MOVEMENT"
title.TextColor3 = Color3.fromRGB(255, 65, 82)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Position = UDim2.new(1, -34, 0, 4)
minimizeButton.Size = UDim2.fromOffset(26, 24)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 20, 32)
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.Parent = panel

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

local controls = Instance.new("Frame")
controls.Name = "Controls"
controls.Position = UDim2.fromOffset(12, 29)
controls.Size = UDim2.new(1, -24, 0, 68)
controls.BackgroundTransparency = 1
controls.Parent = panel

local function makeSlider(name, y, minimum, maximum, initialValue, onChanged)
    local row = Instance.new("Frame")
    row.Name = name .. "Slider"
    row.Position = UDim2.fromOffset(0, y)
    row.Size = UDim2.new(1, 0, 0, 29)
    row.BackgroundTransparency = 1
    row.Parent = controls

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 112, 0, 18)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = Color3.fromRGB(245, 235, 238)
    valueLabel.Font = Enum.Font.GothamSemibold
    valueLabel.TextSize = 11
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.Parent = row

    local track = Instance.new("Frame")
    track.Name = "Track"
    track.Position = UDim2.new(0, 116, 0, 5)
    track.Size = UDim2.new(1, -116, 0, 10)
    track.BackgroundColor3 = Color3.fromRGB(54, 28, 34)
    track.BorderSizePixel = 0
    track.Parent = row

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.Size = UDim2.new((initialValue - minimum) / (maximum - minimum), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(245, 35, 62)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new((initialValue - minimum) / (maximum - minimum), 0, 0.5, 0)
    knob.Size = UDim2.fromOffset(16, 16)
    knob.BackgroundColor3 = Color3.fromRGB(255, 245, 247)
    knob.BorderSizePixel = 0
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local knobStroke = Instance.new("UIStroke")
    knobStroke.Color = Color3.fromRGB(245, 35, 62)
    knobStroke.Thickness = 2
    knobStroke.Parent = knob

    local hitbox = Instance.new("TextButton")
    hitbox.Name = "Input"
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.Size = UDim2.new(1, 0, 1, 12)
    hitbox.Position = UDim2.fromOffset(0, -6)
    hitbox.ZIndex = 5
    hitbox.Parent = track

    local currentValue = initialValue
    local dragging = false

    local function render(value)
        currentValue = math.clamp(math.floor(value + 0.5), minimum, maximum)
        local alpha = (currentValue - minimum) / (maximum - minimum)

        valueLabel.Text = string.upper(name) .. ": " .. tostring(currentValue)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)

        onChanged(currentValue)
    end

    local function updateFromScreenX(screenX)
        local width = track.AbsoluteSize.X
        if width <= 0 then
            return
        end

        local alpha = math.clamp(
            (screenX - track.AbsolutePosition.X) / width,
            0,
            1
        )

        render(minimum + alpha * (maximum - minimum))
    end

    hitbox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromScreenX(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            updateFromScreenX(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    render(initialValue)
end

makeSlider("Speed", 0, 0, MAX_SPEED, DEFAULT_SPEED, function(value)
    speedValue = value
    applyMovement()
end)

makeSlider("Jump", 34, 0, MAX_JUMP, DEFAULT_JUMP, function(value)
    jumpValue = value
    applyMovement()
end)

local minimized = false
minimizeButton.Activated:Connect(function()
    minimized = not minimized
    controls.Visible = not minimized
    panel.Size = minimized
        and UDim2.new(1, -24, 0, 32)
        or UDim2.new(1, -24, 0, 104)
    sizeConstraint.MinSize = minimized and Vector2.new(260, 32)
        or Vector2.new(260, 104)
    sizeConstraint.MaxSize = minimized and Vector2.new(620, 32)
        or Vector2.new(620, 104)
    minimizeButton.Text = minimized and "+" or "−"
end)

print("CART3R Movement Strip loaded.")
