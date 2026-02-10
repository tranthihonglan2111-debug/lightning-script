-- ⚡ LightNing Auto Click (FAST)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local clicking = false
local CPS = 20 -- Clicks Per Second (tăng lên 30 nếu máy khỏe)

-- Auto click loop
task.spawn(function()
    while task.wait(1 / CPS) do
        if clicking then
            pcall(function()
                mouse1click()
            end)
        end
    end
end)

-- Bật / tắt bằng phím (PC) hoặc tap (Mobile UI sau)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        clicking = not clicking
        game.StarterGui:SetCore("SendNotification", {
            Title = "⚡ LightNing";
            Text = clicking and "Auto Click: ON" or "Auto Click: OFF";
            Duration = 3;
        })
    end
end)
