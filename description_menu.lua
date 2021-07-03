local JFR = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/lib.lua'))()






local function NewlineOnLabel(inst)
    JFR.NewBoard("", inst.Parent, {Position = UDim2.new(0, 30 + inst.TextBounds.X, 0, inst.Position.Y.Offset+12.5), Size = UDim2.new(0, 360 - inst.TextBounds.X,0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function NewLine(inst, y)
    JFR.NewBoard("", inst, {Position = UDim2.new(0, 10, 0, y), Size = UDim2.new(0, 380, 0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function StartGradient(parent, y, x)
    x = x or 500
    y = y or 2
    
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6947150722"
    f.Position = UDim2.new(0, 0, 0, y)
    f.Parent = parent
    f.Size = UDim2.new(0, x, 0, 50)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 125
end
local function EndGradient(parent, y, x)
    x = x or 500
    y = y or -50
    
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6947474904"
    f.Position = UDim2.new(0, 0, 1, y)
    f.Parent = parent
    f.Size = UDim2.new(0, x, 0, 50)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 125
end

JFR.SetFont(Enum.Font["Nunito"])
JFR.SetBold(false)
JFR.SetRoundAmount(7)
JFR.SetRoundifyEnabled(true)

local num = math.random(7, 10) / 10
JFR.SetTheme({r = num, g = num, b = num + (math.random(1,4) / 10)})



--init y values
local y = 15;

--Screen gui
local screen = JFR.GetScreen()
screen.Name = "jhoops_desc-fuckoff"

--Background
local bg = JFR.NewBoard("no", screen, {Position = UDim2.new(0.5, -250, 1.2, -200), Size = UDim2.new(0, 500, 0, 400), Nodrag = true}, true)
local parentb = JFR.GetParentBoard()



--Extra gui stuff
JFR.NewText("a", bg, {Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 400, 0, 25), Text = "Jeff Hoops information", TextSize = 35, TextYAlignment = Enum.TextYAlignment.Center})
JFR.NewBoard("b", bg, {ZIndex = 0, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 500, 0, 415), BackgroundTransparency = 0.3, BackgroundColor3 = JFR.Theme.shadow})
JFR.NewBoard("c", bg, {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(0, 500, 0, 25), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewBoard("d", bg, {Position = UDim2.new(0, 0, 0, 50), Size = UDim2.new(0, 500, 0, 2), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})


--Menus
local e = JFR.NewMenu("e", bg, {Size = UDim2.new(0, 500, 0, 350), Position = UDim2.new(0, 0, 0, 50), CanvasSize = UDim2.new(0, 100, 0, 5555), Invisible = false, AnchorPoint = Vector2.new(0, 0)})

JFR.NewText("g", e, {Position = UDim2.new(0, 5, 0, -15), Size = UDim2.new(0, 400, 0, 5555), Text = "$noshadowLoading...", ZIndex = 190, TextSize = 25})

JFR.NewButton("f", bg, {Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "X", TextSize = 14}, {on = function()
    JFR.TweenPosition(parentb, UDim2.new(parentb.Position.X.Scale, parentb.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    JFR.TweenCustom(parentb, {Size = UDim2.new(0, parentb.Size.X.Offset, 0, 0)}, 0.75, Enum.EasingDirection.In)
    wait(0.25)
    JFR.FadeOut(parentb, 1)
    wait(0.5)
    screen:Destroy() 

end})


StartGradient(JFR.GetInstance("e"), nil, 500)
EndGradient(JFR.GetInstance("e"), nil, 500)



local dragarea = Instance.new("Frame")
dragarea.Size = UDim2.new(0, 500, 0, 50)
dragarea.Position = UDim2.new(0, 0, 0, 0)
dragarea.Parent = parentb
dragarea.BackgroundTransparency = 1
dragarea.BorderSizePixel = 0 
dragarea.ZIndex = 1235
local temp = {}
dragarea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        temp[1] = true
        temp[2] = parentb.Position
        
        tdc3 = game:GetService("UserInputService").InputChanged:Connect(function(input2)
            if input2.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input2.Position - input.Position

                JFR.TweenPosition(parentb, UDim2.new(temp[2].X.Scale, temp[2].X.Offset + delta.X, temp[2].Y.Scale, temp[2].Y.Offset + delta.Y), 0.75)
            end
        end)
    end
end)

dragarea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        temp[1] = false
        tdc3:Disconnect()
        
    end
end)
JFR.Ready(UDim2.new(0.5, -250, 0.5, -200))

JFR.GetInstance("g").Text = game:HttpGet("https://raw.githubusercontent.com/topitbopit/Hoops-GUI/main/help_information.txt")
