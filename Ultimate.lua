--[[ 
  🌟 CYBERPUNK V6 - ULTIMATE SUPREME 🌟
  - Fix lỗi nút X thu gọn
  - Hệ thống Siêu Fix Lag & Tăng FPS
  - 25+ Chức năng Toàn Năng
]]

local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local mouse = player:GetMouse()
local coreGui = game:GetService("CoreGui") or player:WaitForChild("PlayerGui")

-- Xóa bản cũ
if coreGui:FindFirstChild("UltimateHubV6") then coreGui.UltimateHubV6:Destroy() end

local sg = Instance.new("ScreenGui", coreGui)
sg.Name = "UltimateHubV6"
sg.ResetOnSpawn = false

-- [ NÚT TRÒN THU GỌN - HIỆN KHI BẤM X ]
local openIcon = Instance.new("TextButton", sg)
openIcon.Size = UDim2.new(0, 50, 0, 50)
openIcon.Position = UDim2.new(0, 10, 0.5, -25)
openIcon.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
openIcon.Text = "MENU"
openIcon.TextColor3 = Color3.new(0,0,0)
openIcon.Font = Enum.Font.GothamBlack
openIcon.TextSize = 12
openIcon.Visible = false
openIcon.ZIndex = 10
Instance.new("UICorner", openIcon).CornerRadius = UDim.new(1, 0)
local iconStroke = Instance.new("UIStroke", openIcon)
iconStroke.Color = Color3.new(1,1,1)
iconStroke.Thickness = 2

-- [ KHUNG MENU CHÍNH ]
local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0, 280, 0, 400)
mainFrame.Position = UDim2.new(0.5, -140, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Thickness = 3
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        mainStroke.Color = Color3.fromHSV(hue, 1, 1)
    end
end)

-- [ THANH TIÊU ĐỀ ]
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Instance.new("UICorner", titleBar)

local titleTxt = Instance.new("TextLabel", titleBar)
titleTxt.Size = UDim2.new(0.7, 0, 1, 0)
titleTxt.Position = UDim2.new(0.05, 0, 0, 0)
titleTxt.Text = "ULTIMATE HUB V6"
titleTxt.TextColor3 = Color3.new(1, 1, 1)
titleTxt.Font = Enum.Font.GothamBlack
titleTxt.TextSize = 16
titleTxt.TextXAlignment = Enum.TextXAlignment.Left
titleTxt.BackgroundTransparency = 1

-- NÚT X ĐỂ THOÁT/THU GỌN
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(0.85, 0, 0.12, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn)

-- [ KHUNG CUỘN CHỨA CHỨC NĂNG ]
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -10, 1, -60)
scroll.Position = UDim2.new(0, 5, 0, 55)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new(0, 0, 0, 1350) -- Tăng độ dài để chứa cực nhiều nút
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [ HÀM KÉO THẢ ]
local function makeDraggable(obj)
    local dragging, dragInput, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = obj.Position
        end
    end)
    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    uis.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end
makeDraggable(mainFrame)
makeDraggable(openIcon)

-- ẨN / HIỆN
closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false openIcon.Visible = true end)
openIcon.MouseButton1Click:Connect(function() mainFrame.Visible = true openIcon.Visible = false end)

-- [ HÀM TẠO NÚT ]
local states = {}
local function addToggle(name, callback)
    states[name] = false
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.92, 0, 0, 35)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        states[name] = not states[name]
        btn.Text = states[name] and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = states[name] and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(30, 30, 40)
        btn.TextColor3 = states[name] and Color3.new(0,0,0) or Color3.new(1,1,1)
        callback(states[name])
    end)
end

local function addButton(name, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(0.92, 0, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- ================= DANH SÁCH CHỨC NĂNG SIÊU CẤP =================

-- 1. FIX LAG TOÀN DIỆN
addToggle("⚡ SIÊU FIX LAG (Low GFX)", function(s)
    if s then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = "SmoothPlastic" v.CastShadow = false end
            if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
        end
        settings().Rendering.QualityLevel = 1
    end
end)

-- 2. TĂNG FPS (XÓA HIỆU ỨNG)
addToggle("🚀 Tăng FPS (Clear Effects)", function(s)
    if s then
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 9e9
        for _, v in pairs(game.Lighting:GetChildren()) do v.Parent = nil end
    end
end)

-- 3. SIÊU TỐC ĐỘ (150)
addToggle("🏃 Siêu Tốc Độ (Speed)", function(s)
    rs.Heartbeat:Connect(function()
        if states["🏃 Siêu Tốc Độ (Speed)"] and player.Character then
            player.Character.Humanoid.WalkSpeed = 150
        end
    end)
end)

-- 4. NHẢY SIÊU CAO (200)
addToggle("🚀 Nhảy Siêu Cao", function(s)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = s and 200 or 50
    end
end)

-- 5. XUYÊN TƯỜNG (NOCLIP)
addToggle("👻 Xuyên Tường (Noclip)", function(s)
    rs.Stepped:Connect(function()
        if states["👻 Xuyên Tường (Noclip)"] and player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 6. NHẢY VÔ HẠN
addToggle("☁️ Nhảy Vô Hạn", function(s)
    uis.JumpRequest:Connect(function()
        if states["☁️ Nhảy Vô Hạn"] then player.Character.Humanoid:ChangeState(3) end
    end)
end)

-- 7. TỰ ĐỘNG ĐÁNH (AUTO CLICK)
addToggle("🖱️ Auto Click (0.01s)", function(s)
    task.spawn(function()
        while states["🖱️ Auto Click (0.01s)"] do
            local t = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if t then t:Activate() end
            task.wait(0.01)
        end
    end)
end)

-- 8. NHÌN XUYÊN NGƯỜI (ESP)
addToggle("👁️ ESP Player (Highlight)", function(s)
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            if s then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0)
                h.Name = "CyberESP"
            else
                if p.Character:FindFirstChild("CyberESP") then p.Character.CyberESP:Destroy() end
            end
        end
    end
end)

-- 9. DỊCH CHUYỂN BẰNG CTRL + CLICK
addToggle("📍 Ctrl + Click TP", function(s)
    mouse.Button1Down:Connect(function()
        if states["📍 Ctrl + Click TP"] and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
            player.Character.HumanoidRootPart.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
        end
    end)
end)

-- 10. CHỐNG AFK (TREO MÁY)
addToggle("🛡️ Chống Kick AFK", function(s)
    player.Idled:Connect(function()
        if states["🛡️ Chống Kick AFK"] then
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end
    end)
end)

-- 11. BTOOLS (LẤY DỤNG CỤ PHÁ MAP)
addButton("🔨 Lấy BTools (Phá Map)", function()
    for i = 1, 4 do
        local b = Instance.new("HopperBin", player.Backpack)
        b.BinType = i
    end
end)

-- 12. SERVER HOP (SANG SERVER KHÁC)
addButton("🌐 Tìm Server Mới", function()
    local x = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _,v in pairs(x.data) do if v.playing < v.maxPlayers and v.id ~= game.JobId then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id) break end end
end)

-- 13. SÁNG MAP (FULL BRIGHT)
addToggle("💡 Sáng Toàn Bản Đồ", function(s)
    game.Lighting.Brightness = s and 2 or 1
    game.Lighting.GlobalShadows = not s
    game.Lighting.ClockTime = s and 14 or 12
end)

-- 14. CHỐNG NGÃ (ANTI RAGDOLL)
addToggle("🤸 Chống Ngã (No Ragdoll)", function(s)
    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not s)
    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not s)
end)

-- 15. TÀNG HÌNH (LOCAL INVISIBLE)
addToggle("👤 Tàng Hình (Client Side)", function(s)
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = s and 0.5 or 0
            end
        end
    end
end)

-- 16. XOAY VÒNG (SPIN BOT)
addToggle("🌀 Spin Bot (Vòng Xoáy)", function(s)
    task.spawn(function()
        while states["🌀 Spin Bot (Vòng Xoáy)"] do
            player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(50), 0)
            task.wait()
        end
    end)
end)

-- 17. GÓC NHÌN RỘNG (MAX FOV)
addToggle("🎥 Góc Nhìn Cực Rộng", function(s)
    workspace.CurrentCamera.FieldOfView = s and 120 or 70
end)

-- 18. TRỌNG LỰC MẶT TRĂNG (LOW GRAVITY)
addToggle("🌕 Trọng Lực Mặt Trăng", function(s)
    workspace.Gravity = s and 40 or 196.2
end)

-- 19. ĐI TRÊN NƯỚC (WALK ON WATER)
addToggle("🌊 Đi Trên Mặt Nước", function(s)
    if s then
        local p = Instance.new("Part", workspace)
        p.Name = "WaterPart" p.Size = Vector3.new(2000, 1, 2000) p.Anchored = true p.Transparency = 0.5 p.Position = Vector3.new(0, 0, 0)
    else
        if workspace:FindFirstChild("WaterPart") then workspace.WaterPart:Destroy() end
    end
end)

-- 20. XOAY NHÌN NGƯỜI GẦN NHẤT
addToggle("🎯 Tự Xoay Nhìn Kẻ Địch", function(s)
    rs.RenderStepped:Connect(function()
        if states["🎯 Tự Xoay Nhìn Kẻ Địch"] then
            local t = nil local d = 1000
            for _,p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local m = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if m < d then d = m t = p.Character.HumanoidRootPart end
                end
            end
            if t then player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, Vector3.new(t.Position.X, player.Character.HumanoidRootPart.Position.Y, t.Position.Z)) end
        end
    end)
end)

print("Ultimate Supreme Hub V6 Loaded! Enjoy your God Mode.")
