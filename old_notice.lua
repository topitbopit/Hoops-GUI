local ts = game:GetService("TweenService")
local plr = game.Players.LocalPlayer

local function twn(object, dest, delay, direction, style)
    delay = delay or 0.5
    direction = direction or "Out"
    style = style or "Exponential"
    
    local t = ts:Create(object, TweenInfo.new(delay, Enum.EasingStyle[style], Enum.EasingDirection[direction]), dest)
    t:Play()
    return t
end

local function tl(parent, max, min) 
    local a = Instance.new("UITextSizeConstraint")
    a.MaxTextSize = max or 35
    a.MinTextSize = min or 19
    a.Parent = parent
end

local function p(parent, h)
    local a = Instance.new("UIPadding")
    a.Parent = parent
    a.PaddingTop = UDim.new(0, h)
end
    
    
local s = Instance.new("ScreenGui")
s.Parent = game.CoreGui

local a = Instance.new("Frame")
a.Size = UDim2.new(0.3, 0, 0.3, 0)
a.Position = UDim2.new(0.35, 0, 1, 0)
a.BorderSizePixel = 0
a.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
a.Parent = s

local b = Instance.new("Frame")
b.Size = UDim2.new(1, 0, 0.15, 0)
b.Position = UDim2.new(0, 0, 0, 0)
b.BorderSizePixel = 0
b.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
b.Parent = a

local c = Instance.new("TextLabel")
c.Text = "All pre-2.0.0 jeff hoops versions have been deprecated."
c.TextScaled = true
c.TextColor3 = Color3.new(1, 1, 1)
c.Size = UDim2.new(1, 0, 1, 0)
c.Position = UDim2.new(0, 0, 0, 0)
c.BackgroundTransparency = 1
c.Font = Enum.Font.SourceSansLight
c.Parent = b

local l = Instance.new("TextButton")
l.Text = "X"
l.AnchorPoint = Vector2.new(1, 0)
l.TextScaled = true
l.TextColor3 = Color3.new(1, 1, 1)
l.Size = UDim2.new(0.2, 0, 1, 0)
l.Position = UDim2.new(1, 0, 0, 0)
l.BackgroundTransparency = 1
l.Font = Enum.Font.SourceSansLight
l.Parent = b

local i = Instance.new("UIAspectRatioConstraint")
i.Parent = l

local d = Instance.new("TextLabel")
d.Text = "Join the new discord for the latest script"
d.TextScaled = true
d.TextColor3 = Color3.new(1, 1, 1)
d.Size = UDim2.new(1, 0, 0.1, 0)
d.Position = UDim2.new(0, 0, 0.3, 0)
d.BackgroundTransparency = 1
d.Font = Enum.Font.SourceSansLight
d.Parent = a

local e = Instance.new("TextLabel")
e.Text = "Or just use the updated link"
e.TextScaled = true
e.TextColor3 = Color3.new(1, 1, 1)
e.Size = UDim2.new(1, 0, 0.1, 0)
e.Position = UDim2.new(0, 0, 0.55, 0)
e.BackgroundTransparency = 1
e.Font = Enum.Font.SourceSansLight
e.Parent = a

local f = Instance.new("TextLabel")
f.Text = "Thanks for using jeff hoops!"
f.TextScaled = true
f.TextColor3 = Color3.new(1, 1, 1)
f.Size = UDim2.new(1, 0, 0.1, 0)
f.Position = UDim2.new(0, 0, 0.85, 0)
f.BackgroundTransparency = 1
f.Font = Enum.Font.SourceSansLight
f.Parent = a

local g = Instance.new("TextBox")
g.Text = "https://discord.gg/Gn9vWr8DJC"
g.TextScaled = true
g.TextColor3 = Color3.new(1, 1, 1)
g.Size = UDim2.new(0.4, 0, 0.1, 0)
g.Position = UDim2.new(0.3, 0, 0.4, 0)
g.BackgroundTransparency = 0
g.BorderSizePixel = 0
g.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
g.Font = Enum.Font.SourceSansLight
g.ClearTextOnFocus = false
g.Parent = a

local h = Instance.new("TextBox")
h.Text = "loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Hoops-GUI/main/script.lua'))()"
h.TextScaled = true
h.TextColor3 = Color3.new(1, 1, 1)
h.Size = UDim2.new(0.9, 0, 0.1, 0)
h.Position = UDim2.new(0.05, 0, 0.65, 0)
h.BackgroundTransparency = 0
h.BorderSizePixel = 0
h.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
h.Font = Enum.Font.SourceSansLight
h.ClearTextOnFocus = false
h.Parent = a

local i = Instance.new("Frame")
i.Size = UDim2.new(1, 0, 0, 10)
i.Position = UDim2.new(0, 0, 1, -10)
i.BackgroundTransparency = 0
i.BorderSizePixel = 0
i.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
i.Parent = a


tl(c, 26, 0)
tl(d, 23, 0)
tl(e, 23, 0)

tl(f, 23, 0)
tl(g, 23, 0)

twn(a, {Position = UDim2.new(0.35, 0, 0.35, 0)})
twn(i, {Size = UDim2.new(0, 0, 0, 10)}, 20, "Out", "Linear")

l.MouseButton1Click:Connect(function() 
    
    twn(i, {Size = UDim2.new(0, 0, 0, 10)})
    wait(0.12)
    twn(a, {Position = UDim2.new(0.35, 0, 1, 0)}, nil, "In")
    wait(1)
    s:Destroy()
end)

wait(20)


twn(a, {Position = UDim2.new(0.35, 0, 1, 0)}, nil, "In")
wait(2)

s:Destroy()

