-- LightNing⚡ Speed Controller

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local enabled = false
local speed = 10
local MIN_SPEED = 10
local MAX_SPEED = 1000

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LightNingSpeed"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(260, 190)
frame.Position = UDim2.fromScale(0.4, 0.4)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "LightNing⚡ Speed by Phúc 7/2"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1,0,0,30)
speedLabel.Position = UDim2.fromOffset(0,40)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 10"
speedLabel.TextColor3 = Color3.new(1,1,1)
speedLabel.TextSize = 16

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.fromOffset(180, 35)
toggle.Position = UDim2.fromOffset(40, 80)
toggle.Text = "OFF"
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 16
toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
toggle.TextColor3 = Color3.new(1,1,1)

local addBtn = Instance.new("TextButton", frame)
addBtn.Size = UDim2.fromOffset(180, 35)
addBtn.Position = UDim2.fromOffset(40, 125)
addBtn.Text = "+10 Speed"
addBtn.Font = Enum.Font.SourceSansBold
addBtn.TextSize = 16
addBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
addBtn.TextColor3 = Color3.new(1,1,1)

-- Utils
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

-- Loop giữ speed (chống server reset nhẹ)
RunService.Heartbeat:Connect(function()
	if not enabled then return end
	local hum = getHumanoid()
	if hum.WalkSpeed ~= speed then
		hum.WalkSpeed = speed
	end
end)

-- Toggle
toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		toggle.Text = "Bật rôi ní"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
		getHumanoid().WalkSpeed = speed
	else
		toggle.Text = "Tắt nè"
		toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
		getHumanoid().WalkSpeed = 16 -- speed mặc định Roblox
	end
end)

-- Tăng speed
addBtn.MouseButton1Click:Connect(function()
	speed = math.clamp(speed + 10, MIN_SPEED, MAX_SPEED)
	speedLabel.Text = "Speed: "..speed
	if enabled then
		getHumanoid().WalkSpeed = speed
	end
end)

-- Reset sau khi chết
player.CharacterAdded:Connect(function()
	if enabled then
		task.wait(0.3)
		getHumanoid().WalkSpeed = speed
	end
end)
