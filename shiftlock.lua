-- ⚡ LightNing Shift Lock Unlock

local Players = game:GetService("Players")
local UserSettings = UserSettings()
local player = Players.LocalPlayer

pcall(function()
    UserSettings.GameSettings.ControlMode = Enum.ControlMode.MouseLockSwitch
end)

-- Ép bật lại nếu game cố tắt
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if UserSettings.GameSettings.ControlMode ~= Enum.ControlMode.MouseLockSwitch then
                UserSettings.GameSettings.ControlMode = Enum.ControlMode.MouseLockSwitch
            end
        end)
    end
end)

-- Thông báo
game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ LightNing";
    Text = "Shift Lock UNLOCKED (Client)";
    Duration = 5;
})
