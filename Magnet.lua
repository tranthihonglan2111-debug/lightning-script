-- ⚡ LightNing Click To Attract Item

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local SPEED = 0.5 -- thời gian bay (giảm = bay nhanh)

local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart")
end

local function attract(part)
	if not part:IsA("BasePart") then return end
	if not part.Anchored == false then return end

	local hrp = getHRP()

	-- Tween vật bay về trước mặt
	local targetCF = hrp.CFrame * CFrame.new(0, 0, -3)

	local tween = TweenService:Create(
		part,
		TweenInfo.new(SPEED, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{CFrame = targetCF}
	)
	tween:Play()
	tween.Completed:Wait()

	-- Tự nhặt nếu có Prompt
	local prompt = part:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		task.wait(0.2)
		pcall(function()
			ProximityPromptService:TriggerPrompt(prompt)
		end)
	end
end

-- Mobile + PC đều dùng được
mouse.Button1Down:Connect(function()
	if mouse.Target then
		attract(mouse.Target)
	end
end)

print("⚡ LightNing Click Attract Loaded")
