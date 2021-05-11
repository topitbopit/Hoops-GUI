--[[Hoops Gui v1.1.0]]--
--[[Made by topit]]--


--[[VARIABLES]]--
--Framework variables--
local VerticalPositions = {
	Section1 = {40, 90},
	Section2 = {170},
	Section3 = {250, 300},
	Section4 = {380}

}


local font = Enum.Font.Nunito

local Theme_Dark = {
	Color3.fromRGB(25, 25, 25),   
	Color3.fromRGB(10, 10, 10),   
	Color3.fromRGB(40, 40, 40),   
	Color3.fromRGB(35, 35, 35),   
	Color3.fromRGB(20, 20, 20),   
	Color3.fromRGB(25, 100, 45),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(245, 245, 255),
	Color3.fromRGB(155, 155, 255) 
}
local Theme_Steel = {
	Color3.fromRGB(25, 25, 35),   
	Color3.fromRGB(10, 10, 20),   
	Color3.fromRGB(40, 40, 50),   
	Color3.fromRGB(35, 35, 45),   
	Color3.fromRGB(20, 20, 25),   
	Color3.fromRGB(25, 100, 55),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(245, 245, 255),
	Color3.fromRGB(155, 155, 255) 
}
local Theme_Rust = {
	Color3.fromRGB(45, 25, 25),   
	Color3.fromRGB(30, 10, 10),   
	Color3.fromRGB(60, 40, 40),   
	Color3.fromRGB(55, 35, 35),   
	Color3.fromRGB(40, 20, 20),   
	Color3.fromRGB(45, 100, 45),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 245, 255),
	Color3.fromRGB(175, 155, 255) 
}
local Theme_Violet = {
	Color3.fromRGB(35, 25, 45),   
	Color3.fromRGB(20, 10, 30),   
	Color3.fromRGB(50, 40, 60),   
	Color3.fromRGB(45, 35, 55),   
	Color3.fromRGB(30, 20, 40),   
	Color3.fromRGB(35, 100, 65),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(245, 245, 255),
	Color3.fromRGB(155, 155, 255) 
}
local Theme_Space = {
	Color3.fromRGB(10, 10, 10),   
	Color3.fromRGB(0, 0, 0),   
	Color3.fromRGB(20, 20, 20),   
	Color3.fromRGB(25, 25, 25),   
	Color3.fromRGB(5, 5, 5),   
	Color3.fromRGB(20, 25, 50),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(245, 245, 255),
	Color3.fromRGB(155, 155, 255) 
}


local SelectedTheme = math.random(1,5)
if SelectedTheme == 1 then
    SelectedTheme = Theme_Steel
elseif SelectedTheme == 2 then
    SelectedTheme = Theme_Dark
elseif SelectedTheme == 3 then
    SelectedTheme = Theme_Rust
elseif SelectedTheme == 4 then
    SelectedTheme = Theme_Violet
elseif SelectedTheme == 5 then
    SelectedTheme = Theme_Space
end
local version = "1.1.0"
local Dragging = {}

local ButtonStates = {
    Section1 = {false, false, false, false, false},
    Section3 = {false, false, false, false, false}
}

local Hotkeys = {
    Aimbot = Enum.KeyCode.R
}

local basketballinstance = nil
for i,v in pairs(game.Workspace:GetDescendants()) do 
    if v:IsA("BasePart") and v.Name == "Basketball" then
        basketballinstance = v
        break
    end
end

local tpconnec = nil
local aimbconnec = nil


local AimbotSpeed = 2
local ShownStealdesc = false
local ShownAimbotdesc = false

--Services
local PlayerService        = game:GetService("Players")
local TeamsService         = game:GetService("Teams")
local TweenService         = game:GetService("TweenService")
local RunService           = game:GetService("RunService")
local MarketService        = game:GetService("MarketplaceService")
local UserInputService     = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage    = game:GetService("ReplicatedStorage")
--Player related
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

--[[Instances]]--
local screen = Instance.new("ScreenGui")

local Framework = {}
Framework.Bar          = Instance.new("Frame")
Framework.Shadow       = Instance.new("Frame")
Framework.Menu         = Instance.new("ScrollingFrame")
Framework.Title        = Instance.new("TextLabel")
Framework.TitleShadow  = Instance.new("TextLabel")
Framework.Desc         = Instance.new("TextLabel")
Framework.Close        = Instance.new("TextButton")

local Section1 = {}
Section1.Title         = Instance.new("TextLabel")
Section1.Button1       = Instance.new("TextButton")
Section1.Button2       = Instance.new("TextButton")
Section1.Button3       = Instance.new("TextButton")
Section1.Button4       = Instance.new("TextButton")
Section1.Button5       = Instance.new("TextButton")

local Section2 = {}
Section2.Title         = Instance.new("TextLabel")
Section2.Button1       = Instance.new("TextButton")
Section2.Button2       = Instance.new("TextButton")


local Section3 = {}
Section3.Title         = Instance.new("TextLabel")
Section3.Button1       = Instance.new("TextButton")
Section3.Button2       = Instance.new("TextButton")
Section3.Button3       = Instance.new("TextButton")
Section3.Button4       = Instance.new("TextButton")
Section3.Button5       = Instance.new("TextButton")
Section3.Button6       = Instance.new("TextButton")

local Section4 = {}
Section4.Title         = Instance.new("TextLabel")
Section4.Button1       = Instance.new("TextBox")
Section4.Button2       = Instance.new("TextButton")
Section4.Button3       = Instance.new("TextButton")
Section4.Button4       = Instance.new("TextButton")
Section4.Button5       = Instance.new("TextButton")


--[[Properties]]--

screen.Name = "Template"
screen.Parent = game.CoreGui

Framework.Bar.Parent = screen
Framework.Bar.BackgroundColor3 = SelectedTheme[1]
Framework.Bar.BorderColor3 = SelectedTheme[3]
Framework.Bar.Position = UDim2.new(0.65, 0, 1.1, 0)
Framework.Bar.Size = UDim2.new(0, 400, 0, 250)
Framework.Bar.ZIndex = 200

Framework.Shadow.Parent = Framework.Bar
Framework.Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Framework.Shadow.BackgroundTransparency = 0.5
Framework.Shadow.BorderSizePixel = 0
Framework.Shadow.Position = UDim2.new(0, 5, 0, 5)
Framework.Shadow.Size = Framework.Bar.Size
Framework.Shadow.ZIndex = 190

Framework.Menu.Parent = Framework.Bar
Framework.Menu.BackgroundColor3 = SelectedTheme[2]
Framework.Menu.BorderColor3 = SelectedTheme[3]
Framework.Menu.AnchorPoint = Vector2.new(0,1)
Framework.Menu.Position = UDim2.new(0, 0, 1, 0)
Framework.Menu.Size = UDim2.new(0, 400, 0, 200)
Framework.Menu.CanvasSize = UDim2.new(0, 350, 0, 600)
Framework.Menu.ScrollBarImageTransparency = 0.5
Framework.Menu.Active = true
Framework.Menu.Visible = true
Framework.Menu.ZIndex = 250

Framework.Title.Parent = Framework.Bar
Framework.Title.Position = UDim2.new(0, 10, 0, 0)
Framework.Title.Font = Enum.Font.Nunito
Framework.Title.Text = "Hoops GUI v"..version
Framework.Title.Size = UDim2.new(0, 270, 0, 50)
Framework.Title.TextColor3 = SelectedTheme[8]
Framework.Title.TextSize = 32
Framework.Title.TextXAlignment = Enum.TextXAlignment.Left
Framework.Title.TextYAlignment = Enum.TextYAlignment.Center
Framework.Title.ZIndex = 400
Framework.Title.BackgroundTransparency = 1

Framework.TitleShadow.Parent = Framework.Title
Framework.TitleShadow.Position = UDim2.new(0, 4, 0, 4)
Framework.TitleShadow.Font = Enum.Font.Nunito
Framework.TitleShadow.Text = Framework.Title.Text
Framework.TitleShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
Framework.TitleShadow.TextTransparency = 0.5
Framework.TitleShadow.TextSize = 32
Framework.TitleShadow.Size = UDim2.new(0, 270, 0, 50)
Framework.TitleShadow.TextXAlignment = Enum.TextXAlignment.Left
Framework.TitleShadow.TextYAlignment = Enum.TextYAlignment.Center
Framework.TitleShadow.ZIndex = 399
Framework.TitleShadow.BackgroundTransparency = 1

Framework.Desc.Parent = Framework.Menu
Framework.Desc.Position = UDim2.new(0, 10, 1, -50)
Framework.Desc.Font = Enum.Font.Nunito
Framework.Desc.Text = "Made by topit"
Framework.Desc.Size = UDim2.new(0, 270, 0, 50)
Framework.Desc.TextColor3 = SelectedTheme[8]
Framework.Desc.TextSize = 32
Framework.Desc.TextXAlignment = Enum.TextXAlignment.Left
Framework.Desc.TextYAlignment = Enum.TextYAlignment.Center
Framework.Desc.ZIndex = 400
Framework.Desc.BackgroundTransparency = 1

Framework.Close.Parent = Framework.Bar
Framework.Close.BackgroundColor3 = SelectedTheme[4]
Framework.Close.BorderColor3 = SelectedTheme[3]
Framework.Close.Position = UDim2.new(1, -25, 0, 0)
Framework.Close.Size = UDim2.new(0, 25, 0, 25)
Framework.Close.Font = Enum.Font.Nunito
Framework.Close.Text = "X"
Framework.Close.TextColor3 = SelectedTheme[7]
Framework.Close.TextSize = 14
Framework.Close.ZIndex = 450

Section1.Title.Parent = Framework.Menu
Section1.Title.Position = UDim2.new(0, 10, 0, VerticalPositions.Section1[1] - 35)
Section1.Title.Font = Enum.Font.Nunito
Section1.Title.Text = "Basketball modules - toggleable"
Section1.Title.Size = UDim2.new(0, 270, 0, 35)
Section1.Title.TextColor3 = SelectedTheme[8]
Section1.Title.TextSize = 19
Section1.Title.TextXAlignment = Enum.TextXAlignment.Left
Section1.Title.TextYAlignment = Enum.TextYAlignment.Top
Section1.Title.ZIndex = 400
Section1.Title.BackgroundTransparency = 1

Section1.Button1.Parent = Framework.Menu
Section1.Button1.BackgroundColor3 = SelectedTheme[4]
Section1.Button1.BorderColor3 = SelectedTheme[3]
Section1.Button1.Position = UDim2.new(0.05, 0, 0, VerticalPositions.Section1[1])
Section1.Button1.Font = Enum.Font.Nunito
Section1.Button1.Text = "Aimbot"
Section1.Button1.Size = UDim2.new(0, 100, 0, 25)
Section1.Button1.TextColor3 = SelectedTheme[8]
Section1.Button1.TextSize = 19
Section1.Button1.TextXAlignment = Enum.TextXAlignment.Center
Section1.Button1.TextYAlignment = Enum.TextYAlignment.Center
Section1.Button1.ZIndex = 400

Section1.Button2.Parent = Framework.Menu
Section1.Button2.BackgroundColor3 = SelectedTheme[4]
Section1.Button2.BorderColor3 = SelectedTheme[3]
Section1.Button2.Position = UDim2.new(0.35, 0, 0, VerticalPositions.Section1[1])
Section1.Button2.Font = Enum.Font.Nunito
Section1.Button2.Text = "Spam throw"
Section1.Button2.Size = UDim2.new(0, 100, 0, 25)
Section1.Button2.TextColor3 = SelectedTheme[8]
Section1.Button2.TextSize = 19
Section1.Button2.TextXAlignment = Enum.TextXAlignment.Center
Section1.Button2.TextYAlignment = Enum.TextYAlignment.Center
Section1.Button2.ZIndex = 400

Section1.Button3.Parent = Framework.Menu
Section1.Button3.BackgroundColor3 = SelectedTheme[4]
Section1.Button3.BorderColor3 = SelectedTheme[3]
Section1.Button3.Position = UDim2.new(0.65, 0, 0, VerticalPositions.Section1[1])
Section1.Button3.Font = Enum.Font.Nunito
Section1.Button3.Text = "Ball ESP"
Section1.Button3.Size = UDim2.new(0, 100, 0, 25)
Section1.Button3.TextColor3 = SelectedTheme[8]
Section1.Button3.TextSize = 19
Section1.Button3.TextXAlignment = Enum.TextXAlignment.Center
Section1.Button3.TextYAlignment = Enum.TextYAlignment.Center
Section1.Button3.ZIndex = 400

Section2.Title.Parent = Framework.Menu
Section2.Title.Position = UDim2.new(0, 10, 0, VerticalPositions.Section2[1] - 35)
Section2.Title.Font = Enum.Font.Nunito
Section2.Title.Text = "Basketball modules - single fire"
Section2.Title.Size = UDim2.new(0, 270, 0, 35)
Section2.Title.TextColor3 = SelectedTheme[8]
Section2.Title.TextSize = 19
Section2.Title.TextXAlignment = Enum.TextXAlignment.Left
Section2.Title.TextYAlignment = Enum.TextYAlignment.Top
Section2.Title.ZIndex = 400
Section2.Title.BackgroundTransparency = 1

Section2.Button1.Parent = Framework.Menu
Section2.Button1.BackgroundColor3 = SelectedTheme[4]
Section2.Button1.BorderColor3 = SelectedTheme[3]
Section2.Button1.Position = UDim2.new(0.05, 0, 0, VerticalPositions.Section2[1])
Section2.Button1.Font = Enum.Font.Nunito
Section2.Button1.Text = "Layup"
Section2.Button1.Size = UDim2.new(0, 100, 0, 25)
Section2.Button1.TextColor3 = SelectedTheme[8]
Section2.Button1.TextSize = 19
Section2.Button1.TextXAlignment = Enum.TextXAlignment.Center
Section2.Button1.TextYAlignment = Enum.TextYAlignment.Center
Section2.Button1.ZIndex = 400

Section2.Button2.Parent = Framework.Menu
Section2.Button2.BackgroundColor3 = SelectedTheme[4]
Section2.Button2.BorderColor3 = SelectedTheme[3]
Section2.Button2.Position = UDim2.new(0.35, 0, 0, VerticalPositions.Section2[1])
Section2.Button2.Font = Enum.Font.Nunito
Section2.Button2.Text = "Pass to self"
Section2.Button2.Size = UDim2.new(0, 100, 0, 25)
Section2.Button2.TextColor3 = SelectedTheme[8]
Section2.Button2.TextSize = 19
Section2.Button2.TextXAlignment = Enum.TextXAlignment.Center
Section2.Button2.TextYAlignment = Enum.TextYAlignment.Center
Section2.Button2.ZIndex = 400


Section3.Title.Parent = Framework.Menu
Section3.Title.Position = UDim2.new(0, 10, 0, VerticalPositions.Section3[1] - 35)
Section3.Title.Font = Enum.Font.Nunito
Section3.Title.Text = "Player modules"
Section3.Title.Size = UDim2.new(0, 270, 0, 35)
Section3.Title.TextColor3 = SelectedTheme[8]
Section3.Title.TextSize = 19
Section3.Title.TextXAlignment = Enum.TextXAlignment.Left
Section3.Title.TextYAlignment = Enum.TextYAlignment.Top
Section3.Title.ZIndex = 400
Section3.Title.BackgroundTransparency = 1

Section3.Button1.Parent = Framework.Menu
Section3.Button1.BackgroundColor3 = SelectedTheme[4]
Section3.Button1.BorderColor3 = SelectedTheme[3]
Section3.Button1.Position = UDim2.new(0.05, 0, 0, VerticalPositions.Section3[1])
Section3.Button1.Font = Enum.Font.Nunito
Section3.Button1.Text = "Infinite stamina"
Section3.Button1.Size = UDim2.new(0, 225, 0, 25)
Section3.Button1.TextColor3 = SelectedTheme[8]
Section3.Button1.TextSize = 19
Section3.Button1.TextXAlignment = Enum.TextXAlignment.Center
Section3.Button1.TextYAlignment = Enum.TextYAlignment.Center
Section3.Button1.ZIndex = 400

Section3.Button2.Parent = Framework.Menu
Section3.Button2.BackgroundColor3 = SelectedTheme[4]
Section3.Button2.BorderColor3 = SelectedTheme[3]
Section3.Button2.Position = UDim2.new(0.65, 0, 0, VerticalPositions.Section3[1])
Section3.Button2.Font = Enum.Font.Nunito
Section3.Button2.Text = "Noslowdown"
Section3.Button2.Size = UDim2.new(0, 100, 0, 25)
Section3.Button2.TextColor3 = SelectedTheme[8]
Section3.Button2.TextSize = 19
Section3.Button2.TextXAlignment = Enum.TextXAlignment.Center
Section3.Button2.TextYAlignment = Enum.TextYAlignment.Center
Section3.Button2.ZIndex = 400

Section3.Button3.Parent = Framework.Menu
Section3.Button3.BackgroundColor3 = SelectedTheme[4]
Section3.Button3.BorderColor3 = SelectedTheme[3]
Section3.Button3.Position = UDim2.new(0.05, 0, 0, VerticalPositions.Section3[2])
Section3.Button3.Font = Enum.Font.Nunito
Section3.Button3.Text = "Ctrl-click TP"
Section3.Button3.Size = UDim2.new(0, 100, 0, 25)
Section3.Button3.TextColor3 = SelectedTheme[8]
Section3.Button3.TextSize = 19
Section3.Button3.TextXAlignment = Enum.TextXAlignment.Center
Section3.Button3.TextYAlignment = Enum.TextYAlignment.Center
Section3.Button3.ZIndex = 400

Section3.Button4.Parent = Framework.Menu
Section3.Button4.BackgroundColor3 = SelectedTheme[4]
Section3.Button4.BorderColor3 = SelectedTheme[3]
Section3.Button4.Position = UDim2.new(0.35, 0, 0, VerticalPositions.Section3[2])
Section3.Button4.Font = Enum.Font.Nunito
Section3.Button4.Text = "Auto grab"
Section3.Button4.Size = UDim2.new(0, 100, 0, 25)
Section3.Button4.TextColor3 = SelectedTheme[8]
Section3.Button4.TextSize = 19
Section3.Button4.TextXAlignment = Enum.TextXAlignment.Center
Section3.Button4.TextYAlignment = Enum.TextYAlignment.Center
Section3.Button4.ZIndex = 400

Section3.Button5.Parent = Framework.Menu
Section3.Button5.BackgroundColor3 = SelectedTheme[4]
Section3.Button5.BorderColor3 = SelectedTheme[3]
Section3.Button5.Position = UDim2.new(0.65, 0, 0, VerticalPositions.Section3[2])
Section3.Button5.Font = Enum.Font.Nunito
Section3.Button5.Text = "Hitbox exp."
Section3.Button5.Size = UDim2.new(0, 100, 0, 25)
Section3.Button5.TextColor3 = SelectedTheme[8]
Section3.Button5.TextSize = 19
Section3.Button5.TextXAlignment = Enum.TextXAlignment.Center
Section3.Button5.TextYAlignment = Enum.TextYAlignment.Center
Section3.Button5.ZIndex = 400


Section4.Title.Parent = Framework.Menu
Section4.Title.Position = UDim2.new(0, 10, 0, VerticalPositions.Section4[1] - 35)
Section4.Title.Font = Enum.Font.Nunito
Section4.Title.Text = "Hotkeys"
Section4.Title.Size = UDim2.new(0, 270, 0, 35)
Section4.Title.TextColor3 = SelectedTheme[8]
Section4.Title.TextSize = 19
Section4.Title.TextXAlignment = Enum.TextXAlignment.Left
Section4.Title.TextYAlignment = Enum.TextYAlignment.Top
Section4.Title.ZIndex = 400
Section4.Title.BackgroundTransparency = 1

Section4.Button1.Parent = Framework.Menu
Section4.Button1.BackgroundColor3 = SelectedTheme[4]
Section4.Button1.BorderColor3 = SelectedTheme[3]
Section4.Button1.Position = UDim2.new(0.05, 0, 0, VerticalPositions.Section4[1])
Section4.Button1.Font = Enum.Font.Nunito
Section4.Button1.Text = "Aimbot trigger keybind: R"
Section4.Button1.PlaceholderText = "Release to set keybind"
Section4.Button1.Size = UDim2.new(0, 340, 0, 25)
Section4.Button1.TextColor3 = SelectedTheme[8]
Section4.Button1.TextSize = 19
Section4.Button1.TextXAlignment = Enum.TextXAlignment.Center
Section4.Button1.TextYAlignment = Enum.TextYAlignment.Center
Section4.Button1.ZIndex = 400


--[[Functions]]--
local function OpenObject(object, timing, dir)
    timing = timing or 0.25 
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{BackgroundColor3 = SelectedTheme[6] }):Play()
end

local function CloseObject(object, timing, dir)
    timing = timing or 0.25 
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{BackgroundColor3 = SelectedTheme[4] }):Play()
end
    
local function TweenPosition(object, dest, timing, dir)
    timing = timing or 0.25
    dir = dir or Enum.EasingDirection.Out
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{ Position = dest  }):Play()
end

local function TweenCanvasPosition(object, dest, timing)
timing = timing or 0.25
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{CanvasPosition = dest}):Play()
end

local function TweenCFrame(object, dest, timing)
    timing = timing or 0.25
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{CFrame = dest}):Play()
end

local function TweenSize(object, dest, timing)
    timing = timing or 0.25
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{Size = dest}):Play()
end

local function CreateESP(parent, name, highlight)
    highlight = highlight or false
    
    local Bill = Instance.new("BillboardGui")
    local Text = Instance.new("TextLabel")
    
    Bill.Parent = parent
    Bill.AlwaysOnTop = true
    Bill.Name = "HEspInstance"
    Bill.Size = UDim2.new(0, 20, 0, 20)
    
    Text.Parent = Bill
    Text.Font = Enum.Font.Nunito
    Text.Text = name
    Text.TextTransparency = 0
    Text.BackgroundTransparency = 0.3
    Text.BorderSizePixel = 0
    Text.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    if highlight then
        Text.TextColor3 = Color3.fromRGB(255, 190, 190)
    else
        Text.TextColor3 = Color3.fromRGB(190, 190, 255)
    end
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.TextScaled = true
end

local function AddStars(limit)
    --creates star effect for space theme
    for i = 0, limit do
        local s = math.random(1,4)
        local f = Instance.new("ImageLabel")
        f.Name = "Star"
        f.Size = UDim2.new(0, s, 0, s)
        f.BorderSizePixel = 0 
        f.Image = "rbxassetid://3570695787"
        f.BackgroundTransparency = 1
        f.ImageTransparency = (100 - (i / 5)) / 100
        f.ImageColor3 = Color3.fromRGB(math.random(200, 255), math.random(200, 255), math.random(200, 255))
        f.Parent = Framework.Menu
        f.Position = UDim2.new(0, math.random(0,400), 0, math.random(0,700))
        f.ZIndex = 300
    end
end

local function FadeOut(object, timing)
    timing = timing or 0.75 
    for i,v in pairs(object:GetDescendants()) do
        if v:IsA("Frame") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
        elseif v:IsA("ScrollingFrame") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, ScrollBarImageTransparency = 1}):Play()
            v.ScrollBarThickness = 0
        elseif v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, TextTransparency = 1}):Play()
        elseif v:IsA("ImageLabel") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, ImageTransparency = 1}):Play()
        end
    end
    if object:IsA("Frame") then
        TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
    elseif object:IsA("TextLabel") then
        TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
    end
end

local function Message(text, position, size, delay, clickevent)
    text = text or nil
    delay = delay or 2
    size = size or UDim2.new(0, 150, 0, 50)
    position = position or UDim2.new(0.9, 0, 0.89, 0)
    clickevent = clickevent or (function() end)
    
    
    local sc = Instance.new("ScreenGui")
    sc.Parent = game.CoreGui
    local MessageFrame = Instance.new("ScrollingFrame")
    local MessageLabel = Instance.new("TextButton")
    
    MessageFrame.Parent = sc
    MessageFrame.BackgroundColor3 = SelectedTheme[2]
    MessageFrame.BorderColor3 = SelectedTheme[3]
    MessageFrame.BorderSizePixel = 2
    MessageFrame.Position = UDim2.new(position.X.Scale, position.X.Offset, 1.3, position.Y.Offset)
    MessageFrame.Size = size
    MessageFrame.ZIndex = 200
    MessageFrame.CanvasSize = UDim2.new(0, 0)
    
    MessageLabel.Parent = MessageFrame
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextColor3 = SelectedTheme[8]
    MessageLabel.Position = UDim2.new(0.5, -(size.X.Offset / 2), 0, 5)
    MessageLabel.Size = UDim2.new(0, size.X.Offset, 0, 25)
    MessageLabel.Font = Enum.Font.Nunito
    MessageLabel.Text = text
    MessageLabel.RichText = true
    MessageLabel.TextScaled = false
    MessageLabel.ZIndex = 300
    MessageLabel.AutoButtonColor = false
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    MessageFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    
    MessageLabel.MouseButton1Click:Connect(clickevent)
    
    local anim = coroutine.wrap(function() 
        TweenPosition(MessageFrame, UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset), 0.75)
        wait(delay)
        TweenPosition(MessageFrame, UDim2.new(position.X.Scale, position.X.Offset, 1.3, position.Y.Offset), 1, Enum.EasingDirection.In)
        wait(1)
        MessageFrame:Destroy() 
    end)
    anim()
end


local function CreateDropdown(name, params, x, y, bigboy)
    
    local Frame = Instance.new("ScrollingFrame")
    Frame.Parent = Framework.Menu
    Frame.BackgroundColor3 = SelectedTheme[2]
    Frame.BorderColor3 = SelectedTheme[3]
    Frame.Position = UDim2.new(x, 0, 0, y)
    Frame.Size = UDim2.new(0, 340, 0, 25)
    Frame.CanvasSize = UDim2.new(0, 90, 0, 25)
    Frame.ScrollBarImageTransparency = 0.5
    Frame.BackgroundTransparency = 1
    Frame.Active = true
    Frame.Visible = true
    Frame.ZIndex = 435
    Frame.Name = "DDBG"
    
    local Button = Instance.new("TextButton")
    Button.Parent = Framework.Menu
    Button.BackgroundColor3 = SelectedTheme[4]
    Button.BorderColor3 = SelectedTheme[3]
    Button.Position = Frame.Position
    Button.Size = UDim2.new(0, 340, 0, 25)
    Button.Font = Enum.Font.Nunito
    Button.Text = name.." ("..params[params[2] + 2]..") <font size='4'>▼</font>"
    Button.TextColor3 = SelectedTheme[7]
    Button.RichText = true
    Button.TextScaled = true
    Button.ZIndex = 450 
    
    function NewDropdownObject(i)
        local label = Instance.new("TextButton")
        label.Parent = Frame
        label.BackgroundColor3 = SelectedTheme[1]
        label.BorderColor3 = SelectedTheme[3]
        label.BorderSizePixel = 0
        label.Position = UDim2.new(0, 0, 0, (25 * (i - 2)))
        label.Size = UDim2.new(0, 340, 0, 25)
        label.Font = Enum.Font.Nunito
        label.Text = params[i]
        label.TextColor3 = SelectedTheme[7]
        label.TextScaled = false
        label.TextSize = 17
        label.ZIndex = 450
        label.Name = "DDLABEL"
        
        label.MouseButton1Click:Connect(function()
            params[2] = i - 2


            AimbotSpeed = params[2]
            
            TweenSize(Frame, UDim2.new(0, 340, 0, 25), 0.5)
            TweenPosition(Frame, UDim2.new(x, 0, 0, y), 0.5)
            params[1] = false
            Button.Text = name.." ("..params[params[2] + 2]..") <font size='4'>▼</font>"
        end)
    end
    
    for i = 3, table.getn(params) do
        NewDropdownObject(i)
    end
    
    Button.MouseButton1Click:Connect(function()
        params[1] = not params[1]
        if params[1] then
            TweenSize(Frame, UDim2.new(0, 340, 0, ((table.getn(params) - 1) * 25)), 0.75)
            TweenPosition(Frame, UDim2.new(x, 0, 0, y), 0.5)
            Button.Text = name.." ("..params[params[2] + 2]..") <font size='4'>▲</font>"
        else
            TweenSize(Frame, UDim2.new(0, 340, 0, 25), 0.5, Enum.EasingDirection.In)
            TweenPosition(Frame, UDim2.new(x, 0, 0, y), 0.5)
            Button.Text = name.." ("..params[params[2] + 2]..") <font size='4'>▼</font>"
        end
    end)

end



local function TpMouse()
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 2, 0))
end

local function Aimbot()
    ReplicatedStorage.Ball.StartShooting:FireServer()
    if AimbotSpeed == 1 then
        wait(0.5)
        ReplicatedStorage.Ball.EndShooting:InvokeServer(true,"Perfect")
    else
        wait()
        ReplicatedStorage.Ball.EndShooting:InvokeServer(true, "Perfect")
    end
end

--[[Events]]--

Framework.Close.MouseButton1Click:Connect(function()
    TweenPosition(Framework.Bar, UDim2.new(Framework.Bar.Position.X.Scale, Framework.Bar.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    wait(0.25)
    FadeOut(Framework.Bar, 1)
    wait(0.5)
    screen:Destroy()
    
    
    --ContextActionService:UnbindAction("Aimbot")
    pcall(function() aimbconnec:Disconnect() end)
    RunService:UnbindFromRenderStep("Spamthrow")
    RunService:UnbindFromRenderStep("InfStamina")
    RunService:UnbindFromRenderStep("Noslowdown")
    RunService:UnbindFromRenderStep("Auto-grab")
end)

Framework.Bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = true
        Dragging[2] = input.Position
        Dragging[3] = Framework.Bar.Position
    end
end)

Framework.Bar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if Dragging[1] then
            local delta = input.Position - Dragging[2]
            TweenPosition(Framework.Bar, UDim2.new(Dragging[3].X.Scale, Dragging[3].X.Offset + delta.X, Dragging[3].Y.Scale, Dragging[3].Y.Offset + delta.Y), 0.75)
        end
    end
end)






Section1.Button1.MouseButton1Click:Connect(function()
    ButtonStates.Section1[1] = not ButtonStates.Section1[1]
    
    if not ShownAimbotdesc then
        ShownAimbotdesc = true
        Message("<font size='20'>Tap R once to use the aimbot.<br/>Aimbot does not always get the ball in.<br/>If problems persist, switch to a new keybind.</font>", UDim2.new(Framework.Bar.Position.X.Scale, Framework.Bar.Position.X.Offset + 50, Framework.Bar.Position.Y.Scale, Framework.Bar.Position.Y.Offset - 125), UDim2.new(0, 300, 0, 100), 6)
    end
    
    
    if ButtonStates.Section1[1] then
        OpenObject(Section1.Button1, 0.5)
        
        
        
        local aimbconnec = UserInputService.InputBegan:connect(function(e)
            if e.KeyCode == Hotkeys.Aimbot then
                Aimbot()
            end
        end)

        --ContextActionService:BindAction("Aimbot", (function(a, b) if b == Enum.UserInputState.Begin then Aimbot() end end), false, Hotkeys.Aimbot)
    else
        CloseObject(Section1.Button1, 0.5)
        
        pcall(function() aimbconnec:Disconnect() end)
    end
end)

Section1.Button2.MouseButton1Click:Connect(function()
    ButtonStates.Section1[2] = not ButtonStates.Section1[2]
    if ButtonStates.Section1[2] then
        OpenObject(Section1.Button2, 0.5)
        
        RunService:BindToRenderStep("Spamthrow", Enum.RenderPriority.Character.Value + 1, function()
            ReplicatedStorage.Ball.StartShooting:FireServer();
            ReplicatedStorage.Ball.EndShooting:InvokeServer(true, "Perfect");
        end)
    else
        CloseObject(Section1.Button2, 0.5)
        
        RunService:UnbindFromRenderStep("Spamthrow")
        
    end
end)

Section1.Button3.MouseButton1Click:Connect(function()
    ButtonStates.Section1[3] = not ButtonStates.Section1[3]
    if ButtonStates.Section1[3] then
        OpenObject(Section1.Button3, 0.5)
        
        
        
        for i,v in pairs(game.Workspace:GetDescendants()) do 
            if v:IsA("BasePart") and v.Name == "Basketball" then
                CreateESP(v, "")
                v.Mesh.VertexColor = Vector3.new(0, 1, 0)
            end
        end
    else
        CloseObject(Section1.Button3, 0.5)
        
        for i,v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "HEspInstance" then
                v.Parent.Mesh.VertexColor = Vector3.new(0.525, 0.278, 0.241)
                v:Destroy()
            end
        end
    end
end)

Section2.Button1.MouseButton1Click:Connect(function()
    ReplicatedStorage.Ball.Layup:FireServer("Layup") 
end)

Section2.Button2.MouseButton1Click:Connect(function()
    plr.PlayerScripts.Events.Ball.SetDribblingState:Fire(true)
end)

Section3.Button1.MouseButton1Click:Connect(function()
    ButtonStates.Section3[1] = not ButtonStates.Section3[1]
    if ButtonStates.Section3[1] then
        OpenObject(Section3.Button1, 0.5)
        
        RunService:BindToRenderStep("InfStamina", Enum.RenderPriority.Character.Value + 1, function()
        	pcall(function() plr.PlayerScripts.Events.Player.Stamina.Stamina.Value = 6969 end)
        end)
    else
        CloseObject(Section3.Button1, 0.5)
        
        RunService:UnbindFromRenderStep("InfStamina")
    end
end)

Section3.Button2.MouseButton1Click:Connect(function()
    ButtonStates.Section3[2] = not ButtonStates.Section3[2]
    if ButtonStates.Section3[2] then
        OpenObject(Section3.Button2, 0.5)
        
        RunService:BindToRenderStep("Noslowdown", Enum.RenderPriority.Character.Value + 1, function()
        	plr.PlayerScripts.Events.Player.DisableControls:Fire(false)
        	if plr.Character.Humanoid.WalkSpeed < 16 then
        	    plr.Character.Humanoid.WalkSpeed = 16
        	end
        end)
    else
        CloseObject(Section3.Button2, 0.5)
        
        RunService:UnbindFromRenderStep("Noslowdown")
    end
end)




Section3.Button3.MouseButton1Click:Connect(function()
    ButtonStates.Section3[3] = not ButtonStates.Section3[3]
    if ButtonStates.Section3[3] then
        OpenObject(Section3.Button3, 0.5)
        
        tpconnec = UserInputService.InputBegan:Connect(function(inputobject) 
            if inputobject.UserInputType == Enum.UserInputType.MouseButton1 and inputobject:IsModifierKeyDown(Enum.ModifierKey.Ctrl) then 
                TpMouse()
            end
        end)
    else
        CloseObject(Section3.Button3, 0.5)
        
        tpconnec:Disconnect()
    end
end)

Section3.Button4.MouseButton1Click:Connect(function()
    ButtonStates.Section3[4] = not ButtonStates.Section3[4]
    if not ShownStealdesc then
        ShownStealdesc = true
        Message("<font size='20'>Spam steal when next to the person<br/>with the ball, and you should pick it up<br/>automatically</font>", UDim2.new(Framework.Bar.Position.X.Scale, Framework.Bar.Position.X.Offset + 50, Framework.Bar.Position.Y.Scale, Framework.Bar.Position.Y.Offset - 125), UDim2.new(0, 300, 0, 100), 3)
    end
    if ButtonStates.Section3[4] then
        OpenObject(Section3.Button4, 0.5)
        
        if basketballinstance == nil then
            for i,v in pairs(game.Workspace:GetDescendants()) do 
                if v:IsA("BasePart") and v.Name == "Basketball" then
                    basketballinstance = v
                    break
                end
            end
        else
            RunService:BindToRenderStep("Auto-grab", Enum.RenderPriority.Character.Value + 1, function()
                pcall(function() firetouchinterest(plr.Character.Head, basketballinstance, 1) end)
                wait()
                pcall(function() firetouchinterest(plr.Character.Head, basketballinstance, 0) end)
            end)
        end
    else
        CloseObject(Section3.Button4, 0.5)
        
        RunService:UnbindFromRenderStep("Auto-grab")
    end
end)

Section3.Button5.MouseButton1Click:Connect(function()
    ButtonStates.Section3[5] = not ButtonStates.Section3[5]
    if ButtonStates.Section3[5] then
        OpenObject(Section3.Button5, 0.5)
        
        --plr.Character["Right Arm"].Size     = Vector3.new(8,5,5)
        --plr.Character["Left Arm"].Size      = Vector3.new(8,5,5)
        --plr.Character["Right Leg"].Size     = Vector3.new(8,2,5)
        --plr.Character["Left Leg"].Size      = Vector3.new(8,2,5)
        --plr.Character["Torso"].Size         = Vector3.new(5,5,5)
        plr.Character.HumanoidRootPart.Size = Vector3.new(7.5,2,7.5)
        plr.Character.HumanoidRootPart.Transparency = 0.5
    
    else
        CloseObject(Section3.Button5, 0.5)
        
        --plr.Character["Right Arm"].Size     = Vector3.new(1,2,1)
        --plr.Character["Left Arm"].Size      = Vector3.new(1,2,1)
        --plr.Character["Right Leg"].Size     = Vector3.new(1,2,1)
        --plr.Character["Left Leg"].Size      = Vector3.new(1,2,1)
        --plr.Character["Torso"].Size         = Vector3.new(2,2,1)
        plr.Character.HumanoidRootPart.Size = Vector3.new(2,2,1)
        plr.Character.HumanoidRootPart.Transparency = 1
        
    end
end)


Section4.Button1.FocusLost:Connect(function()
    local txt = Section4.Button1.Text
    local ptxt = txt:gsub("[^a-z,0-9]",""):sub(1,1)
    
    if ptxt == "" then
        Hotkeys.Aimbot = Enum.KeyCode.R
        Section4.Button1.Text = "Aimbot trigger keybind: R"
        return
    end
    local kctx = Enum.KeyCode[ptxt:upper()]
    Section4.Button1.Text = "Aimbot trigger keybind: "..ptxt:upper()
    Hotkeys.Aimbot = kctx
    
    
    ContextActionService:UnbindAction("Aimbot")
    if ButtonStates.Section1[1] then
        ContextActionService:BindAction("Aimbot", (function(a, b) if b == Enum.UserInputState.Begin then Aimbot() end end), false, Hotkeys.Aimbot)
    end
end)


--[[Finalization]]--

for i,v in pairs(VerticalPositions) do
    local Frame = Instance.new("Frame")
    Frame.Parent = Framework.Menu
    Frame.BackgroundColor3 = SelectedTheme[3]
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.5, -150, 0, v[1] - 10)
    Frame.Size = UDim2.new(0, 285, 0, 2)
    Frame.Visible = true
    Frame.ZIndex = 435
    --local Frame = Instance.new("Frame")
    --Frame.Parent = Framework.Menu
    --Frame.BackgroundColor3 = SelectedTheme[3]
    --Frame.BorderSizePixel = 0
    --Frame.Position = UDim2.new(0.5, -150, 0, v[1] - 45)
    --Frame.Size = UDim2.new(0, 285, 0, 2)
    --Frame.Visible = true
    --Frame.ZIndex = 435
end


if SelectedTheme == Theme_Space then
    AddStars(250)
end
CreateDropdown("Aimbot speed",{false, 2, "Instant", "Realistic"}, 0.05, VerticalPositions.Section1[2], true)



for i,v in pairs(screen:GetDescendants()) do
    v.BorderSizePixel = 0
    if v:IsA("ImageLabel") or v.Name == "DDBG" then
        
    else
        local e = Instance.new("UICorner")
        e.Parent = v
        e.CornerRadius = UDim.new(0, 10)
    end
end


if game.PlaceId == 360589910 then
    TweenPosition(Framework.Bar, UDim2.new(0.65, 0, 0.7, 0), 0.75)
    Message("<font size='20'>Loaded Hoops GUI v"..version.."</font><br/><font size='15'>-Added instant aimbot mode<br/>-Made aimbot rebindable<br/>-Added hitbox expander<br/>-Probably fixed a few bugs<br/>-Added click to layup<br/>-Improved noslowdown<br/>-Added pass to self</font><br/><br/><font size='20'>Want to join the discord?<br/>Click to copy the invite!<br/><b>https://discord.gg/a3JEr9Z6jY</b></font>", UDim2.new(0.875, 0, 0.75, 0), UDim2.new(0, 200, 0, 200), 4, (function() setclipboard("https://discord.gg/a3JEr9Z6jY") end))
else
    Message("<font size='20'>Not in the Hoops <br/>game; click to copy<br/>game link</font>", UDim2.new(0.8, 0, 0.89, 0), UDim2.new(0, 200, 0, 75), 5, function() setclipboard("https://www.roblox.com/games/360589910/Hoops-Demo-Basketball") end)
    wait(5)
    screen:Destroy()
end


return nil
