-- LightNing⚡ Anti Văng / Anti Knockback

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local enabled = false
local savedCFrame
local connection

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LightNingAntiVang by Phúc-7/2"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(240, 140)
frame.Position = UDim2.fromScale(0.4, 0.4)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "LightNing⚡ Anti Văng by Phúc 7/2"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.fromOffset(180, 40)
toggle.Position = UDim2.fromOffset(30, 70)
toggle.Text = "Tắt"
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 18
toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
toggle.TextColor3 = Color3.new(1,1,1)

-- Utils
local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
end

local function start()
	local hrp, hum = getHRP()
	savedCFrame = hrp.CFrame

	connection = RunService.Heartbeat:Connect(function()
		if not enabled then return end
		if not hrp or not hrp.Parent then return end

		-- ❌ Không cho ngã
		hum.PlatformStand = false
		hum:ChangeState(Enum.HumanoidStateType.Running)

		-- ❌ Chặn văng mạnh
		if hrp.AssemblyLinearVelocity.Magnitude > 60 then
			hrp.AssemblyLinearVelocity = Vector3.zero
		end

		-- ❌ Bị hất đi xa → GIẬT VỀ SIÊU NHANH
		if (hrp.Position - savedCFrame.Position).Magnitude > 5 then
			hrp.CFrame = savedCFrame
		end
	end)
end

local function stop()
	if connection then
		connection:Disconnect()
		connection = nil
	end
end

toggle.MouseButton1Click:Connect(function()
	enabled = not enabled
	if enabled then
		toggle.Text = "Đã Bật rồi Con Doge"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
		stop()
		start()
	else
		toggle.Text = "Tắt rồi"
		toggle.BackgroundColor3 = Color3.fromRGB(170,0,0)
		stop()
	end
end)

-- Auto lại sau khi chết
player.CharacterAdded:Connect(function()
	if enabled then
		task.wait(0.5)
		stop()
		start()
	end
end)
