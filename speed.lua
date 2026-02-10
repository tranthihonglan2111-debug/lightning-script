local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

humanoid.WalkSpeed = 50

game.StarterGui:SetCore("SendNotification", {
    Title = "⚡ Lightning";
    Text = "Speed ON (50)";
    Duration = 5;
})
