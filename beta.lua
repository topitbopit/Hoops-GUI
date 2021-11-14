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
local ts = game:GetService("TweenService")
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

local mfloor = math.floor
local mceil = math.ceil
local mabs = math.abs
local mrandom = math.random

local function FindFastChild(instance, name)
    local a,b = pcall(function() return instance[name] end)

    return (a and b) or nil
end

local function twn(object, dest, time)
    local tween = ts:Create(object, TweenInfo.new(time, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), dest)
    tween:Play()
    return tween
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
  h_discord:SetTooltip("Click to copy the discord invite")
  h_changelog:SetTooltip("View the changelog [WIP]")

m_home:NewSection("Config")
  local h_loadcfg = m_home:NewButton("Load config")
  local h_savecfg = m_home:NewButton("Save config")
  h_loadcfg:SetTooltip("Click to open a file")
  h_savecfg:SetTooltip("Click to save a file")

m_home:NewLabel()
m_home:NewTrim()
m_home:NewLabel("Version 3.0.0-BETA.4; UI version "..ui.Version)



m_ball:NewSection("Aimbot / Auto green")
  local b_aimbot = m_ball:NewToggle("Aimbot") --aimbot
  local b_aimbotm = m_ball:NewDropdown("Aimbot mode",{"One press","Classic"}) --aimbot mode
  local b_aimbotd = m_ball:NewToggle("Custom delay") --aimbot delay
  local b_aimbotdamt = m_ball:NewSlider("Custom delay (MS)",475,550,505) --aimbot delay amount
  local b_autogreen = m_ball:NewToggle("Auto green")
  local b_autogreenm = m_ball:NewDropdown("Auto green method",{"Bar cutter","Public","Keyrelease"})
  b_aimbotm:SetTooltip("Changes the aimbot method.\nOne press: fakes a jump shot\nClassic: hold-R-until-you-red aimbot")
  b_aimbot:SetTooltip("Tries to fake you getting a green. Doesn't work every time.")
  b_aimbotd:SetTooltip("Uses the inputted delay instead of predicting what the delay should be.")
  b_autogreen:SetTooltip("Tries to get a green for you. Not always 100%, depends on ping and distance.")
  b_autogreenm:SetTooltip("Uses a different auto green method.\nBar cutter: Looks cool, might work as well as public\nPublic: Can work well\nKey: Uses keyrelease, may not work as well as others")
  
m_ball:NewSection("OP")
  local b_powerdunk = m_ball:NewToggle("Power dunks")
  local b_fly = m_ball:NewToggle("Ball fly")
  local b_autoinbound = m_ball:NewToggle("Auto inbound")
  local b_autograb = m_ball:NewToggle("Auto grab")
  b_powerdunk:SetTooltip("Classic power dunks, also lets you air strafe.")
  b_fly:SetTooltip("Flies you to the hoop when you pickup the ball")
  b_autoinbound:SetTooltip("Teleports you to the inbound circle.")
  b_autograb:SetTooltip("Sorta like an HBE, but way better.")

m_ball:NewSection("Render")
  local b_velocity = m_ball:NewToggle("Velocity")
  local b_highlight = m_ball:NewToggle("Highlight")
  local b_cam = m_ball:NewToggle("Ball cam")
  b_velocity:SetTooltip("'Predicts' where the ball is going.")
  b_velocity:Assert("Drawing")
  b_highlight:SetTooltip("Highlights the ball so you know where it is at all times.")

  m_ball:NewSection("Troll")
  local b_spamshoot = m_ball:NewToggle("Spam shoot")
  b_spamshoot:SetTooltip("Spam shoots the ball when it can.\nNote that this will lag your game when used!")

  m_ball:NewSection("Work in progress")
  local b_autolayup = m_ball:NewToggle("Auto layup")
  b_autolayup:SetTooltip("Automatically layups when you're close to the hoop. Gives 3 points for some reason.")



m_player:NewSection("Movement")
  local p_infstam = m_player:NewToggle("Infinite stamina")
  local p_stamspeed = m_player:NewToggle("Custom stamina drain")
  local p_stamspeedamt = m_player:NewSlider("Stamina drain speed",0,10,10)
  local p_noslow = m_player:NewToggle("Noslowdown")
  local p_cctp = m_player:NewToggle("Ctrl+Click teleport")
  local p_speed = m_player:NewToggle("Legit speedhack")
  local p_njcd = m_player:NewToggle("No jump cooldown")
  local p_bhop = m_player:NewToggle("Bhop")
  local p_jumpboost = m_player:NewToggle("Jump boost")
  local p_jumpboostamt = m_player:NewSlider("Jump boost amount", 1, 150, 75)
  p_infstam:SetTooltip("Classic infinite stamina. Hides the stamina bar.")
  p_stamspeed:SetTooltip("Changes how fast or slow your stamina drains.")
  p_stamspeedamt:SetTooltip("How fast or slow your stamina drains. 0 would freeze stamina, 10 would make it normal.")
  p_noslow:SetTooltip("Prevents you from being slowed down.")
  p_cctp:SetTooltip("Classic ctrl + click tp.")
  p_speed:SetTooltip("Speed thats slightly faster than normal sprinting.")
  p_njcd:SetTooltip("Emulates a jump, bypassing the cooldown. Also has less jump delay (0.25s -> 0.02s).")

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
  p_antisteal:SetTooltip("Spam G when you're not shooting to prevent steals. Stop spamming before you shoot, or else it'll glitch.")

m_player:NewSection("OP")
  local p_nodelay = m_player:NewToggle("No delay")
  p_nodelay:Assert("debug")
  p_nodelay:SetTooltip("Removes steal delay. Will effect other things eventually.")
  local p_autoblock = m_player:NewToggle("Auto block")
  p_autoblock:SetTooltip("Automatically jumps towards players that are about to shoot")

m_player:NewSection("Troll")
  local p_tptoball = m_player:NewToggle("TP to ball")
  local p_tptoballmode = m_player:NewDropdown("TP to ball mode",{"Always","When not holding","When teams not holding","When other"})
  p_tptoball:SetTooltip("Teleports you to the ball")
  
m_player:NewSection("Misc")
  local p_antivoid = m_player:NewToggle("Anti-void")
  local p_bounds = m_player:NewToggle("Bounds")

  

m_misc:NewSection("Game")
  local m_fixgame = m_misc:NewButton("Fix game")
  local m_deafen = m_misc:NewToggle("Deafen")
  local m_antiplr = m_misc:NewToggle("Anti-playergrade")
  m_fixgame:SetTooltip("Fixes a lot of issues the game may have.")
  m_deafen:SetTooltip("Removes some loud game sounds, like the cheering and buzzer.")
  m_antiplr:SetTooltip("Removes playergrade related remotes and scripts, possibly preventing player grade drops.")

m_misc:NewSection("Render")
  local m_nightmode = m_misc:NewToggle("Nightmode")
  local m_cstamgui = m_misc:NewToggle("Custom stamina bar")
  m_nightmode:SetTooltip("Makes the court dark with lights")
  m_cstamgui:SetTooltip("Uses a custom stamina bar")
  m_nightmode:Assert("sethiddenproperty")
  
m_misc:NewSection("Server")
  local m_rejoin = m_misc:NewButton("Rejoin")
  local m_shop = m_misc:NewButton("Serverhop")
  local m_priv = m_misc:NewButton("Join smallest server")

p_antivoid:SetTooltip("If you fall under the map, you get kicked from the server. Antivoid teleports you up if you fall under.")
p_bounds:SetTooltip("Makes boundaries around the court so you don't foul. Still a WIP")


p_stamspeed:Hide("Unfinished")
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

m_fixgame:Hide("Unfinished")
m_deafen:Hide("Unfinished")
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

local scall = (syn and syn.secure_call) or (secure_call or securecall) or warn("Your exploit doesn't support secure call!")
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
                
                local bar1 = FindFastChild(h, "StaminaBar")
                local bar2 = FindFastChild(h, "JHStaminaBar")
                
                if bar1 then bar1.Enabled = false end
                if bar2 then bar2.Enabled = false end
                
                
            else
                warn("Oopsies; infinite stamina couldn't work properly")
            end

        end)

        local h = FindFastChild(plr.Character, "Head")
        if h then 
            local bar1 = FindFastChild(h, "StaminaBar")
            local bar2 = FindFastChild(h, "JHStaminaBar")
            
            if bar1 then bar1.Enabled = false end
            if bar2 then bar2.Enabled = false end
        end
    end)

    p_infstam.OnDisable:Connect(function()
        rs:UnbindFromRenderStep("JH3-IS")
        connections["IS"]:Disconnect()

        local h = FindFastChild(plr.Character, "Head")
        if h then 
            if m_cstamgui:IsEnabled() then
                local bar1 = FindFastChild(h, "StaminaBar")
                local bar2 = FindFastChild(h, "JHStaminaBar")
                
                if bar1 then bar1.Enabled = false end
                if bar2 then bar2.Enabled = true end
            else
                local bar1 = FindFastChild(h, "StaminaBar")
                
                if bar1 then bar1.Enabled = true end
            end
        end
    end)
end
-- custom drain
do 
    p_stamspeed.OnEnable:Connect(function() 
        --get script
        local sc = FindFastChild(plr.Character, "Movement") and plr.Character["Movement"]["Sprinting"]
        connections["SS1"] = plr.CharacterAdded:Connect(function(c) 
            sc = c:WaitForChild("Movement",5)
            twait(0.02)
            sc = sc["Sprinting"]
        end)
        
    end)
    
    p_stamspeed.OnDisable:Connect(function() 
    
    
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
                twait(0.1)
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
    end)

    b_autoinbound:Assert("firetouchinterest")
end
--power dunks
do 
    b_powerdunk.OnEnable:Connect(function() 
        local new = PhysicalProperties.new(100, 0.3, 0.5)
        
        -- whoever made power dunks originally
        -- just pasted inf yield kek

        while b_powerdunk:GetState() do
            for i,v in pairs(plr.Character:GetChildren()) do
                if FindFastChild(v, "CustomPhysicalProperties") then
                    v.CustomPhysicalProperties = new
                end
            end

            
            twait(10) 
            -- change properties on spawn and on enable is better
            -- but it's easier this way and is still more performant
            -- than < 3.0.0
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
			connections["HBE2"] = p_hbesize.OnValueChanged:Connect(function(size) 
            	h.Size = vector(size, 2, size)
        	end)
        end)

        if not h then 
            warn("[HBE] No character, waiting until respawn")
            return 
        end
        
        local size = p_hbesize:GetValue()
        print(size)
        h.Size = vector(size, 2, size)
        h.Transparency = 0.7
        
        connections["HBE2"] = p_hbesize.OnValueChanged:Connect(function(size) 
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
-- antisteal
do 
    p_antisteal.OnEnable:Connect(function() 
        local start = replicated.Ball.StartShooting
        local stop = replicated.Ball.EndShooting
        
        connections["AS1"] = uis.InputBegan:Connect(function(io, gpe) 
            if io.KeyCode == Enum.KeyCode.G then 
                if gpe then return end
                tspawn(function() 
                    local id = mrandom(0,1500)
                    warn("[AS] New thread",id)
                    start:FireServer()
                    stop:InvokeServer()
                    start:FireServer()
                    stop:InvokeServer()
                    warn("[AS] Ended",id)
                end)
            end
        end)
        
        ui:NewNotification("Antisteal","Spam G while you aren't shooting to prevent steals.",3)
    end)

    p_antisteal.OnDisable:Connect(function() 
        connections["AS1"]:Disconnect()
    
    
    end)
end

--auto block
do 
    p_autoblock.OnEnable:Connect(function() 
        local c = plr.Character
        
        local hum = FindFastChild(c, "Humanoid")
        local humrp = FindFastChild(c, "HumanoidRootPart")
        local anim
        
        if not hum then 
            p_autoblock:Hide("Waiting for character respawn...") 
            plr.CharacterAdded:Wait()
            
            twait(0.05)
            
            hum = FindFastChild(c, "Humanoid")
            humrp = FindFastChild(c, "HumanoidRootPart")
        end
        
        anim = hum:LoadAnimation(c["BallControl"]["Defense - Client"].Block)
        
        connections["AB1"] = plr.CharacterAdded:Connect(function(c) 
            -- get humanoid
            hum = c:WaitForChild("Humanoid", 3)
            -- wait for other instances
            twait(0.05)
            -- get humrp and load anim
            humrp = FindFastChild(plr.Character, "HumanoidRootPart")
            anim = hum:LoadAnimation(c:WaitForChild("BallControl", 3)["Defense - Client"].Block)
        end)
        
        local function jump() 
            --printconsole("[JUMP] Got call", 0, 255, 0)
            if hum.FloorMaterial == Enum.Material.Air then
                --printconsole("[JUMP] Returning", 255, 0, 0)
                --printconsole("[JUMP] Current material,parent: "..tostring(hum.FloorMaterial)..","..tostring(hum.Parent), 192, 192, 192)
                return
            end 
            
            rs:BindToRenderStep("JH3-AB",900,function() 
                hum:Move(cframe(humrp.Position, gameball.Position).LookVector)
            end)
            twait(0.1)
            anim:play(0.25)
            twait(0.02)
            
            hum.JumpPower = 18.64
            hum.Jump = true
            twait(0.02)
            hum.JumpPower = 0
            twait(0.2)
            rs:UnbindFromRenderStep("JH3-AB")
            --printconsole("[JUMP] Finished", 192, 192, 192)
        end
        
        
        tspawn(function() 
            --printconsole("[LOOP] Starting checks",192,192,192)
            while p_autoblock:IsEnabled() do
                twait(0.02)
                for _,p in ipairs(players:GetPlayers()) do
                    if p == plr then continue end
                    if p.TeamColor == gameball.TeamColor.Value then continue end 
                    
                    pcall(function()
                        local h = p.Character.HumanoidRootPart 
                        if (h.Position - humrp.Position).Magnitude < 27 then
                            h.Transparency = 0
                            local hum = p.Character.Humanoid
                            
                            for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
                                local id = track.Animation.AnimationId
                                if id:match("376938580") or id:match("470725369") or id:match("125750702") then
                                    if gameball.Parent ~= p.Character then 
                                        --printconsole("[LOOP] False positive, cancelling + delaying",255,0,0)
                                        twait(0.15)
                                        break 
                                    end
                                    --they're jumpshotting so jump after them
                                    --printconsole("[LOOP] Someones shooting - waiting",255,0,255)
                                    twait(0.17)
                                    --printconsole("[LOOP] Jumping",255,0,255)
                                    jump()
                                    twait(1)
                                    --printconsole("[LOOP] Rescanning",192,192,192)
                                    break
                                end
                            end
                        else
                            h.Transparency = 1
                        end
                    end)
                end
            end
        end)
    end)
    
    p_autoblock.OnDisable:Connect(function() 
        connections["AB1"]:Disconnect()
        rs:UnbindFromRenderStep("JH3-AB")
    end)
end

do 

    m_fixgame.OnClick:Connect(function() 
        ui:NewNotification("Fix game","Successfully fixed any issues. Check console for more details",4)
    end)
    
end

-- nightmode
do 
    
    m_nightmode.OnEnable:Connect(function() 
        local d = {}
        sethiddenproperty(game.Lighting, "Technology",Enum.Technology.Future)
        
        tinsert(d,FindFastChild(workspace,"JH3-Nightmode"))
        tinsert(d,FindFastChild(gameball,"Spotlight"))
        tinsert(d,FindFastChild(lighting,"JH3-Bloom"))
        for _,i in ipairs(d) do i:Destroy()end
        
        lighting.Ambient = color3(5, 5, 6)
        lighting.Brightness = 0.1
        lighting.GlobalShadows = true
        lighting.TimeOfDay = 1
        
        local jhfolder = Instance.new("Folder")
        jhfolder.Name = "JH3-Nightmode"
        jhfolder.Parent = workspace
        
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 1.2
        bloom.Threshold = 0.8
        bloom.Size = 500
        bloom.Name = "JH3-Bloom"
        bloom.Parent = lighting
        
        local shadow = Instance.new("Part")
        shadow.Position = vector(0,300,0)
        shadow.Anchored = true
        shadow.Name = "shadow"
        shadow.CanCollide = false
        shadow.Transparency = 0
        shadow.Color = color3(0, 0, 0)
        shadow.Size = vector(3000, 500, 3000)
        shadow.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
        shadow.Parent = jhfolder
        
        local spot = Instance.new("Part")
        spot.Anchored = true
        spot.CanCollide = false
        spot.Name = "aimball"
        spot.Transparency = 1 
        spot.Size = vector(1,1,1)
        spot.Position = vector(0, 20, 0)
        spot.Parent = jhfolder
        
        local light = Instance.new("SpotLight")
        light.Color = color3(255, 255, 253)
        light.Brightness = 1.7
        light.Range = 999
        light.Shadows = true
        light.Angle = 50
        light.Face = Enum.NormalId.Front
        light.Parent = spot
        
        for z = -3, 3 do 
            tspawn(function()
                for x = -3, 3 do
                    local p1 = Instance.new("Part")
                    p1.Anchored = true
                    p1.Position = vector(35 * x, 60, 35 * z)
                    p1.Name = "1"
                    p1.CanCollide = false
                    p1.Transparency = 0
                    p1.Color = color3(2,2,8)
                    p1.Size = vector(43, 4, 4)
                    p1.Rotation = vector(z*6, 0, 90)
                    p1.TopSurface = Enum.SurfaceType.Smooth
                    p1.BottomSurface = Enum.SurfaceType.Smooth
                    p1.Shape = Enum.PartType.Cylinder
                    p1.Parent = jhfolder
                    
                    local p2 = p1:Clone()
                    p2.Name = "2"
                    p2.Material = Enum.Material.Neon
                    p2.Size = vector(1, 3.5, 3.5)
                    p2.Anchored = false
                    p2.Shape = Enum.PartType.Cylinder
                    p2.Parent = p1
                    
                    local weld = Instance.new("Weld")
                    weld.Part0 = p1
                    weld.Part1 = p2
                    weld.C0 = cframe(-21.5,0,0)
                    weld.C1 = cframe(0,0,0)
                    weld.Parent = p2
                    
                    local light = Instance.new("SpotLight")
                    light.Color = color3(255, 255, 245)
                    light.Brightness = 0.2
                    light.Range = 70
                    light.Shadows = true
                    light.Angle = 80
                    light.Face = Enum.NormalId.Left
                    light.Parent = p2
                    
                    p2.Color = light.Color
                    
                    local light = Instance.new("SpotLight")
                    light.Color = color3(255, 255, 235)
                    light.Brightness = 0.1
                    light.Range = 55
                    light.Shadows = true
                    light.Angle = 85
                    light.Face = Enum.NormalId.Left
                    light.Parent = p2
                    
                    
                    twait(0.05)
                    p2.Anchored = true
                    
                    
                end
            end)
        end 
        
        tspawn(function() 
            while m_nightmode:IsEnabled() do
                twait(0.1)
                twn(spot, 
                {CFrame = cframe(
                    vector(0, 20, 0), 
                    gameball.Position+vector(0,1,0)
                )}, 1)
                
            end
        end)
    end)
    
    
    m_nightmode.OnDisable:Connect(function() 
        local d = {}
        tinsert(d,FindFastChild(workspace,"JH3-Nightmode"))
        tinsert(d,FindFastChild(gameball,"Spotlight"))
        tinsert(d,FindFastChild(lighting,"JH3-Bloom"))
        for _,i in ipairs(d) do i:Destroy()end
        sethiddenproperty(game.Lighting, "Technology",Enum.Technology.Compatibility)
        
        lighting.Brightness = 1
        lighting.Ambient = Color3.fromRGB(127, 127, 127)
        lighting.GlobalShadows = false
        lighting.TimeOfDay = 14
    
    
    end)
end


-- custom stamina 
do 
    local stambarui
    m_cstamgui.OnEnable:Connect(function() 
        
        local c1 = color3n(0, 0.9, 0.2)--color3n(0, 0.9, 0.1)
        local c2 = color3n(0.9, 0, 0.2)--color3n(0.9, 0, 0.1)

        local staminavalue = plr.PlayerScripts.Events.Player.Stamina.Stamina
        
        local function enable(h) 
            stambarui = Instance.new("BillboardGui")
            stambarui.AlwaysOnTop = true
            stambarui.Size = UDim2.new(4, 0, 0.6, 0)
            stambarui.StudsOffsetWorldSpace = vector(0, 1.25, 0)
            stambarui.Parent = h
            
            local bg = Instance.new("Frame")
            bg.BackgroundColor3 = color3n(0.13, 0.13, 0.15)
            bg.BorderColor3 = color3n(0.03, 0.03, 0.05)
            bg.Size = UDim2.new(1, 0, 1, 0)
            bg.BorderSizePixel = 0
            bg.ClipsDescendants = true
            bg.ZIndex = 2
            bg.Parent = stambarui
            
            local backframe = Instance.new("Frame")
            backframe.BackgroundColor3 = color3n(0.03, 0.03, 0.05)
            backframe.BorderColor3 = color3n(0.13, 0.13, 0.15)
            backframe.Size = UDim2.new(1, 2, 1, 2)
            backframe.Position = UDim2.new(0, -1, 0, -1)
            backframe.BorderSizePixel = 1
            backframe.ClipsDescendants = false
            backframe.ZIndex = 0
            backframe.Parent = stambarui
            
            local shadow = Instance.new("ImageLabel")
            shadow.BackgroundTransparency = 1
            shadow.Image = "rbxassetid://7603818383"
            shadow.ImageColor3 = Color3.new(0, 0, 0)
            shadow.ImageTransparency = 0.15
            shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
            shadow.AnchorPoint = vector2(0.5, 0.5)
            shadow.Size = UDim2.new(1, 20, 1, 20)
            shadow.SliceCenter = Rect.new(15, 15, 175, 175)
            shadow.SliceScale = 1.3
            shadow.ScaleType = Enum.ScaleType.Slice
            shadow.ZIndex = 0
            shadow.Parent = backframe
            
            local shade = Instance.new("Frame")
            shade.Position = UDim2.new(0, 0, 0, 0)
            shade.Size = UDim2.new(1, 0, 0, 5)
            shade.Position = UDim2.new(0, 0, 1, -5)
            shade.BorderSizePixel = 0
            shade.BackgroundColor3 = color3n(0, 0, 0)
            shade.BackgroundTransparency = 0.9
            shade.ZIndex = 15
            shade.Parent = bg
            
            local stambar = Instance.new("Frame")
            stambar.AnchorPoint = vector2(1, 0)
            stambar.Position = UDim2.new(1, 0, 0, 0)
            stambar.Size = UDim2.new(1, 0, 1, 0)
            stambar.BorderSizePixel = 0
            stambar.BackgroundColor3 = c1
            stambar.ZIndex = 5
            stambar.Parent = bg
    
            local tlabel = Instance.new("TextLabel")
            tlabel.Font = Enum.Font.Nunito
            tlabel.Text = "<i>100%</i>"
            tlabel.RichText = true
            tlabel.TextColor3 = color3n(0, 0, 0)
            tlabel.BackgroundTransparency = 1
            tlabel.TextTransparency = 0.2
            tlabel.TextStrokeTransparency = 1
            tlabel.TextXAlignment = Enum.TextXAlignment.Right
            tlabel.Size = UDim2.new(1, 0, 1, 0)
            tlabel.Position = UDim2.new(0, 0, 0, 0)
            tlabel.TextScaled = true
            tlabel.AnchorPoint = vector2(0, 0)
            tlabel.Parent = stambar
            tlabel.ZIndex = 6
    
            connections["STAM1"] =  staminavalue.Changed:Connect(function(val) 
                local amnt = val / 1000
                
                stambar.Position = UDim2.new(amnt, 0, 0, 0)
                stambar.BackgroundColor3 = c2:Lerp(c1, amnt)
                
                local n = tostring(mfloor((amnt*100)+0.5))
    
                tlabel.Text = "<i>"..n.."%</i>" 
                
                if tlabel.Text:match("0") then
                    tlabel.TextTransparency = 0
                    twn(tlabel, {TextTransparency = 0.2}, 1) 
                    
                end
                
                local a,b = mabs(mfloor(val) - 495), mabs(mfloor(val) - 505)
                
                if a < 5 then
                    twn(tlabel, {Position = UDim2.new(0.3, 0, 0, 0), TextColor3 = color3n(1, 1, 1)}, 1)
                elseif b < 5 then
                    twn(tlabel, {Position = UDim2.new(0, 0, 0, 0), TextColor3 = color3n(0, 0, 0)}, 1)
                end
            end)
        end
        
        local h = FindFastChild(plr.Character, "Head")
        if h then
            local bar1 = FindFastChild(h, "StaminaBar")
            if bar1 then bar1.Enabled = false end
        
            enable(h)
        end
        
        connections["STAM2"] = plr.CharacterAdded:Connect(function(c) 
            h = c:WaitForChild("Head", 5)
            connections["STAM1"]:Disconnect()
            
            if h then
                local bar1 = h:WaitForChild("StaminaBar",2)
                bar1.Enabled = false
                
                enable(h)
            end
        
        end)
    end)

    m_cstamgui.OnDisable:Connect(function() 
        stambarui:Destroy()
        connections["STAM1"]:Disconnect()
        connections["STAM2"]:Disconnect()
        
        local bar1 = FindFastChild(plr.Character.Head, "StaminaBar")
        
        if bar1 then 
            if p_infstam:IsEnabled() then return end
            bar1.Enabled = true 
        end
        
    end)

end



-- { Finish } --

local msg = ui:NewMessagebox("Warning","This is not a final product and may change at any time", nil, 80, -30)
msg.OnClose:Wait()
ui:Ready()



ui.Exiting:Connect(function() 
    for i,v in ipairs(ui:GetAllToggles()) do
        if v:GetState() == true then
            v:Disable() 
        end
    end
    
    for i,v in ipairs(connections) do
        v:Disconnect() 
    end
end)



-- custom afk

do 
    
    local function handle() 
        -- get remotes and other stuff
        local clientafk1 = plr.PlayerScripts.Events.Player.IsAFK -- bindables that do clientside
        local clientafk2 = plr.PlayerScripts.Resetting.SetState -- afk handling
        
        local returning = replicated.Player.AFK.IsReturning -- server remotes that 
        local away = replicated.Player.AFK.IsAway -- actually make you afk
        
        local afktext1 = plr.PlayerGui.AFK.Manual -- the afk messages 
        local afktext2 = plr.PlayerGui.AFK.Automatic -- that might show up
        
        
        -- get where sidebuttons are located
        local afkbutton = plr.PlayerGui.Sidebar.Container
        
        
        for _,child in ipairs(afkbutton:GetChildren()) do
            if child.ClassName == "TextButton" then
                local t = FindFastChild(child, "Top")
                
                -- check for a button with AFK (normal hoops text)
                if t and t.Text:match("AFK") then
                    afkbutton = child
                    break
                end
            end
        end
        
        
        if afkbutton.ClassName ~= "TextButton" then
            -- if button isnt found then check again
            
            afkbutton = plr.PlayerGui.Sidebar.Container
            for _,child in ipairs(afkbutton:GetChildren()) do
                if child.ClassName == "TextButton" then
                    local t = FindFastChild(child, "Top")
                    
                    if t.Text:match("View") == nil and t.Text:match("Wear") == nil then
                        
                        -- if the text doesnt have View and Wear then
                        -- its probably the afk button
                        
                        afkbutton = child
                        break
                    end
                end
            end
        end
        
        -- get the old button
        local old = afkbutton
        
        -- copy it to a new button and parent the new button to container
        afkbutton = old:Clone()
        afkbutton.Parent = plr.PlayerGui.Sidebar.Container
        -- hide it 
        afkbutton.Position = UDim2.new(-2, 0, 2, 20)
        
        -- handle deleting some instances if found and warning if not
        do 
            local a = FindFastChild(afkbutton, "ButtonActive");
            local b = FindFastChild(afkbutton, "Clicked");
            local c = FindFastChild(afkbutton, "Arrow");
            
            (a and a.Destroy or warn)(a or "[CUSTOM AFK] Button missing ButtonActive boolvalue");
            (b and b.Destroy or warn)(b or "[CUSTOM AFK] Button missing Clicked bindable");
            (c and c.Destroy or warn)(c or "[CUSTOM AFK] Button missing Arrow");
        end
        
        -- handle mouse events, self explanatory
        do 
            local bcolor1 = color3(255, 170, 0)
            local bcolor2 = color3(229, 153, 0)
            local bcolor3 = color3(191, 127, 0)
            
            afkbutton.MouseEnter:Connect(function() 
                afkbutton.Top.BackgroundColor3 = bcolor2
                afkbutton.Bottom.BackgroundColor3 = bcolor3
            end)
            
            afkbutton.MouseLeave:Connect(function() 
                afkbutton.Top.BackgroundColor3 = bcolor1
                afkbutton.Bottom.BackgroundColor3 = bcolor2
                
                afkbutton.Top.Position = UDim2.new(0, 0, 0, 0)
            end)
            
            
            afkbutton.MouseButton1Down:Connect(function() 
                afkbutton.Top.Position = UDim2.new(0, 0, 0.05, 0)
            end)
            
            afkbutton.MouseButton1Up:Connect(function() 
                afkbutton.Top.Position = UDim2.new(0, 0, 0, 0)
            end)
            
            afkbutton.MouseButton1Click:Connect(function() 
                if plr.Character then
                    clientafk1:Fire(true)
                    clientafk2:Fire("AFK", true)
                    away:FireServer()
                    
                    afkbutton.Top.Text = "Click to return"
                else 
                    clientafk1:Fire(false)
                    clientafk2:Fire("AFK", false)
                    returning:FireServer()
                    
                    afkbutton.Top.Text = "Click to go AFK"
                    
                    plr.CharacterAdded:Wait()
                    twait(0.04)
                    workspace.CurrentCamera.CameraSubject = FindFastChild(plr.Character, "Humanoid")
                end
            end)
            
            afkbutton.Top.BackgroundColor3 = bcolor1
            afkbutton.Bottom.BackgroundColor3 = bcolor2
            
        end
        
        -- animate the older button out and delete it
        tspawn(function()
            local t = twn(old,{Position = UDim2.new(-2, 0, 2, 20)}, 0.3)
            t.Completed:Wait()
            old:Destroy()
        end)
        -- disable the normal afk script
        pcall(function() 
            plr.PlayerScripts.GameControl["AFK - Client"].Disabled = true
        end)
        -- animate the newer button in after a short delay
        tdelay(0.3, function() twn(afkbutton, {Position = UDim2.new(0, 0, 2, 20)}, 0.3) end)
        
        
        
        -- override afk message
        afktext1.Visible = true
        afktext2.Visible = false
        afktext1.Text = "Jeff Hoops custom AFK loaded."
        
        wait(3)
        
        afktext1.Visible = false
    end
    
    -- finish
    handle()
end

