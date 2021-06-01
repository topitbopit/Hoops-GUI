--get fucked
local screen = Instance.new("ScreenGui")
local MessageFrame = Instance.new("Frame")
local MessageLabel = Instance.new("TextButton")

screen.Parent = game.CoreGui

MessageFrame.Parent = screen
MessageFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MessageFrame.BorderColor3 = Color3.fromRGB(20, 20, 40)
MessageFrame.BorderSizePixel = 2
MessageFrame.Position = UDim2.new(0.5, -250, 1.1, 0)
MessageFrame.Size = UDim2.new(0, 500, 0, 200)
MessageFrame.ZIndex = 200

MessageLabel.Parent = MessageFrame
MessageLabel.BackgroundTransparency = 1
MessageLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MessageLabel.BorderSizePixel = 0
MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
MessageLabel.Position = UDim2.new(0.5, -225, 0.5, -75)
MessageLabel.Size = UDim2.new(0, 450, 0, 150)
MessageLabel.Font = Enum.Font.Nunito
MessageLabel.Text = "This Jeff Hoops GUI link has been updated to a new one. Please download the new bootstrapper!<br/><font color = 'rgb(0, 0, 255)'>https://raw.githubusercontent.com/topitbopit/Hoops-GUI/main/script.lua</font>, or join the discord (<font color = 'rgb(0, 0, 255)'>https://discord.gg/a3JEr9Z6jY</font>) to get the script there<br/><i>Click to continue</i>"
MessageLabel.RichText = true
MessageLabel.TextScaled = true
MessageLabel.ZIndex = 300
MessageLabel.AutoButtonColor = false


local function TweenPos(object, dest, timing, dir)
    timing = timing or 0.25
    dir = dir or Enum.EasingDirection.Out
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{ Position = dest  }):Play()
end



TweenPos(MessageFrame, UDim2.new(0.5, -(MessageFrame.Size.Width.Offset / 2), 0.5, -(MessageFrame.Size.Height.Offset / 2)), 0.75)
wait(4)
MessageLabel.MouseButton1Click:Connect(function()
    TweenPos(MessageFrame, UDim2.new(0.5, -(MessageFrame.Size.Width.Offset / 2), 1.1, 0), 0.75, Enum.EasingDirection.In)
    wait(1)
    MessageFrame:Destroy() 
end)
