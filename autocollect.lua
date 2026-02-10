-- ⚡ LightNing Auto Collect (Fly - Collect - Return)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local ENABLED = false
local RANGE = 200     -- phạm vi quét
local SPEED = 90      -- tốc độ bay (stud/s)

local startCFrame = nil
local currentTween = nil

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
	if currentTween then currentTween:Cancel() end
	local dist = (hrp.Position - cf.Position).Magnitude
	local time = math.clamp(dist / SPEED, 0.15, 1.5)

	currentTween = TweenService:Create(
		hrp,
		TweenInfo.new(time, Enum.EasingStyle.Linear),
		{CFrame = cf}
	)
	currentTween:Play()
	currentTween.Completed:Wait()
end

local function isCollectible(part)
	return part:IsA("BasePart") and part:FindFirstChildWhichIsA("ProximityPrompt", true)
end

local function getNearestCollectible()
	local nearest, dist
	for _, obj in ipairs(workspace:GetDescendants()) do
		if isCollectible(obj) then
			local d = (obj.Position - hrp.Position).Magnitude
			if d <= RANGE and (not dist or d < dist) then
				nearest, dist = obj, d
			end
		end
	end
	return nearest
end

local function collectFrom(part)
	local prompt = part:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		-- kích hoạt nhặt
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
			tweenTo(startCFrame) -- bay về vị trí cũ
		end
	end
end)

-- ===== Main Loop =====
task.spawn(function()
	while task.wait(0.3) do
		if not ENABLED or not char.Parent then continue end

		local target = getNearestCollectible()
		if target then
			-- bay tới
			tweenTo(target.CFrame + Vector3.new(0, 1.5, 0))
			task.wait(0.1)
			-- tự nhặt
			collectFrom(target)
			task.wait(0.2)
			-- bay về chỗ bật
			if startCFrame then
				tweenTo(startCFrame)
			end
		end
	end
end)
