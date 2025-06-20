--Created by @s-o-n-i-c-b-o-o-m on YT (n00nkk on github)
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "WalkSpeedGui"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

-- Main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 600)
frame.Position = UDim2.new(0.5, -200, 0.5, -300)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

-- Title text
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Walkspeed GUI - discord.gg/UEMJKyEVcw"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(1, -35, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 24
minimizeButton.Parent = titleBar

-- Scroll content
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 250*45)
scroll.ScrollBarThickness = 8
scroll.Parent = frame

-- List layout
local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)

-- Player character reference
local char = plr.Character or plr.CharacterAdded:Wait()
plr.CharacterAdded:Connect(function(c) char = c end)

-- Add buttons
for i = 1, 250 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromHSV(i / 250, 0.7, 0.7)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = "Set WalkSpeed to " .. tostring(i)
    btn.Parent = scroll
    btn.MouseButton1Click:Connect(function()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = i end
    end)
end

-- Update scroll size
scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)

-- Minimize/Maximize behavior
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    scroll.Visible = not isMinimized
    if isMinimized then
        frame.Size = UDim2.new(0, 400, 0, 60)
        minimizeButton.Text = "+"
    else
        frame.Size = UDim2.new(0, 400, 0, 600)
        minimizeButton.Text = "_"
    end
end)

-- Make draggable using title bar
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
