--[[Hoops Macro Tool]]--
--[[Made by topit ]]--

--Lets you customize the delay for an autogreen macro
--Requires a compatible exploit with keypress and keyrelease
--Krnl and synapse are 100% supported, but some other exploits may support these functions

loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/jtags.lua'))()
JFR = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/lib.lua'))()


local ctx = game:GetService("ContextActionService")
local run = game:GetService("RunService")
local thread = function(e) coroutine.resume(coroutine.create(e)) end
local kp = keypress
local kr = keyrelease

local hotkey = Enum.KeyCode.G
local delay = 505
local current = true 



local function Run()
    kp(0x52)
    wait(delay/1000)
    kr(0x52)
end

function TextAnim()
    scantext.TextColor3 = Color3.fromRGB(0, 255, 255)
    JFR.TweenCustom(scantext, {TextColor3 = JFR.Theme.text}, 0.75) 
end


local scriptversion = "0.1.0"
local plr = game.Players.LocalPlayer


local hotkeytables = {PageDown = "PDn",PageUp = "PUp",RightShift = "<font size='15'>RShift</font>",LeftShift = "<font size='15'>LShift</font>",Return = "<font size='15'>REnter</font>",KeypadEnter = "<font size='15'>KPEnt</font>",KeypadOne = "KP1",KeypadTwo = "KP2",KeypadThree = "KP3",KeypadFour = "KP4",KeypadFive = "KP5",KeypadSix = "KP6",KeypadSeven = "KP7",KeypadEight = "KP8",KeypadNine = "KP9",KeypadZero = "KP0",CapsLock = "<font size='15'>Caps</font>",LeftAlt = "<font size='15'>LAlt</font>",RightAlt = "<font size='15'>RAlt</font>",RightControl = "<font size='15'>RCtrl</font>",LeftControl = "<font size='15'>LCtrl</font>",QuotedDouble = "<font size='15'>Quote</font>",Space = "<font size='15'>Spc</font>",Escape = "<font size='15'>Esc</font>",Delete = "<font size='15'>Del</font>"}

local bindto = function(name, value,func) 
    name = name or "nil"
    value = value or Enum.RenderPriority.Character.Value + 2
    RunService:BindToRenderStep(name,value,func)
end
local unbindfrom = function(name)
    name = name or "nil"
    RunService:UnbindFromRenderStep(name) 
end

local bindaction = function(name, func, key)
    ctx:BindAction(name, function(a, b) if b == Enum.UserInputState.Begin then func() end end, false, key) 
end

local unbindaction = function(name)
    ctx:UnbindAction(name)

end

local newhotkey = function(name, parent, args, bound)
    local f = JFR.NewTextBox(name.."Hotkey", parent, args, function() 
        
        local tb = JFR.GetInstance(name.."Hotkey")
        local t = tb.Text
        if t:len() == 1 then
            t = t:upper() 
        end
        
        if pcall(function() return Enum.KeyCode[t] end) then
            h = Enum.KeyCode[t]
            if ("Hotkey: "..h.Name):len() >= 13 then
                local temp = h.Name:gsub("%l","", 4)
                    
                if hotkeytables[h.Name] then
                    tb.Text = "Hotkey: "..hotkeytables[h.Name]
                else
                    tb.Text = "Hotkey: <font size='"..tostring(20 - temp:len()).."'>"..temp.."</font>"
                
                end
            else
                tb.Text = "Hotkey: "..h.Name
            end
            
            hotkey = h
            bound()
        else
            tb.Text = "No hotkey"
            unbindaction(name.."Hotkey")
            
            hotkey = nil
            bound()
        end
    end)
    
end

local function NewSelector(size, place, parent)
    size = size or 7 
    place = place or 0
    parent = parent or nil
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6956257983"
    f.Size = UDim2.new(0, size, 0, size)
    f.Position = UDim2.new(0, place, 0, 0)
    f.BackgroundTransparency = 1
    f.ZIndex = 280    
    f.Parent = parent
    return f
end

local function NewlineOnLabel(inst)
    JFR.NewBoard("", inst.Parent, {Position = UDim2.new(0, 30 + inst.TextBounds.X, 0, inst.Position.Y.Offset+12.5), Size = UDim2.new(0, 360 - inst.TextBounds.X,0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function NewLine(inst, y)
    JFR.NewBoard("", inst, {Position = UDim2.new(0, 10, 0, y), Size = UDim2.new(0, 380, 0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function StartGradient(parent, y, x)
    x = x or 400
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
    x = x or 400
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
screen.Name = "autogreen-"..scriptversion

--Background
local bg = JFR.NewBoard("no", screen, {Position = UDim2.new(0.7, 0, 1.3, 0), Size = UDim2.new(0, 500, 0, 250), Nodrag = true}, true)
local parentb = JFR.GetParentBoard()



--Extra gui stuff
JFR.NewText("Title", bg, {Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 400, 0, 25), Text = "Hoops Macro tool <font size='15'>v"..scriptversion.."</font>", TextSize = 35, TextYAlignment = Enum.TextYAlignment.Center})
JFR.NewBoard("Shadow", bg, {ZIndex = 0, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 500, 0, 265), BackgroundTransparency = 0.3, BackgroundColor3 = JFR.Theme.shadow})
JFR.NewBoard("Roundedbottom1", bg, {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(0, 125, 0, 25), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewBoard("Roundedbottom2", bg, {Position = UDim2.new(0, 100, 1, -10), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade3, Unroundify = true})
JFR.NewBoard("Roundedbottom3", bg, {Position = UDim2.new(0, 115, 1, -10), Size = UDim2.new(0, 385, 0, 25), BackgroundColor3 = JFR.Theme.shade3})
JFR.NewBoard("Outline2", bg, {Position = UDim2.new(0, 0, 0, 50), Size = UDim2.new(0, 500, 0, 2), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})


--Menus
local page = JFR.NewMenu("Page", bg, {Size = UDim2.new(0, 500, 0, 200), Position = UDim2.new(0, 0, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 200), Invisible = false})

JFR.NewText("Title", page, {Position = UDim2.new(0, 15, 1, -35), Size = UDim2.new(0, 400, 0, 20), Text = "Made by topit", TextSize = 25})
scantext = JFR.NewText("Scantext", page, {Position = UDim2.new(0, 15, 1, -75), Size = UDim2.new(0, 400, 0, 20), Text = "Macro not hooked", TextSize = 25})


JFR.NewButton("MinimizeButton", bg, {Position = UDim2.new(1, -60, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "-", TextSize = 14}, {
    on = function()
        JFR.GetInstance("MinimizeButton").Text = "+"
        JFR.TweenSize(parentb, UDim2.new(0, parentb.Size.X.Offset, 0, 50), 0.75, Enum.EasingDirection.Out)
        JFR.TweenSize(JFR.GetInstance("Shadow"), UDim2.new(0, parentb.Size.X.Offset, 0, 50), 0.75, Enum.EasingDirection.Out)
        
        local function YoMom(a)
            JFR.Async(function() 
                JFR.TweenSize(a, UDim2.new(a.Size.X.Scale, a.Size.X.Offset, a.Size.Y.Scale, 0), 0.75, Enum.EasingDirection.Out)
                wait(0.75)
                if a.Size.Y.Offset == 0 then 
                    a.Visible = false
                end
            end)
        end
        YoMom(JFR.GetInstance("Page"))
        
        YoMom(JFR.GetInstance("Roundedbottom3"))
        YoMom(JFR.GetInstance("Roundedbottom2"))
        YoMom(JFR.GetInstance("Roundedbottom1"))
        
        YoMom(JFR.GetInstance("Outline2"))

    end,
    off = function() 
        JFR.GetInstance("MinimizeButton").Text = "-"
        local function YorMom(a, y)
            JFR.Async(function()
                a.Visible = true
                JFR.TweenSize(a, UDim2.new(a.Size.X.Scale, a.Size.X.Offset, a.Size.Y.Scale, y), 0.75, Enum.EasingDirection.Out)
            end)
        end
        
        JFR.TweenSize(parentb, UDim2.new(0, parentb.Size.X.Offset, 0, 250), 0.75, Enum.EasingDirection.Out)
        JFR.TweenSize(JFR.GetInstance("Shadow"), UDim2.new(0, parentb.Size.X.Offset, 0, 265), 0.75, Enum.EasingDirection.Out)
    

        YorMom(JFR.GetInstance("Page"), 200)
    
        YorMom(JFR.GetInstance("Roundedbottom1"), 25)
        YorMom(JFR.GetInstance("Roundedbottom2"), 25)
        YorMom(JFR.GetInstance("Roundedbottom3"), 25)
        
        YorMom(JFR.GetInstance("Outline2"), 2)


    end
})

JFR.NewButton("CloseButton", bg, {Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "X", TextSize = 14}, {on = function()
    JFR.TweenPosition(parentb, UDim2.new(parentb.Position.X.Scale, parentb.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    JFR.TweenCustom(parentb, {Size = UDim2.new(0, parentb.Size.X.Offset, 0, 0)}, 0.75, Enum.EasingDirection.In)
    wait(0.25)
    JFR.FadeOut(parentb, 1)
    wait(0.5)
    screen:Destroy() 
    
    ctx:UnbindAction("GreenMacro")
    current = false
end})


StartGradient(JFR.GetInstance("Page"), nil, 500)
EndGradient(JFR.GetInstance("Page"), nil, 500)


y=5;
JFR.NewText("SpeedText1", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Modules", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("SpeedText1"))
y=y+30;

JFR.NewButton("Macro", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 420, 0, 25), Text = "Hook macro", TextSize = 20}, {on = function() 
    if hotkey == nil then
        TextAnim()
        scantext.Text = "Macro not hooked; add a hotkey"
        
        JFR.SetInstanceValue("Macro", false)
        JFR.CloseObject(JFR.GetInstance("Macro"))
        return
    end
    
    ctx:BindAction("GreenMacro", function() JFR.Async(function() Run() end) end, false, hotkey)
    
    TextAnim()
    scantext.Text = "Hooked macro"
end, off = function() 
    ctx:UnbindAction("GreenMacro")
    
    TextAnim()
    scantext.Text = "Unhooked macro"
end})
y=y+30
newhotkey("Macro", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 420, 0, 25), Text = "Macro hotkey: G", ClearTextOnFocus = true}, function() 
    TextAnim()
    scantext.Text = "Unhooking macro..."
    
    ctx:UnbindAction("GreenMacro")
    if hotkey == nil then
        TextAnim()
        scantext.Text = "Macro not hooked; add a hotkey"
        
        JFR.SetInstanceValue("Macro", false)
        JFR.CloseObject(JFR.GetInstance("Macro"))
    else
        ctx:BindAction("GreenMacro", function() JFR.Async(function() Run() end) end, false, hotkey)
        
        TextAnim()
        scantext.Text = "Hooked macro with hotkey "..hotkey.Name
        
        JFR.SetInstanceValue("Macro", true )
        JFR.OpenObject(JFR.GetInstance("Macro"))
    end
end)
y=y+30
JFR.NewTextBox("Delay", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 420, 0, 25), Text = "Macro delay (ms): 505", TextSize = 20, ClearTextOnFocus = true}, function() 
    local txt = JFR.GetInstance("Delay").Text
    delay = tonumber(txt:gsub("%D",""):sub(1,3))
    
    JFR.GetInstance("Delay").Text = "Macro delay (ms): "..tostring(delay)
end)

y=y+30

JFR.NewButton("Ball", page, {Position = UDim2.new(0.715, 0, 0, y), Size = UDim2.new(0, 100, 0, 25), Text = "Grab ball", TextSize = 20}, {on = function() 
    if pcall(function() return plr.Character.Head end) then
        local cf = plr.Character.HumanoidRootPart.CFrame
        local bawl = game.ReplicatedStorage.GameBall.Value
        
        if pcall(function() return game.Workspace["RestrictedCircle"].Display end) then
            for i = 0, 5 do 
                plr.Character.HumanoidRootPart.CFrame = cf
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.RestrictedCircle.Position + Vector3.new(0,1.5, 0))
            end
            wait(0.7)
        else
            for i = 0, 10 do
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(bawl.Position)
                firetouchinterest(plr.Character.Head, bawl, 1)
                firetouchinterest(plr.Character.Head, bawl, 0)
                wait()
            end
        end
        
        wait()
        for i,v in pairs(plr.Character:GetDescendants()) do
            pcall(function() v.Velocity = Vector3.new(0,0,0) v.RotVelocity = Vector3.new(0, 0, 0) end) 
        end
        plr.Character.HumanoidRootPart.CFrame = cf
        
        
    end
end})

local dragarea = Instance.new("Frame")
dragarea.Size = UDim2.new(0, 500, 0, 50)
dragarea.Position = UDim2.new(0, 0, 0, 0)
dragarea.Parent = parentb
dragarea.BackgroundTransparency = 1 
dragarea.BorderSizePixel = 0 

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
JFR.Ready()


local overwrited = false
while current do 
    wait(10)
    JFR.Async(function() 
        TextAnim()
        scantext.Text = "Scanning for macro overwrites..."
        wait(0.5)
        local f = ctx:GetAllBoundActionInfo()
        for i1,v1 in pairs(f) do
            for i2,v2 in pairs(v1.inputTypes) do
                if v2 == Enum.KeyCode.G and i1 ~= "GreenMacro" then
                    scantext.Text = "Overwrite found! Rehooking macro..."
                    wait(1)
                    ctx:UnbindAction(i1)
                    ctx:BindAction("GreenMacro", function() JFR.Async(function() Run() end) end, false, hotkey)
                    scantext.Text = "Rehooked macro after scan"
                    overwrited = true
                    break
                end
            end
            if overwrited == true then
                break
            end    
        end
        
        if not overwrited then
            scantext.Text = "No macro overwrites were found"
        else
            scantext.Text = "Rehooked macro after scan"
        end
    end)
    overwrited = false
end