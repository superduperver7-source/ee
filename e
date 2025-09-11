local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 25

local function getBasePart()
    local basePart
    while not basePart do
        basePart = workspace:FindFirstChild("BasePartName")
        RunService.Heartbeat:Wait()
    end
    return basePart
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 200, 0, 50)
flyButton.Position = UDim2.new(0, 20, 0, 20)
flyButton.Text = "Fly to Base"
flyButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
flyButton.TextColor3 = Color3.fromRGB(255,255,255)
flyButton.Parent = screenGui

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 200, 0, 50)
stopButton.Position = UDim2.new(0, 20, 0, 80)
stopButton.Text = "Stop Flying"
stopButton.BackgroundColor3 = Color3.fromRGB(150,50,50)
stopButton.TextColor3 = Color3.fromRGB(255,255,255)
stopButton.Parent = screenGui

local function flyToBase()
    local basePart = getBasePart()
    flying = true
    while flying and (humanoidRootPart.Position - basePart.Position).Magnitude > 1 do
        local direction = (basePart.Position - humanoidRootPart.Position).Unit
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position + direction * speed * RunService.Heartbeat:Wait(), basePart.Position)
        RunService.Heartbeat:Wait()
    end
    flying = false
end

flyButton.MouseButton1Click:Connect(flyToBase)
stopButton.MouseButton1Click:Connect(function()
    flying = false
end)
