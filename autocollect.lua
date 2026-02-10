-- ⚡ LightNing Auto Collect FIX (Fly + Collect + Respawn Safe)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer

local ENABLED = false
local RANGE = 200
local SPEED = 90

local char, hrp
local startCFrame
local currentTween

-- ===== Character Reload =====
local function loadChar()
	char = player.Character or player.CharacterAdded:Wait()
	hrp = char:WaitForChild("HumanoidRootPart")
end
loadChar()

player.CharacterAdded:Connect(function()
	task.wait(0.5)
	loadChar()
end)

-- ===== UI =====
local gui = Instance.new("ScreenGui")
gui.Name = "LightNingUI"
gui.Parent = game.CoreGui

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.fromOffset(180, 50)
btn.Position = UDim2.new(0, 20, 0.6, 0)
btn.Text = "LightNing⚡ OFF"
btn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
btn.Active = true
btn.Draggable = true

-- ===== Helpers =====
local function tweenTo(cf)
	if not hrp then return end
	if currentTween then currentTween:Cancel() end

	local dist = (hrp.Position - cf.Position).Magnitude
	local time = math.clamp(dist / SPEED, 0.2, 1.5)

	currentTween = TweenService:Create(
		hrp,
		TweenInfo.new(time, Enum.EasingStyle.Linear),
		{CFrame = cf}
	)
	currentTween:Play()
	currentTween.Completed:Wait()
end

local function getNearestCollectible()
	local nearest, dist
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj:FindFirstChildWhichIsA("ProximityPrompt", true) then
			local d = (obj.Position - hrp.Position).Magnitude
			if d <= RANGE and (not dist or d < dist) then
				nearest, dist = obj, d
			end
		end
	end
	return nearest
end

local function collect(part)
	local prompt = part:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		pcall(function()
			ProximityPromptService:TriggerPrompt(prompt)
		end)
	end
end

-- ===== Button =====
btn.MouseButton1Click:Connect(function()
	ENABLED = not ENABLED
	if ENABLED then
		startCFrame = hrp.CFrame
		btn.Text = "LightNing⚡ ON"
		btn.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
	else
		btn.Text = "LightNing⚡ OFF"
		btn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
		if startCFrame then
			tweenTo(startCFrame)
		end
	end
end)

-- ===== Main Loop =====
task.spawn(function()
	while task.wait(0.4) do
		if not ENABLED or not hrp then continue end

		local target = getNearestCollectible()
		if target then
			tweenTo(target.CFrame + Vector3.new(0, 1.5, 0))

			-- ⏸️ đứng lại cho chắc
			task.wait(0.6)

			collect(target)

			task.wait(0.2)

			if startCFrame then
				tweenTo(startCFrame)
			end
		end
	end
end)
