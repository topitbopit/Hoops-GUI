loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/jtags.lua'))()
local JFR = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/lib.lua'))()



local scriptversion = "1.1.1"
local plr = game.Players.LocalPlayer

local uis = game:GetService("UserInputService")
local rimpositions = require(game.ReplicatedStorage.Modules.RimPositions)


local stop = false

local function message(message)
    local a = Instance.new("Part")
    a.CanCollide = false
    a.Anchored = true
    a.Parent = game.Workspace
    a.Size = Vector3.new(1, 1, 1)
    a.Position = plr.Character.Head.Position
    a.Transparency = 1 
    
    local b = Instance.new("BillboardGui")
    b.Parent = a
    b.Size = UDim2.new(3, 0, 1, 0)
    b.AlwaysOnTop = true
    
    local c = Instance.new("TextLabel")
    c.Font = Enum.Font.Nunito
    c.TextScaled = true
    c.Text = message
    c.Size = UDim2.new(1, 0, 1, 0)
    c.BackgroundTransparency = 1
    c.TextColor3 = Color3.fromRGB(255, 255, 255)
    c.TextStrokeTransparency = 0
    c.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    c.Parent = b 
    
    JFR.Async(function() 
        JFR.TweenCustom(a, {Position = a.Position + Vector3.new(0, 1.5, 0)}, 1.5) 
        wait(1.5)
        a:Destroy()
    end)
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
screen.Name = "sussy-"..scriptversion

--Background
local bg = JFR.NewBoard("no", screen, {Position = UDim2.new(0.7, 0, 1.3, 0), Size = UDim2.new(0, 300, 0, 250), Nodrag = true}, true)
local parentb = JFR.GetParentBoard()



--Extra gui stuff
JFR.NewText("Title", bg, {Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 200, 0, 25), Text = "Hoops dunk anims <font size='15'>v"..scriptversion.."</font>", TextSize = 35, TextYAlignment = Enum.TextYAlignment.Center})
JFR.NewBoard("Shadow", bg, {ZIndex = 0, Position = UDim2.new(0, 3.5, 0, 3), Size = UDim2.new(0, 300, 0, 265), BackgroundTransparency = 0.3, BackgroundColor3 = JFR.Theme.shadow})
JFR.NewBoard("Roundedbottom1", bg, {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(0, 300, 0, 25), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewBoard("Outline2", bg, {Position = UDim2.new(0, 0, 0, 50), Size = UDim2.new(0, 300, 0, 2), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})


--Menus
local page = JFR.NewMenu("Page", bg, {Size = UDim2.new(0, 300, 0, 200), Position = UDim2.new(0, 0, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 580), Invisible = false})

JFR.NewText("sussy", page, {Position = UDim2.new(0, 15, 1, -35), Size = UDim2.new(0, 400, 0, 20), Text = "Made by topit", TextSize = 25})
JFR.NewText("baka", page, {Position = UDim2.new(0, 15, 1, -85), Size = UDim2.new(0, 200, 0, 800), Text = " BTB and one handed may be a bit buggy.<br/>If an animation isn&apos;t included, it most likely is<br/>too inconsistent, or will be added in the future.", TextSize = 15})



JFR.NewButton("CloseButton", bg, {Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "X", TextSize = 14}, {on = function()
    JFR.TweenPosition(parentb, UDim2.new(parentb.Position.X.Scale, parentb.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    JFR.TweenCustom(parentb, {Size = UDim2.new(0, parentb.Size.X.Offset, 0, 0)}, 0.75, Enum.EasingDirection.In)
    wait(0.25)
    JFR.FadeOut(parentb, 1)
    wait(0.5)
    screen:Destroy() 


    pcall(function()  connection720:Disconnect() end)
    pcall(function()  connection360:Disconnect() end)
    pcall(function()  connection180:Disconnect() end)
    
    pcall(function()   connection1n:Disconnect() end)
    pcall(function() connection1720:Disconnect() end)
    pcall(function() connection1360:Disconnect() end)
    pcall(function() connection1180:Disconnect() end)
    
    pcall(function() connectionbtbn:Disconnect() end)
    pcall(function() connectionb720:Disconnect() end)
    pcall(function() connectionb360:Disconnect() end)
    
    pcall(function() connectionmars:Disconnect() end)
end})


StartGradient(JFR.GetInstance("Page"), nil, 500)
EndGradient(JFR.GetInstance("Page"), nil, 500)


y=5;
JFR.NewText("a", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Normal", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("a"))
y=y+30;

JFR.NewButton("720", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "720 dunks", TextSize = 20}, {
    on = function() 
        connection720 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()
                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -500)
                spin.Force = Vector3.new(85, 0, 0)

                wait(0.5)

                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2500
                pos.D = 125
                pos.MaxForce = Vector3.new(12345, 12345, 12345)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 1.5, 0)
                
                wait(0.25)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connection720:Disconnect()
end})
y=y+30
JFR.NewButton("360", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "360 dunks", TextSize = 20}, {
    on = function() 
        connection360 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()
                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -525)
                spin.Force = Vector3.new(85, 0, 0)

                wait(0.5)

                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.1)

                local pos = Instance.new("BodyPosition")
                pos.P = 2222
                pos.D = 500
                pos.MaxForce = Vector3.new(12345, 12345, 12345)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 1.25, 0)
                
                wait(0.25)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connection360:Disconnect()
end})
y=y+30
JFR.NewButton("180", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "180 dunks (turn around)", TextSize = 20}, {on = function() 
    connection180 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()
                
                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if s then
                    plr.Character.HumanoidRootPart["LookTowardsNet"]:Destroy()
                else
                    return 
                end
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                local defrimpos = rimpositions.GetDefensiveRim(plr)
                

                
                local lookback = Instance.new("BodyGyro")
                lookback.Parent = plr.Character.HumanoidRootPart
                lookback.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, defrimpos)
                lookback.D = 1
                lookback.P = 4000
                lookback.MaxTorque = Vector3.new(999999, 9999, 999999)
                
                wait(0.3)
                
                lookback:Destroy()
                
                pcall(function() a:Stop() end)
                
                local lookf = Instance.new("BodyGyro")
                lookf.Parent = plr.Character.HumanoidRootPart
                lookf.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, offrimpos)
                lookf.D = 1
                lookf.P = 4000
                lookf.MaxTorque = Vector3.new(1111111, 111111, 1111111)
                

                wait(0.2)
                lookf:Destroy()
                
                
                local pos = Instance.new("BodyPosition")
                pos.P = 2750
                pos.D = 500
                pos.MaxForce = Vector3.new(150000, 150000, 150000)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 3.5, 0) 
                
                wait(0.2)

                pos:Destroy()
            end
        end)
end, off = function() 
    connection180:Disconnect()
end})
y=y+30
JFR.NewText("b", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "One handed", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("b"))
y=y+30
JFR.NewButton("1n", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "One handed normal", TextSize = 20}, {
    on = function() 
        connection1n = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Defense - Client"].Steal.Right)
                a:Play(0.1, 5, 3)
                


                wait(0.5)

                pcall(function() a:Stop() end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connection1n:Disconnect()
end})
y=y+30
JFR.NewButton("1720", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "One handed 720 dunks", TextSize = 20}, {
    on = function() 
        connection1720 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Defense - Client"].Steal.Right)
                a:Play(0.1, 5, 3)
                
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -525)
                spin.Force = Vector3.new(70, 0, 0)

                wait(0.5)

                pcall(function() a:Stop() end)
                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connection1720:Disconnect()
end})
y=y+30
JFR.NewButton("1360", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "One handed 360 dunks", TextSize = 20}, {
    on = function() 
        connection1360 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Defense - Client"].Steal.Right)
                a:Play(0.1, 5, 3)
                
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -515)
                spin.Force = Vector3.new(45, 0, 0)

                wait(0.5)

                pcall(function() a:Stop() end)
                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connection1360:Disconnect()
end})
y=y+30
JFR.NewButton("1180", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "One handed 180 dunks", TextSize = 20}, {on = function() 
    connection1180 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()
                
                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if s then
                    plr.Character.HumanoidRootPart["LookTowardsNet"]:Destroy()
                else
                    return 
                end
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                local defrimpos = rimpositions.GetDefensiveRim(plr)
                
                
                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Defense - Client"].Steal.Right)
                a:Play(0.1, 5, 3)

                
                local lookback = Instance.new("BodyGyro")
                lookback.Parent = plr.Character.HumanoidRootPart
                lookback.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, defrimpos)
                lookback.D = 1
                lookback.P = 4000
                lookback.MaxTorque = Vector3.new(999999, 9999, 999999)
                
                wait(0.3)
                
                lookback:Destroy()
                
                pcall(function() a:Stop() end)
                
                local lookf = Instance.new("BodyGyro")
                lookf.Parent = plr.Character.HumanoidRootPart
                lookf.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, offrimpos)
                lookf.D = 1
                lookf.P = 4000
                lookf.MaxTorque = Vector3.new(1111111, 111111, 1111111)
                

                wait(0.2)
                lookf:Destroy()
                
                
                local pos = Instance.new("BodyPosition")
                pos.P = 2750
                pos.D = 500
                pos.MaxForce = Vector3.new(150000, 150000, 150000)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 3.5, 0) 
                
                wait(0.2)

                pos:Destroy()
            end
        end)
end, off = function() 
    connection1180:Disconnect()
end})
y=y+30
JFR.NewText("c", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Behind the back", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("c"))
y=y+30
JFR.NewButton("btbnormal", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Normal BTB", TextSize = 20}, {
    on = function() 
        connectionbtbn = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()
                
                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                
                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Dribble - Client"].Right.BTB)
                a:Play(0, 1, 1.1)
                
                wait(0.5)

                pcall(function() a:Stop() end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connectionbtbn:Disconnect()
end})
y=y+30
JFR.NewButton("btb720", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "BTB 720", TextSize = 20}, {
    on = function() 
        connectionb720 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Dribble - Client"].Right.BTB)
                a:Play(0.1, 5, 1)
                
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -525)
                spin.Force = Vector3.new(70, 0, 0)

                wait(0.5)

                pcall(function() a:Stop() end)
                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connectionb720:Disconnect()
end})
y=y+30
JFR.NewButton("btb360", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "BTB 360", TextSize = 20}, {on = function() 
    connectionb360 = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                local h = plr.Character.Humanoid
                local a = h:LoadAnimation(plr.Character.BallControl["Dribble - Client"].Right.BTB)
                a:Play(0.1, 5, 1)
                
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -515)
                spin.Force = Vector3.new(45, 0, 0)

                wait(0.5)

                pcall(function() a:Stop() end)
                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
                
            end
        end)
end, off = function() 
    connectionb360:Disconnect()
end})
y=y+30
JFR.NewText("d", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Misc", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("d"))
y=y+30
JFR.NewButton("mars", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Seizure", TextSize = 20}, {
    on = function() 
        connectionmars = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if not s then return end

                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 0 end)
                
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                
                

                
                local spin = Instance.new("BodyThrust")
                spin.Parent = plr.Character.HumanoidRootPart
                spin.Location = Vector3.new(0, 0, -696)
                spin.Force = Vector3.new(150, 0, 0)

                wait(0.5)

                pcall(function() a:Stop() end)
                spin:Destroy()
                pcall(function() plr.Character.HumanoidRootPart["LookTowardsNet"].P = 200000000 end)
                wait(0.15)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connectionmars:Disconnect()
end})
y=y+30
JFR.NewButton("layup", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Layup", TextSize = 20}, {
    on = function() 
        connectionlay = uis.InputBegan:Connect(function(io)
            if io.KeyCode == Enum.KeyCode.Space then
                wait()

                local s = pcall(function() return plr.Character.HumanoidRootPart["LookTowardsNet"].P end)
                if s then
                    plr.Character.HumanoidRootPart["LookTowardsNet"]:Destroy()
                else
                    return 
                end
                local offrimpos = rimpositions.GetOffensiveRim(plr)
                local defrimpos = rimpositions.GetDefensiveRim(plr)
                

                
                local lookback = Instance.new("BodyGyro")
                lookback.Parent = plr.Character.HumanoidRootPart
                lookback.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, defrimpos)
                lookback.D = 1
                lookback.P = 4000
                lookback.MaxTorque = Vector3.new(999999, 9999, 999999)
                
                wait(0.325)
                
                lookback:Destroy()
                
                game.ReplicatedStorage.Ball.Layup:FireServer("Layup")
                
                
                wait(0.125)

                local pos = Instance.new("BodyPosition")
                pos.P = 2000
                pos.MaxForce = Vector3.new(9999, 9999, 9999)
                pos.Parent = game.ReplicatedStorage.GameBall.Value
                pos.Position = offrimpos + Vector3.new(0, 0, 0)
                
                
                
                wait(0.2)

                pos:Destroy()
            end
        end)
    end, off = function() 
        connectionlay:Disconnect()
end})
y=y+30

local dragarea = Instance.new("Frame")
dragarea.Size = UDim2.new(0, 300, 0, 50)
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
message("Ready")
