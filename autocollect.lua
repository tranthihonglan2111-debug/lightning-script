-- ⚡ LightNing Auto Collect (Smooth Fly)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local ENABLED = false
local RANGE = 120 -- phạm vi quét (stud)
local SPEED = 80  -- tốc độ bay (càng cao càng nhanh)

-- ===== UI (Mobile-friendly) =====
local gui = Instance.new("ScreenGui", game.CoreGui)
local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.fromOffset(160, 48)
btn.Position = UDim2.new(0, 20, 0.6, 0)
btn.Text = "LightNing⚡ OFF"
btn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Active = true
btn.Draggable = true

btn.MouseButton1Click:Connect(function()
	ENABLED = not ENABLED
	btn.Text = ENABLED and "LightNing⚡ ON" or "LightNing⚡ OFF"
	btn.BackgroundColor3 = ENABLED and Color3.fromRGB(60, 180, 90) or Color3.fromRGB(220, 60, 60)
end)

-- ===== Helpers =====
local function isCollectible(obj)
	return obj:IsA("BasePart") and (
		obj:FindFirstChildWhichIsA("ProximityPrompt", true) or
		obj:FindFirstChildWhichIsA("ClickDetector", true)
	)
end

local function getNearest()
	local nearest, dist
	for _, d in ipairs(workspace:GetDescendants()) do
		if isCollectible(d) then
			local p = d.Position
			local d2 = (p - hrp.Position).Magnitude
			if d2 <= RANGE and (not dist or d2 < dist) then
				nearest, dist = d, d2
			end
		end
	end
	return nearest, dist
end

local flyingTween
local function flyTo(pos)
	if flyingTween then flyingTween:Cancel() end
	local t = (pos - hrp.Position).Magnitude / SPEED
	flyingTween = TweenService:Create(
		hrp,
		TweenInfo.new(math.clamp(t, 0.15, 1.2), Enum.EasingStyle.Linear),
		{CFrame = CFrame.new(pos)}
	)
	flyingTween:Play()
end

-- ===== Main Loop =====
task.spawn(function()
	while task.wait(0.25) do
		if not ENABLED or not char.Parent then continue end
		local target = getNearest()
		if target then
			flyTo(target.Position + Vector3.new(0, 1.5, 0))
		end
	end
end)
