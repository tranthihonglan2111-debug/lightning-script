-- ⚡ Kiutie Plus™ COMBO | ONE BUTTON
-- Auto Aim + Hitbox (LỚN) + Auto Attack + Speed Boost
-- by kiutie 😼

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- ===== CONFIG (TỐI ƯU PLUS) =====
local enabled = false
local aimRange = 38
local hitboxSize = 19      -- TO HƠN
local smoothness = 0.14
local attackDelay = 0.07
local speedBoost = 35      -- tốc chạy khi bật combo (thường 16)

-- ===== GUI =====
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 280, 0, 50)
btn.Position = UDim2.new(0.05, 0, 0.72, 0)
btn.Text = "Pvp Steal by Phúc 7/2: OFF"
btn.BackgroundColor3 = Color3.fromRGB(28,28,28)
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextScaled = true
btn.Active = true
btn.Draggable = true

btn.MouseButton1Click:Connect(function()
	enabled = not enabled
	btn.Text = enabled and "Pvp Steal by Phúc 7/2: ON" or "Pvp Steal by Phúc 7/2 : OFF"
end)

-- ===== UTILS =====
local originalHRP = {}
local originalSpeed

local function getNearestTarget()
	local myChar = LP.Character
	local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myHRP then return end

	local closest, dist = nil, aimRange
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			local d = (hrp.Position - myHRP.Position).Magnitude
			if d < dist then
				dist = d
				closest = hrp
			end
		end
	end
	return closest
end

local function applyHitbox(hrp)
	if not originalHRP[hrp] then
		originalHRP[hrp] = {
			Size = hrp.Size,
			Transparency = hrp.Transparency,
			CanCollide = hrp.CanCollide
		}
	end
	hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
	hrp.Transparency = 0.55
	hrp.CanCollide = false
end

local function resetAllHitbox()
	for hrp, data in pairs(originalHRP) do
		if hrp and hrp.Parent then
			hrp.Size = data.Size
			hrp.Transparency = data.Transparency
			hrp.CanCollide = data.CanCollide
		end
		originalHRP[hrp] = nil
	end
end

local function applySpeed(on)
	local char = LP.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	if on then
		originalSpeed = originalSpeed or hum.WalkSpeed
		hum.WalkSpeed = speedBoost
	else
		if originalSpeed then hum.WalkSpeed = originalSpeed end
		originalSpeed = nil
	end
end

-- ===== MAIN LOOP =====
task.spawn(function()
	while true do
		task.wait(attackDelay)
		if not enabled then continue end

		local char = LP.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then continue end

		-- SPEED BOOST
		applySpeed(true)

		-- TARGET
		local targetHRP = getNearestTarget()
		if not targetHRP then continue end

		-- AIM NHẸ
		local lookAt = CFrame.new(hrp.Position, targetHRP.Position)
		hrp.CFrame = hrp.CFrame:Lerp(lookAt, smoothness)

		-- HITBOX TO
		applyHitbox(targetHRP)

		-- AUTO ĐÁNH
		local tool = char:FindFirstChildOfClass("Tool")
		if tool then pcall(function() tool:Activate() end) end
	end
end)

-- CLEANUP KHI TẮT
RunService.RenderStepped:Connect(function()
	if not enabled then
		resetAllHitbox()
		applySpeed(false)
	end
end)
