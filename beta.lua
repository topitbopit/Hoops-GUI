---@diagnostic disable: trailing-space
if not game:IsLoaded() then game.Loaded:Wait() end -- wait for game to load

-- { Microoptimizations } --

local players = game:GetService("Players")
local replicated = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local ctx = game:GetService("ContextActionService")
local vim = game:GetService("VirtualInputManager")
-- grab some stuff

local cframe = CFrame.new
local vector = Vector3.new
local vector2 = Vector2.new
local color3n = Color3.new
local color3 = Color3.fromRGB

local twait = task.wait
local tdelay = task.delay
local tspawn = task.spawn

local cwrap = coroutine.wrap
local ccreate = coroutine.create
local cresume = coroutine.resume

local tinsert = table.insert
local tremove = table.remove

local mrandom = math.random

local function FindFastChild(instance, name)
    local a,b = pcall(function() return instance[name] end)

    return (a and b) or nil

     -- this better be faster than ffc
end

-- { UI } --

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

ui:SetColors("legacy") -- 
ui.TooltipX = 25

if game.PlaceId ~= 360589910 then 
	ui:NewMessagebox("Oopsies","The game you're in isn't Hoops Demo. Teleport there?", {
		{
			Text = "Yes",
			Callback = function(s)
				s:FadeText("Hold on...","Trying to teleport...")
				
				local ts = game:GetService("TeleportService")
				local w,m = pcall(function() 
					ts:Teleport(360589910, players.LocalPlayer) 
				end)
				if w then
					w:Close()
				else
					s:FadeText("Something went wrong","Couldn't teleport; "..m)
				end
			end
		},
		{
			Text = "No",
			Callback = function(s)
				s:FadeText("Ok","See you later")
				wait(2)
				s:Close()
			end
		}
	}, 80, -30)
	return
end

local window = ui:NewWindow("Jeff Hoops", 400, 300)

local m_home = window:NewMenu("Home")
local m_ball = window:NewMenu("Ball")
local m_player = window:NewMenu("Player")
local m_misc = window:NewMenu("Misc")


m_home:NewLabel("Jeff Hoops made by topit")
local h_discord = m_home:NewButton("Join the discord")
local h_changelog = m_home:NewButton("View changelog")
m_home:NewSection("Config")
local h_loadcfg = m_home:NewButton("Load config")
local h_savecfg = m_home:NewButton("Save config")
m_home:NewLabel()
m_home:NewTrim()
m_home:NewLabel("Version 3.0.0-DEV.1; UI version "..ui.Version)

h_discord:SetTooltip("Click to copy the discord invite")
h_changelog:SetTooltip("View the changelog [WIP]")
h_loadcfg:SetTooltip("Click to open a file")
h_savecfg:SetTooltip("Click to save a file")


m_ball:NewSection("Aimbot / Auto green")
local b_aimbot = m_ball:NewToggle("Aimbot") --aimbot
b_aimbot:SetTooltip("Tries to fake a green. Doesn't work every time.")

local b_aimbotm = m_ball:NewDropdown("Aimbot mode",{"One press","Classic"}) --aimbot mode
b_aimbotm:SetTooltip("Changes the aimbot method.\nOne press: fakes a jump shot\nClassic: hold-R-until-you-red aimbot")

local b_aimbotd = m_ball:NewToggle("Custom delay") --aimbot delay
b_aimbotd:SetTooltip("Uses the inputted delay instead of predicting what the delay should be.")

local b_aimbotdamt = m_ball:NewSlider("Custom delay (MS)",475,550,505) --aimbot delay amount

local b_autogreen = m_ball:NewToggle("Auto green")
b_autogreen:SetTooltip("Tries to get a green for you.")
local b_autogreenm = m_ball:NewDropdown("Auto green method",{"Bar cutter","Public","Keyrelease"})
b_autogreenm:SetTooltip("Uses a different auto green method.\nBar cutter: More consistent version of public + looks cool\nPublic: Can work well, may depend on ping\nKey: Uses keyrelease, may not work as well as others")

m_ball:NewSection("OP")
local b_autoinbound = m_ball:NewToggle("Auto inbound")
b_autoinbound:SetTooltip("Teleports you to the inbound circle.")
local b_powerdunk = m_ball:NewToggle("Power dunks")
b_powerdunk:SetTooltip("Classic power dunks, also lets you air strafe.")
local b_autograb = m_ball:NewToggle("Auto grab")
b_autograb:SetTooltip("Sorta like an HBE, but way better.")
local b_fly = m_ball:NewToggle("Ball fly")
b_fly:SetTooltip("Flies you to the hoop when you pickup the ball")


m_ball:NewSection("Render")
local b_cam = m_ball:NewToggle("Ball cam")
local b_velocity = m_ball:NewToggle("Velocity")
b_velocity:SetTooltip("'Predicts' where the ball is going.")
b_velocity:Assert("Drawing")

local b_highlight = m_ball:NewToggle("Highlight")
b_highlight:SetTooltip("Highlights the ball so you know where it is at all times.")

m_ball:NewSection("Troll")
local b_spamshoot = m_ball:NewToggle("Spam shoot")
b_spamshoot:SetTooltip("Spam shoots the ball when it can.\nNote that this will lag your game when used!")

m_ball:NewSection("Work in progress")
local b_autolayup = m_ball:NewToggle("Auto layup")
b_autolayup:SetTooltip("Automatically layups when you're close to the hoop. Gives 3 points for some reason.")


m_player:NewSection("Movement")
local p_infstam = m_player:NewToggle("Infinite stamina")
local p_noslow = m_player:NewToggle("Noslowdown")
local p_cctp = m_player:NewToggle("Ctrl+Click teleport")
local p_speed = m_player:NewToggle("Legit speedhack")
local p_njcd = m_player:NewToggle("No jump cooldown")
local p_bhop = m_player:NewToggle("Bhop")
local p_jumpboost = m_player:NewToggle("Jump boost")
local p_jumpboostamt = m_player:NewSlider("Jump boost amount", 1, 150, 75)


p_infstam:SetTooltip("Classic infinite stamina. Hides the stamina bar.")
p_noslow:SetTooltip("Prevents you from being slowed down.")
p_cctp:SetTooltip("Classic ctrl + click tp.")
p_speed:SetTooltip("Speed thats slightly faster than normal sprinting.")
p_njcd:SetTooltip("Bypasses the jump cooldown. Also has less jump delay (0.25 -> 0.02s).")

m_player:NewSection("Steals")
local p_hbe = m_player:NewToggle("Hitbox expander")
local p_hbesize = m_player:NewSlider("Hitbox expander size", 5, 20, 5)
local p_stealaura = m_player:NewToggle("Steal aura")
local p_stealauras = m_player:NewSlider("Steal aura speed", 1, 15, 1)
local p_antisteal = m_player:NewToggle("Anti-steal")

p_hbe:SetTooltip("Your average HBE, but more customizable.")
p_hbesize:SetTooltip("Controls the size of the HBE.")
p_stealaura:SetTooltip("Can make whoever you walk into drop the ball. Has a side effect with animations.")
p_stealauras:SetTooltip("Controls how fast others drop the ball. Don't use a number higher than 3!!")
p_antisteal:SetTooltip("Spam G when you're not shooting to prevent most steals.")


m_player:NewSection("OP")
local p_nodelay = m_player:NewToggle("No delay")
p_nodelay:Assert("debug")
p_nodelay:SetTooltip("Removes steal delay. Will effect other things eventually.")

m_player:NewSection("Troll")
local p_tptoball = m_player:NewToggle("TP to ball")

m_player:NewSection("Misc")
local p_antivoid = m_player:NewToggle("Anti-void")
local p_bounds = m_player:NewToggle("Bounds")

p_antivoid:SetTooltip("If you fall under the map, you get kicked from the server. Antivoid teleports you up if you fall under.")
p_bounds:SetTooltip("Makes boundaries around the court so you don't foul. Still a WIP")

m_misc:NewSection("Game")

local m_antiafk = m_misc:NewButton("Anti AFK")
local m_fixgame = m_misc:NewButton("Fix game")
local m_deafen = m_misc:NewToggle("Deafen")
local m_nightmode = m_misc:NewToggle("Nightmode")
local m_antiplr = m_misc:NewToggle("Anti playergrade")

m_misc:NewSection("Server")
local m_rejoin = m_misc:NewButton("Rejoin")
local m_shop = m_misc:NewButton("Serverhop")
local m_priv = m_misc:NewButton("Join smallest server")

b_cam:Hide("Unfinished")
b_aimbot:Hide("Unfinished")
b_velocity:Hide("Unfinished")
b_highlight:Hide("Unfinished")
b_autolayup:Hide("Unfinished")
p_bhop:Hide("Unfinished")
p_jumpboost:Hide("Unfinished")
p_stealaura:Hide("Unfinished")
p_tptoball:Hide("Unfinished")
p_antivoid:Hide("Unfinished")
p_bounds:Hide("Unfinished")

m_antiafk:Hide("Unfinished")
m_fixgame:Hide("Unfinished")
m_deafen:Hide("Unfinished")
m_nightmode:Hide("Unfinished")
m_antiplr:Hide("Unfinished")
m_rejoin:Hide("Unfinished")
m_shop:Hide("Unfinished")
m_priv:Hide("Unfinished")

-- { Variables & Callbacks } --

local plr = players.LocalPlayer
local mouse = plr:GetMouse()

local rimpositions = require(replicated.Modules.RimPositions)
local loadanims = require(plr.PlayerScripts.Modules.LoadAnimations)

local ballpointer = replicated.GameBall
local gameball = ballpointer.Value

local statepointer = replicated.Scoreboard.GameState

local scall = (syn and syn.secure_call) or (secure_call) or warn("Your exploit doesn't support secure call!")
-- secure call will definitely not be needed


local connections = {}


connections["BallUpdate"] = ballpointer:GetPropertyChangedSignal("Value"):Connect(function()
    gameball = ballpointer.Value
end)

--home

do 
    h_discord.OnClick:Connect(function() 
        setclipboard("https://discord.gg/Gn9vWr8DJC")
        ui:NewNotification("Discord","Copied invite to clipboard!",3)
    
    end)



end




--stamina
do

    p_infstam.OnEnable:Connect(function()
        -- get stamina value
        local stamina = plr.PlayerScripts.Events.Player.Stamina.Stamina


        rs:BindToRenderStep("JH3-IS", 600, function()
            stamina.Value = 1050
        end)

        connections["IS"] = plr.CharacterAdded:Connect(function(chr)
            local h = chr:WaitForChild("Head", 4)
            if h then
                -- how has nobody thought of this yet
                -- makes it look better

                h.StaminaBar.Enabled = false
            else
                warn("Oopsies; infinite stamina couldn't work properly") --?????
            end

        end)

        local a = FindFastChild(plr.Character, "Head")
        if a then a.StaminaBar.Enabled = false end
    end)

    p_infstam.OnDisable:Connect(function()
        rs:UnbindFromRenderStep("JH3-IS")
        connections["IS"]:Disconnect()

        local a = FindFastChild(plr.Character, "Head")
        if a then a.StaminaBar.Enabled = true end
    end)
end
--noslow
do
    p_noslow.OnEnable:Connect(function()
        --get the events and stuff
        local event = plr.PlayerScripts.Events.Player.DisableControls
        local hum = FindFastChild(plr.Character, "Humanoid")
        local humrp = FindFastChild(plr.Character, "HumanoidRootPart")
        event:Fire(false)
        

        --microoptimization to update `hum` instead of index it per frame
        connections["NS1"] = plr.CharacterAdded:Connect(function(chr)
            hum = chr:WaitForChild("Humanoid",5)
            humrp = FindFastChild(chr, "HumanoidRootPart")
            
            if not humrp then
                twait(0.05)
                humrp = FindFastChild(chr, "HumanoidRootPart")
                
                if not humrp then
                    warn("[NOSLOW] Couldn't get humanoidrootpart; try resetting and re-enabling.")
                end
            end
            
            connections["NS2"]:Disconnect()
            connections["NS2"] = humrp:GetPropertyChangedSignal("Anchored"):Connect(function()
                humrp.Anchored = false
            end)
        end)
        
        
        connections["NS2"] = humrp:GetPropertyChangedSignal("Anchored"):Connect(function()
            humrp.Anchored = false
        end)


        rs:BindToRenderStep("JH3-NS", 605, function()
            pcall(function() -- no error handling kek
                if hum.WalkSpeed < 16 then
                    hum.WalkSpeed = 16
                end
            end)
        end)
    end)

    p_noslow.OnDisable:Connect(function()
        rs:UnbindFromRenderStep("JH3-NS")
        
        connections["NS1"]:Disconnect()
        connections["NS2"]:Disconnect()
    end)
end
--autograb
do
    b_autograb.OnEnable:Connect(function()
        -- get shit
        local la = FindFastChild(plr.Character, "Left Arm")

        -- update arm (noslow method)
        connections["AG"] = plr.CharacterAdded:Connect(function(chr)
            la = chr:WaitForChild("Left Arm", 4)
        end)

        rs:BindToRenderStep("JH3-AG", 700, function()
            pcall(firetouchinterest, la, gameball, 1) -- fancy pcall ooh
            pcall(firetouchinterest, la, gameball, 0)

        end)
    end)

    b_autograb.OnDisable:Connect(function()
        connections["AG"]:Disconnect()
        rs:UnbindFromRenderStep("JH3-AG")
    end)

    b_autograb:Assert("firetouchinterest")
end
--clicktp
do
    p_cctp.OnEnable:Connect(function()
        connections["CCTP"] = mouse.Button1Down:Connect(function()
            if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                -- if click and left control then
                -- do this shit

                local hrp = FindFastChild(plr.Character, "HumanoidRootPart")
                if not hrp then return end

                pcall(function()
                    mouse.TargetFilter = workspace.RestrictedCircle
                end)

                -- shouldve just pcalled kek
                local lv = hrp.CFrame.LookVector
                local p = mouse.Hit.Position + vector(0, 3, 0)
                hrp.CFrame = cframe(p, p+lv)

                -- overengineered but idc
            end
        end)

    end)

    p_cctp.OnDisable:Connect(function()
        connections["CCTP"]:Disconnect()
    end)
end
--spamthrow
do
    b_spamshoot.OnEnable:Connect(function()
        -- shooting uses invokeserver which yields
        -- until it gets a response so don't try
        -- to shoot too often or else you'll lag
        
        local startShooting = replicated.Ball.StartShooting
        local endShooting = replicated.Ball.EndShooting
        
        local threads = 0
        while b_spamshoot:GetState() do
            -- start shooting
            startShooting:FireServer()
            -- increment how many threads are being made
            threads += 1

            cresume(ccreate(function()
                -- end shooting
                endShooting:InvokeServer(true, "Perfect")
                -- dec threads (after server response)
                threads -= 1
            end))
            twait(0.05)
            if threads > 50 then
                -- if too many yielding threads then wait
                twait(0.15)
            end
        end
    end)
end
--auto ib
do 
    b_autoinbound.OnEnable:Connect(function() 
        connections["IB"] = workspace.ChildAdded:Connect(function(c) 
            if c.Name == "ThrowIn" then
                print("New circle")
                -- if the ib thing gets spawned then
                -- wait for the circle thing
                local f = workspace:WaitForChild("RestrictedCircle", 5)
                -- if the circle exists then check for 
                -- if it's for your team
                if f.Display.BrickColor == plr.TeamColor then
                    print("Is on team")
                    -- shoddy method but idc
                    -- i'll probably refactor this at some point

                    local humrp = FindFastChild(plr.Character, "HumanoidRootPart")
                    if not humrp then
                        warn("Can't inbound; character not alive")
                        ui:NewNotification("Inbound","Couldn't take inbound, character's not alive", 4)
                        return
                    end

                    
                    if gameball.Parent == workspace then
                        -- i would use some variable shit but
                        -- the ball gets reset every new game
                        -- this is easier
                        humrp.CFrame = c.CFrame

                    end

                    -- print("Inbounded") --just in case i need to test
                end
            end
        end)
    end)

    b_autoinbound.OnDisable:Connect(function()
        connections["IB"]:Disconnect()
        -- cleanup ez
    end)

    b_autoinbound:Assert("firetouchinterest")
    -- ee skiddies get fucked
    -- use comet or krnl
end
--power dunks
do 
    b_powerdunk.OnEnable:Connect(function() 
        local new = PhysicalProperties.new(100, 0.3, 0.5)
        
        -- whoever made power dunks originally
        -- just pasted inf yield lmao 

        while b_powerdunk:GetState() do
            for i,v in pairs(plr.Character:GetChildren()) do
                if FindFastChild(v, "CustomPhysicalProperties") then
                    v.CustomPhysicalProperties = new
                end
            end

            
            twait(10) 
            -- change properties on spawn and on enable is better
            -- but it's easier this way and is still more performant
            -- than < 3.0.0 (which did it per frame)
        end
    end)

    b_powerdunk.OnDisable:Connect(function() 
        local new = PhysicalProperties.new(0.7, 0.3, 0)

        for i,v in pairs(plr.Character:GetChildren()) do
            if FindFastChild(v, "CustomPhysicalProperties") then
                v.CustomPhysicalProperties = new
            end
        end
    end)
end
--ball fly
do 
    local ballfly
    
    b_fly.OnEnable:Connect(function() 
        local g = rimpositions.GetOffensiveRim(plr)

        ballfly = Instance.new("BodyPosition")
        ballfly.Parent = gameball
        ballfly.D = 125
        ballfly.MaxForce = vector(999999, 999999, 999999)
        ballfly.Position = vector(g.X / 1.1, g.Y, g.Z)
        
        while b_fly:GetState() do
            pcall(function() 
                local g = rimpositions.GetOffensiveRim(plr)
                
                ballfly.Position = vector(g.X / 1.1, g.Y, g.Z)
                ballfly.Parent = gameball
            end)
            twait(20)
        end 
    end)

    b_fly.OnDisable:Connect(function() 
        ballfly:Destroy()
    end)
end
-- no delay
do
    p_nodelay.OnEnable:Connect(function() 
        local chr = plr.Character

        connections["ND"] = plr.CharacterAdded:Connect(function(c) 
            
        end)

        if not FindFastChild(chr, "BallControl") then 
            warn("[ND] No character, waiting until next spawn to enable") 
            return 
        end
        local s = getsenv(chr["BallControl"]["Defense - Client"])["Steal_Ball"]
        debug.setconstant(s, 31, 0)

    end)
    p_nodelay.OnDisable:Connect(function() 
        connections["ND"]:Disconnect()

        local chr = plr.Character
        if not FindFastChild(chr, "BallControl") then
            ui:NewMessagebox("Oopsies","You have to be spawned in!")
            p_nodelay:Disable()
            return
        end

        local s = getsenv(chr["BallControl"]["Defense - Client"])["Steal_Ball"]
        debug.setconstant(s, 31, 1.2)
    end)
end
-- hbe
do 
    p_hbe.OnEnable:Connect(function() 
        local h = FindFastChild(plr.Character, "HumanoidRootPart")
        
        connections["HBE1"] = plr.CharacterAdded:Connect(function(c)
            local h = c:WaitForChild("HumanoidRootPart", 3)
            if not h then 
                warn("[HBE] Couldn't apply HBE properly! Try resetting")
                ui:NewNotification("Oopsies","Something went wrong, check your console " .. (syn and getsynasset and "(internal synapse ui)" or "(F9 or insert)"), 3)
                return 
            end 
            
			local size = p_hbesize:GetValue()
			h.Size = vector(size, 2, size)
			h.Transparency = 0.7

			connections["HBE2"]:Disconnect()
			connections["HBE2"] = p_hbesize.OnValueChange:Connect(function(size) 
            	h.Size = vector(size, 2, size)
        	end)
        end)

        if not h then 
            warn("[HBE] No character, waiting until respawn")
            return 
        end
        
        local size = p_hbesize:GetValue()
        h.Size = vector(size, 2, size)
        h.Transparency = 0.7
        
        connections["HBE2"] = p_hbesize.OnValueChange:Connect(function(size) 
            h.Size = vector(size, 2, size)
        end)
        
    end)
    p_hbe.OnDisable:Connect(function() 
        connections["HBE1"]:Disconnect()
        connections["HBE2"]:Disconnect()

        local h = FindFastChild(plr.Character, "HumanoidRootPart")
        if h then
            h.Size = vector(2, 2, 1)
            h.Transparency = 1  
        end
        
    
    end)
end

-- speedhack
do 
    p_speed.OnEnable:Connect(function()
        local hum = FindFastChild(plr.Character, "Humanoid")
        connections["SPD"] = plr.CharacterAdded:Connect(function(c) 
            hum = c:WaitForChild("Humanoid", 4)
            if not hum then
                warn("[SPD] Humanoid not found; speedhack won't work. Try resetting.") 
            end
        end)
        rs:BindToRenderStep("JH3-SPD", 1400, function() 
            pcall(function() 
                hum.WalkSpeed = 21
            end)
        end)
    end)
    
    p_speed.OnDisable:Connect(function()
        rs:UnbindFromRenderStep("JH3-SPD")
        
        local hum = FindFastChild(plr.Character, "Humanoid")
        if not hum then return end 
        
        if uis:IsKeyDown("LeftShift") then -- Enum.KeyCode.LeftShift
            hum.WalkSpeed = 20
        else
            hum.WalkSpeed = 16
        end
        
    end)
end

-- njcd
do 
    local leftside = workspace.Floor.LeftSide.Stand.Hoop.GoalDetection
    local rightside = workspace.Floor.RightSide.Stand.Hoop.GoalDetection
    
    -- this is a completely scuffed method
    -- but i dont want to deal with debug library shit
    -- when its not as good or as compatible
    
    
    p_njcd.OnEnable:Connect(function() 
        -- get hum
        local function hook(c) 
            local hum = FindFastChild(c, "Humanoid") or c:WaitForChild("Humanoid", 3)
            local humrp = FindFastChild(c, "HumanoidRootPart")
            local anim = hum:LoadAnimation(c.BallControl["Defense - Client"].Block)
            
            if not hum then
                warn("[NJCD] Oopsies; something went wrong. Try disabling no jump cd, resetting, and re-enabling. [1]") 
            end
            if not humrp then
                warn("[NJCD] Oopsies; something went wrong. Try disabling no jump cd, resetting, and re-enabling. [2]") 
            end
            if not anim then 
                warn("[NJCD] Oopsies; something went wrong. Try disabling no jump cd, resetting, and re-enabling. [3]") 
            end
            
            ctx:UnbindAction("JH3-NJCD")
            
            ctx:BindActionAtPriority("JH3-NJCD",function(_,is) 
                if is == Enum.UserInputState.Begin then
                    if hum.FloorMaterial == Enum.Material.Air then
                        return
                    end 
                    
                    
                    anim:play(0.25)
                    twait(0.02)
                    
                    if (humrp.Position - leftside.Position).Magnitude < 10 then
                        hum.JumpPower = 21.52
                    elseif (humrp.Position - rightside.Position).Magnitude < 10 then
                        hum.JumpPower = 21.52
                    else
                        hum.JumpPower = 18.64
                    end
                    
                    hum.Jump = true
                    twait(0.02)
                    hum.JumpPower = 0
                    
                end
            end, false, 999999, Enum.KeyCode.Space)
        end
        
        connections["NJCD2"] = plr.CharacterAdded:Connect(function(c) 
            hook(c)
            
            
        end)
        
        if FindFastChild(plr.Character, "Humanoid") then         
            hook(plr.Character) 
        end 
    end)
    
    p_njcd.OnDisable:Connect(function() 
        connections["NJCD2"]:Disconnect()
        ctx:UnbindAction("JH3-NJCD")
    end)
end




-- AUTO GREEN
do 
    b_autogreen.OnEnable:Connect(function() 
        
        local m = b_autogreenm:GetSelectedOption()
        
        if m == "Keyrelease" then
            connections["AG1"] = workspace.ChildAdded:Connect(function(c) 
                if c.Name ~= "ShotMeter" then return end
                if FindFastChild(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    local circle = (
                        FindFastChild(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        FindFastChild(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    
                    
                    local pointer
                    
                    twait(0.02)
                    local children = circle:GetChildren()
                    for i,v in pairs(children) do
                        if v.BackgroundColor3.R == 1 then
                            if tonumber(v.Name) > 15 then
                                pointer = circle[v.Name-2]
                                break
                            end
                        end
                    end
                    
                    if not pointer then pointer = circle["130"] end
                    
                    
                    pointer.BackgroundColor3 = color3n(0.27, 0.14, 0.76)
                    connections["AG2"] = pointer:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                        
                        
                        
                        keyrelease(0x52)
                        --vim:SendKeyEvent(false, Enum.KeyCode.R, false, nil)
                        connections["AG2"]:Disconnect()
                    end)
                    
            
                end
            end)
        elseif m == "Bar cutter" then
            
            connections["AG1"] = workspace.ChildAdded:Connect(function(c) 
                if c.Name ~= "ShotMeter" then return end
                if FindFastChild(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    
                    local circle = (
                        FindFastChild(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        FindFastChild(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    circle:WaitForChild("1",2)
                    circle.Visible = false
                    
                    local pointer
                    
                    twait(0.02)
                    
                    local children = circle:GetChildren()
                    for i,v in pairs(children) do
                        if v.BackgroundColor3.R == 1 then
                            if tonumber(v.Name) > 15 then
                                pointer = circle[v.Name]
                                break
                            end
                        end
                    end
                    twait()
                    for x = pointer.Name, 200 do
                        circle[x]:Destroy() 
                    end
                    circle.Visible = true
                end
            end)
                        
            
            
        elseif m == "Public" then
            
            connections["AG1"] = workspace.ChildAdded:Connect(function(c) 
                if c.Name ~= "ShotMeter" then return end
                if FindFastChild(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    local circle = (
                        FindFastChild(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        FindFastChild(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    
                    
                    local pointer
                    
                    twait(0.02)
                    local children = circle:GetChildren()
                    for i,v in pairs(children) do
                        if v.BackgroundColor3.R == 1 then
                            if tonumber(v.Name) > 15 then
                                pointer = circle[v.Name]
                                break
                            end
                        end
                    end
                    
                    if not pointer then pointer = circle["134"] end
                    
                    
                    pointer.BackgroundColor3 = color3n(0.27, 0.14, 0.76)
                    pointer.Name = "amoung pequeno"
                end
            end)
        end
    end)

    b_autogreen.OnDisable:Connect(function() 
        connections["AG1"]:Disconnect()
    end)
    
    b_autogreenm.OnSelection:Connect(function() 
        if b_autogreen:GetState() then
            
            b_autogreen:Disable()
            b_autogreen:Enable()
            
        end
    end)

end





-- { Finish } --

local msg = ui:NewMessagebox("Warning","This is not a final product and may change at any time", nil, 80, -30)
msg.OnClose:Wait()
ui:Ready()



ui.Exiting:Connect(function() 
    for i,v in pairs(ui:GetAllToggles()) do
        if v:GetState() == true then
            v:Disable() 
        end
    end
end)


