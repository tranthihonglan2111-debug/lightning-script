-- ⚡ LightNing FPS Boost
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Giảm đồ họa
Lighting.GlobalShadows = false
Lighting.FogEnd = 1e10
Lighting.Brightness = 1
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

-- Tắt hiệu ứng thừa
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Smoke")
    or v:IsA("Fire")
    or v:IsA("Explosion") then
        v.Enabled = false
    end
end

-- Giảm chất lượng part
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    end
end

-- Thông báo
game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ LightNing";
    Text = "FPS Boost ON - Game mượt hơn!";
    Duration = 5;
})
