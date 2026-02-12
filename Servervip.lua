-- LightNing Auto Rejoin Server Ít Người
-- By kiutie ⚡

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local PlaceId = game.PlaceId
local running = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "LightNing_Rejoin"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 130)
frame.Position = UDim2.new(0.5, -110, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "⚡ LightNing Rejoin by Phúc 7/2"
title.TextColor3 = Color3.fromRGB(255,255,0)
title.BackgroundTransparency = 1

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.8,0,0,40)
toggle.Position = UDim2.new(0.1,0,0.4,0)
toggle.Text = "Tìm Servervip"
toggle.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggle.TextColor3 = Color3.new(1,1,1)

-- Hàm tìm server ít người
local function getLowServer()
    local servers = HttpService:JSONDecode(
        game:HttpGet(
            "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        )
    )

    for _,server in pairs(servers.data) do
        if server.playing < server.maxPlayers - 1 then
            return server.id
        end
    end
end

toggle.MouseButton1Click:Connect(function()
    running = not running
    toggle.Text = running and "Tìm servervip" or "Đang Tìm Servervip"

    if running then
        task.spawn(function()
            task.wait(1)
            local serverId = getLowServer()
            if serverId then
                TeleportService:TeleportToPlaceInstance(PlaceId, serverId, LocalPlayer)
            end
        end)
    end
end)
