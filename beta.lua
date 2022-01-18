---@diagnostic disable: trailing-space
if not game:IsLoaded() then game.Loaded:Wait() end -- wait for game to load

-- { Microoptimizations } --

local serv_players    = game:GetService("Players")
local serv_replicated = game:GetService("ReplicatedStorage")
local serv_lighting   = game:GetService("Lighting")
local serv_uis        = game:GetService("UserInputService")
local serv_rs         = game:GetService("RunService")
local serv_ctx        = game:GetService("ContextActionService")
local serv_ts         = game:GetService("TweenService")
-- grab some stuff

local cfn = CFrame.new
local vec3 = Vector3.new
local vec2 = Vector2.new
local c3n = Color3.new
local rgb = Color3.fromRGB
local hsv = Color3.fromHSV

local wait = task.wait
local delay = task.delay
local spawn = task.spawn

local ccreate = coroutine.create
local cresume = coroutine.resume
local ins = table.insert
local rem = table.remove
local foreach = table.foreach

local floor = math.floor
local ceil = math.ceil
local abs = math.abs
local random = math.random
local sin = math.sin

local cam = workspace.CurrentCamera

local function DisableNonexecConnections(signal) 
    for _, con in ipairs(getconnections(signal)) do 
        local func = con.Function
        if (func and islclosure(func)) then
            local is_executor_closure = getfenv(func).game.HttpGet
            if (not is_executor_closure) then con:Disable() end
        end
    end
end
local find
do 
    local __index = getrawmetatable(game).__index
    find = function(inst, child) 
        local a,b = pcall(__index, inst, child)
        return a and b or nil
    end
end

local function twn(object, dest, time)
    local tween = serv_ts:Create(object, TweenInfo.new(time, 8, 1), dest)
    tween:Play()
    return tween
end


local function RaycastVisibility(v1,v2,p1)
	local rayResult = workspace:Raycast(v1, cfn(v1, v2).LookVector * 20,p1)
	
	if rayResult then
		local p = rayResult.Instance
		return not (p and true or false)
		
	end
	return true
end

-- existance check
do 
    for _,gui in ipairs(game.CoreGui:GetChildren()) do
        if find(gui, "TextLabel") and find(gui, "Frame") then
            if find(gui.Frame, "ImageLabel") and gui.Frame.ImageLabel.Image == "rbxassetid://7603818383" then    
                if gui.Enabled == false then gui.Enabled = true return end
                
            end
        end
    end
end

-- { UI } --

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_3/main.lua'))()

local window = ui:NewWindow("<font color='rgb(64,64,255)'>Jeff</font> Hoops 3 | <font color='rgb(255,64,64)'>BETA PREVIEW</font>", 500, 400)

local m_home = window:AddMenu("Home")
local m_ball = window:AddMenu("Ball")
local m_player = window:AddMenu("Player")
local m_misc = window:AddMenu("Misc")
local m_handles = window:AddMenu("Fast handles")
local m_config = window:AddMenu("Config")

do
    local s_1 = m_home:AddSection('Home')
    s_1:AddLabel("Jeff Hoops made by topit")
    s_1:AddButton("Join the discord"):SetTooltip("Click to copy discord invite"):ConnectFlag("Clicked", function() 
        setclipboard('https://discord.gg/Gn9vWr8DJC')
    end)
    local s_2 = m_home:AddSection('Changelog')
    s_2:AddLabel("<u>v3.0.0 BETA</u>")
    s_2:AddLabel("- Remade everything")
    s_2:AddLabel("- Switched ui libraries (twice)")
    s_2:AddLabel("- Added a bunch of stuff")
end


local s_aimbot = m_ball:AddSection("Aimbot","Auto green")
  local b_aimbot      = s_aimbot:AddToggle("Aimbot") --aimbot
  s_aimbot:AddLabel('Settings')
  local b_aimbotm     = s_aimbot:AddDropdown("Aimbot mode",1,{"Classic","One tap"}) --aimbot mode
  local b_aimbotd     = s_aimbot:AddToggle("Custom delay") --aimbot delay
  local b_aimbotdamt  = s_aimbot:AddSlider("Custom delay (MS)",1,{min=475,max=550,current=505}) --aimbot delay amount
  local b_autogreen   = s_aimbot:AddToggle("Auto green", 2)
  s_aimbot:AddLabel('Settings', 2)
  local b_autogreenm  = s_aimbot:AddDropdown("Auto green method",2,{"Bar cutter","Public","Keyrelease"})
  
  b_aimbotm:SetTooltip("Changes how the aimbot works. Only classic is finished as of now.\nClassic: Hold R until you red aimbot\nOne press: Tap R once to do a jump shot automatically")
  b_aimbot:SetTooltip("Not yet compatible with free throws; use auto green until updated")
  b_aimbotd:SetTooltip("Uses the inputted delay instead of predicting the delay")
  b_autogreen:SetTooltip("Depends on ping and distance, but can get greens for you. Works w/ free throws")
  b_autogreenm:SetTooltip("Uses a different auto green method.\nBar cutter: Shorter bars, works as good as public\nPublic: Upgraded version of publically known tap[134] method\nKey: Uses keyrelease, make sure your shoot bind is R")
  
 
local s_dunks = m_ball:AddSection("Dunks")
  local b_powerdunk = s_dunks:AddToggle("Power dunks")
  local b_betterdunks = s_dunks:AddToggle("Better dunks")
  
  b_powerdunk:SetTooltip("Classic power dunks. Lets you strafe midair")
  b_betterdunks:SetTooltip("Gives you more consistent dunks. Works well with most dunk animations")

local s_auto = m_ball:AddSection("Auto")
  local b_autoinbound = s_auto:AddToggle("Auto inbound")
  local b_autograb = s_auto:AddToggle("Auto grab")
  b_autoinbound:SetTooltip("Teleports you to the inbound circle when theres an ib for your team")
  b_autograb:SetTooltip("Immediately gives you the ball when it can, also interferes with free throws and other player's dunks. OP but obvious")

--[[
  local b_fly = m_ball:AddToggle("Ball fly")
  
  b_fly:SetTooltip("(usually) instantly flies you to the hoop when you pickup the ball")
]]--

local s_render = m_ball:AddSection("Render")
  local b_prediction = s_render:AddToggle("Ball prediction")
  local b_predictionmode = s_render:AddDropdown("Prediction style",1,{"Simple","GUI","Drawing"})
  local b_highlight = s_render:AddToggle("Highlight")
  local b_cam = s_render:AddToggle("Ball cam")
  
  b_prediction:SetTooltip("Shows where the ball should land. Doesn't include collisions, may not be 100% accurate")
  b_predictionmode:SetTooltip("The prediction style.\nDrawing: Laggy but undetectable, requires drawing library\nSimple: Simple mode\nGUI: Uses billboard guis, looks cool")
  b_highlight:SetTooltip("Highlights the ball so you know where it is at all times")
  b_cam:SetTooltip("Custom ball cam")

local s_troll = m_ball:AddSection("Troll")
  local b_spamshoot = s_troll:AddToggle("Spam shoot")
  local b_fly = s_troll:AddToggle("Ball fly")
  b_spamshoot:SetTooltip("Spam shoots the ball when it can. No longer lags your game after extended use")
  b_fly:SetTooltip("(usually) instantly flies you to the hoop when you pickup the ball")
  

local s_wip = m_ball:AddSection("Work in progress")
  local b_autolayup = s_wip:AddToggle("Auto layup")
  b_autolayup:SetTooltip("Automatically layups when you're close to the hoop. Can be seen as obvious")



local s_movement = m_player:AddSection("Stamina","Movement")
  local p_infstam = s_movement:AddToggle("Infinite stamina",1)
  local p_stamspeed = s_movement:AddToggle("Custom stamina drain",1)
  local p_stamspeedamt = s_movement:AddSlider("Stamina drain speed",1, {min=0,max=20,current=20})
  local p_noslow = s_movement:AddToggle("Noslowdown",2)
  local p_cctp = s_movement:AddToggle("Ctrl+Click teleport",2)
  local p_speed = s_movement:AddToggle("Legit speedhack",2)
  local p_njcd = s_movement:AddToggle("No jump cooldown",2)
  local p_jumpboost = s_movement:AddToggle("Jump boost",2)
  local p_jumpboostamt = s_movement:AddSlider("Jump boost amount",2, {min=1,max=150,current=75})
  
  p_infstam:SetTooltip("Classic infinite stamina. Hides the stamina bar.")
  p_stamspeed:SetTooltip("Changes how fast or slow your stamina drains.")
  p_stamspeedamt:SetTooltip("How fast or slow your stamina drains. 0 would freeze stamina, 20 would make it normal.")
  p_noslow:SetTooltip("Prevents you from being slowed down.")
  p_cctp:SetTooltip("Classic ctrl + click tp.")
  p_speed:SetTooltip("Speed thats slightly faster than normal sprinting.")
  p_njcd:SetTooltip("Emulates a jump, bypassing the cooldown. Also has less jump delay (0.25s -> 0.02s).")
  

  --p_stamspeed:Assert('getconstant')
  --p_stamspeed:Assert("setconstant")
  --p_stamspeed:Assert('getgc')
  --p_stamspeed:Assert('islclosure')
  

local s_steals = m_player:AddSection("Steals")
  local p_hbe = s_steals:AddToggle("Hitbox expander")
  local p_hbe2 = s_steals:AddToggle("Hitbox expander [other team]")
  local p_hbesize = s_steals:AddSlider("Hitbox expander size",1,{min=5,max=20,current=5,step=0.5})
  
  local p_stealaura = s_steals:AddToggle("Steal aura")
  local p_antisteal = s_steals:AddToggle("Anti-steal")
  
  p_hbe:SetTooltip("Your average HBE, but more customizable")
  p_hbe2:SetTooltip("Your average HBE, but for the other team")
  p_hbesize:SetTooltip("Controls the size of the HBE")
  p_stealaura:SetTooltip("Should make whoever you walk into drop the ball. Uses animations, so it might be obvious.")
  p_antisteal:SetTooltip("Spam G when you're not shooting to prevent steals. Stop spamming before you shoot, or else it'll glitch. Obligatory does not always work")
  
  --p_stealaura:Assert("firetouchinterest")



local s_OP = m_player:AddSection("OP")
  local p_nodelay = s_OP:AddToggle("No delay")
  local p_autoblock = s_OP:AddToggle("Auto block")
  local p_autoblockfacecheck = s_OP:AddToggle("Auto block facing check")
  local p_autoblockrange = s_OP:AddSlider("Auto block range",1,{min=5,max=25,current=15,step=0.5})
  --p_nodelay:Assert("setconstant")
  p_nodelay:SetTooltip("Removes steal delay. Will effect other things eventually.")
  p_autoblock:SetTooltip("Automatically jumps towards cfn that are about to shoot")
  p_autoblockfacecheck:SetTooltip("Only jumps towards the ball if you are facing towards the shooter, and not away")
  p_autoblockrange:SetTooltip("Only jumps towards cfn within this radius (magnitude check)")



local s_p_troll = m_player:AddSection("Troll")
  local p_tptoball = s_p_troll:AddToggle("TP to ball")
  local p_tptoballmode = s_p_troll:AddDropdown("TP to ball mode",1, {"Always","When not holding","When teams not holding","When other team holding"})
  local p_lookall = s_p_troll:AddButton("Force everyone to face you")
  
  p_tptoball:SetTooltip("Teleports you to the ball")
  p_lookall:SetTooltip("Makes everyone look at you as if you were passing to them")
  
local s_p_misc = m_player:AddSection("Misc")
  local p_antivoid = s_p_misc:AddToggle("Anti-void")
  local p_bounds = s_p_misc:AddToggle("Bounds")


local s_m_panic = m_misc:AddSection("Panic")
  local m_hidegui = s_m_panic:AddToggle("Hide GUI")
  local m_panic = s_m_panic:AddButton("Panic")
  m_hidegui:SetTooltip("When enabled, the GUI gets disabled until untoggled (hotkey) or you say /e enable. Useful for screensharing")
  m_panic:SetTooltip("Immediately disables all enabled modules")
  
local s_m_game = m_misc:AddSection("Game")
  local m_fixgame = s_m_game:AddButton("Fix game")
  local m_camfix = s_m_game:AddToggle("Auto fix camera")
  local m_deafen = s_m_game:AddToggle("Deafen")
  local m_antiplr = s_m_game:AddToggle("Anti-playergrade")
  
  m_fixgame:SetTooltip("Fixes a lot of issues the game may have.")
  m_deafen:SetTooltip("Removes some loud game sounds, like the cheering and buzzer.")
  m_antiplr:SetTooltip("Removes playergrade related remotes and scripts, possibly preventing player grade drops.")
  m_camfix:SetTooltip("Prevents the camera from bugging out and not focusing on your character")

local s_m_render = m_misc:AddSection("Render")
  local m_nightmode = s_m_render:AddToggle("Nightmode")
  local m_cstamgui = s_m_render:AddToggle("Custom stamina bar")
  
  m_nightmode:SetTooltip("Makes the court dark with lights")
  m_cstamgui:SetTooltip("Uses a custom stamina bar")
  --m_nightmode:Assert("sethiddenproperty")
  
local s_m_server = m_misc:AddSection("Server")
  local m_rejoin = s_m_server:AddButton("Rejoin")
  local m_shop = s_m_server:AddButton("Serverhop")
  local m_priv = s_m_server:AddButton("Join smallest server")

p_antivoid:SetTooltip("If you fall under the map, you get kicked from the server. Antivoid teleports you up if you fall under.")
p_bounds:SetTooltip("Makes boundaries around the court so you don't foul. Still a WIP")


m_handles:AddSection("Handles"):AddLabel("WIP :(").GetParent():AddLabel("Use older jeff hoops for fast handles until then")
m_config:AddSection("Config"):AddLabel("WIP :(").GetParent():AddLabel("Coming soon")
m_config:AddSection("Config preview")


b_autolayup:SetTooltip("Unfinished")
p_bounds:SetTooltip("Unfinished")

m_antiplr:SetTooltip("Unfinished")
m_rejoin:SetTooltip("Unfinished")
m_shop:SetTooltip("Unfinished")
m_priv:SetTooltip("Unfinished")



-- { Variables & Callbacks } --

local plr = serv_players.LocalPlayer
local mouse = plr:GetMouse()

local rimpositions = require(serv_replicated.Modules.RimPositions)
local loadanims = require(plr.PlayerScripts.Modules.LoadAnimations)

local ballpointer = serv_replicated.GameBall
local gameball = ballpointer.Value
local curr_rim
if plr.Character and find(plr.Character, "HumanoidRootPart") then
    curr_rim = rimpositions.GetOffensiveRim(plr)
end

local statepointer = serv_replicated.Scoreboard.GameState

local scall = (syn and syn.secure_call) or (secure_call or securecall) or warn("Your exploit doesn't support secure call!")
-- secure call will definitely not be needed

local ping = game:GetService("Stats").PerformanceStats.Ping

local connections = {}


connections["BUP"] = ballpointer:GetPropertyChangedSignal("Value"):Connect(function()
    gameball = ballpointer.Value
end)

connections['RIM'] = plr:GetPropertyChangedSignal("Team"):Connect(function() 
    wait(0.1)
    curr_rim = rimpositions.GetOffensiveRim(plr)
end)


local plr_chr
local plr_humrp
local plr_hum
local plr_head

do 
    local plr_chr = plr.Character
    if plr_chr then
        plr_humrp = find(plr_chr, "HumanoidRootPart")
        plr_hum = find(plr_chr, "Humanoid")
        plr_head = find(plr_chr, "Head")
    end
    
    
    connections["RESP"] = plr.CharacterAdded:Connect(function(c) 
        plr_chr = c
        plr_humrp = c:WaitForChild("HumanoidRootPart",3)
        plr_hum = c:WaitForChild("Humanoid",3)
        plr_head = c:WaitForChild("Head",3)
    end)
    
end





--stamina
do

    p_infstam:ConnectFlag("Enabled", function()
        -- get stamina value
        local stamina = plr.PlayerScripts.Events.Player.Stamina.Stamina


        serv_rs:BindToRenderStep("JH3-IS", 600, function()
            stamina.Value = 1050
        end)

        connections["IS"] = plr.CharacterAdded:Connect(function(chr)
            local h = chr:WaitForChild("Head", 4)
            if h then
                -- how has nobody thought of this yet
                -- makes it look better
                
                local bar1 = find(h, "StaminaBar")
                local bar2 = find(h, "JHStaminaBar")
                
                if bar1 then bar1.Enabled = false end
                if bar2 then bar2.Enabled = false end
                
                
            else
                warn("Oopsies; infinite stamina couldn't work properly")
            end

        end)

        local h = find(plr.Character, "Head")
        if h then 
            local bar1 = find(h, "StaminaBar")
            local bar2 = find(h, "JHStaminaBar")
            
            if bar1 then bar1.Enabled = false end
            if bar2 then bar2.Enabled = false end
        end
    end)

    p_infstam:ConnectFlag("Disabled", function()
        serv_rs:UnbindFromRenderStep("JH3-IS")
        connections["IS"]:Disconnect()

        local h = find(plr.Character, "Head")
        if h then 
            if m_cstamgui:IsEnabled() then
                local bar1 = find(h, "StaminaBar")
                local bar2 = find(h, "JHStaminaBar")
                
                if bar1 then bar1.Enabled = false end
                if bar2 then bar2.Enabled = true end
            else
                local bar1 = find(h, "StaminaBar")
                
                if bar1 then bar1.Enabled = true end
            end
        end
    end)
end
-- custom drain
do 
    local funcs = {}
    p_stamspeed:ConnectFlag("Enabled",function() 
        --get script
        
        funcs = {}
        connections["SS1"] = plr.CharacterAdded:Connect(function(c) 
            p_stamspeed:Hide("Waiting...")
            wait(0.5)
            p_stamspeed:Unhide()
            if connections["SS2"] then connections["SS2"]:Disconnect() end
            
            funcs = {}
            
            for _,proto in ipairs(getgc()) do
                if type(proto) == "function" and islclosure(proto) then
                    pcall(function() 
                        local c1 = getconstant(proto, 1)
                        local c2 = getconstant(proto, 2)
                        local c3 = getconstant(proto, 3)
                        local c4 = getconstant(proto, 4)
                        
                        if type(c4) == "number" and tostring(c3) == "wait" then
                            if c2 == 0 and c1 == "Value" then
                                ins(funcs, proto)
                                setconstant(proto, 4, p_stamspeedamt:GetValue()*0.1)
                            end
                        end
                    end)
                end
            end
            
            connections["SS2"] = p_stamspeedamt:ConnectFlag("ValueChanged",function(val) 
                for _,proto in ipairs(funcs) do
                    setconstant(proto, 4, val*0.1)
                end
            end)
        end)
        
        for i,proto in ipairs(getgc()) do
            if type(proto) == "function" and islclosure(proto) then
                pcall(function() 
                    local c1 = getconstant(proto, 1)
                    local c2 = getconstant(proto, 2)
                    local c3 = getconstant(proto, 3)
                    local c4 = getconstant(proto, 4)
                    
                    if type(c4) == "number" and tostring(c3) == "wait" then
                        if c2 == 0 and c1 == "Value" then
                            ins(funcs, proto)
                            setconstant(proto, 4, p_stamspeedamt:GetValue()*0.1)
                        end
                    end
                end)
            end
        end
        
        connections["SS2"] = p_stamspeedamt:ConnectFlag("ValueChanged",function(val) 
            for _,proto in ipairs(funcs) do
                setconstant(proto, 4, val*0.1)
            end
        end)
    end)
    
    p_stamspeed:ConnectFlag("Disabled",function() 
        for _,proto in ipairs(funcs) do
            setconstant(proto, 4, 2.083)
        end
        
        connections["SS1"]:Disconnect()
        connections["SS2"]:Disconnect()
        
        funcs = {}
    end)
end
--noslow
do
    p_noslow:ConnectFlag("Enabled",function()
        local event = plr.PlayerScripts.Events.Player.DisableControls
        event:Fire(false)
        

        connections["NS1"] = plr.CharacterAdded:Connect(function(c)
            wait(0.05)
            
            connections["NS2"]:Disconnect()
            connections["NS2"] = plr_humrp:GetPropertyChangedSignal("Anchored"):Connect(function()
                plr_humrp.Anchored = false
            end)
        end)
        
        
        connections["NS2"] = plr_humrp:GetPropertyChangedSignal("Anchored"):Connect(function()
            plr_humrp.Anchored = false
        end)


        serv_rs:BindToRenderStep("JH3-NS", 605, function()
            pcall(function() -- no error handling kek
                if plr_hum.WalkSpeed < 16 then
                    plr_hum.WalkSpeed = 16
                end
            end)
        end)
    end)

    p_noslow:ConnectFlag("Disabled",function()
        serv_rs:UnbindFromRenderStep("JH3-NS")
        
        connections["NS1"]:Disconnect()
        connections["NS2"]:Disconnect()
    end)
end
--autograb
do
    b_autograb:ConnectFlag("Enabled",function()
        -- get shit
        local la = find(plr.Character, "Left Arm")
        local ra = find(plr.Character, "Right Arm")
        -- update arm (noslow method)
        connections["AG"] = plr.CharacterAdded:Connect(function(chr)
            la = chr:WaitForChild("Left Arm", 4)
            ra = chr:WaitForChild("Right Arm",4)
        end)

        serv_rs:BindToRenderStep("JH3-AG", 700, function()
            pcall(firetouchinterest, la, gameball, 0)
            pcall(firetouchinterest, la, gameball, 1)
            
            pcall(firetouchinterest, ra, gameball, 0)
            pcall(firetouchinterest, ra, gameball, 1)
        end)
    end)

    b_autograb:ConnectFlag("Disabled",function()
        connections["AG"]:Disconnect()
        serv_rs:UnbindFromRenderStep("JH3-AG")
    end)

    --b_autograb:Assert("firetouchinterest")
end
-- velocity
do 
    local objs = {}
    local prevmode = 0
    b_prediction:ConnectFlag("Enabled",function()
        local grav = vec3(0, workspace.Gravity, 0)
        local mode = b_predictionmode:GetSelection()
        if mode == "Drawing" then
            if Drawing == nil then
                prevmode = 0
                ui:SendNotification("Oopsies","Your exploit doesn't have Drawing. Use something better like krnl or jjsploit",3)
                b_prediction:Toggle()
                return 
            end
            
            prevmode = 1
            
            local func = cam.WorldToViewportPoint
            
            for i = 1, 25 do 
                local line = Drawing.new("Line")
                line.Color = c3n(0.2, 0.2, 1)
                line.Thickness = 5
                line.Visible = true 
                
                
                ins(objs, line) 
            end
            
            spawn(function()
                wait(0.1)
                local params = RaycastParams.new()
                --params.FilterDescendantsInstances = {workspace["Stadium"],workspace["Floor"]}
                --params.FilterType = Enum.RaycastFilterType.Whitelist
                
                params.FilterDescendantsInstances = {gameball}
                params.FilterType = Enum.RaycastFilterType.Blacklist
                
                wait(0.05)
                
                while b_prediction:IsEnabled() do
                    --foreach(objs, function(_,obj) obj.Visible = false end)
                    --for _,a in ipairs(objs) do a.Visible = false end
                    
                    for idx,obj in ipairs(objs) do
                        -- get pseudo deltatime 
                        local dt = idx*0.03
                        -- calculate roughly where the ball should be for 1 step
                        local pos_3d = gameball.Position + ((gameball.Velocity*1.4) * dt - (grav * dt^2))
                        -- raycast to see if that position is visible
                        local vis_3d = RaycastVisibility(pos_3d, cam.CFrame.Position, params)
                        
                        if vis_3d == false then 
                            -- if its not then immediately cancel the loop, no more checks need to be done
                            
                            -- also make every line (inclusive of this one) invisible
                            for i = idx, #objs do objs[i].Visible = false end
                            
                            -- break
                            break 
                        end
                        -- otherwise "render" the vector to the screen
                        local pos_2d,vis_2d = func(cam, pos_3d)
                        if vis_2d == false then
                            -- if that position isnt visible then break too
                            for i = idx, #objs do objs[i].Visible = false end
                            
                            break 
                        end
                        
                        
                        -- get next steps pseudo deltatime
                        local dt = (idx+1)*0.03
                        -- calculate where the ball should be for the next step
                        local pos2_3d = gameball.Position + ((gameball.Velocity*1.4) * dt - (grav * dt^2))
                        -- raycast to see if that position is visible
                        local vis2_3d = RaycastVisibility(pos2_3d, cam.CFrame.Position, params)
                        
                        if vis2_3d == false then
                            -- same logic as before
                            for i = idx, #objs do objs[i].Visible = false end
                            break 
                        end
                        -- get 2d variants
                        local pos2_2d,vis2_2d = func(cam, pos2_3d)
                        
                        if vis2_2d == false then
                            for i = idx, #objs do objs[i].Visible = false end
                            break 
                        end
                        
                        obj.Visible = true
                        obj.To = vec2(pos_2d.X, pos_2d.Y)
                        obj.From = vec2(pos2_2d.X, pos2_2d.Y)
                        -- and thats just for one line
                        
                    end
                    wait()
                    wait()
                end
            end)
            
        elseif mode == "Simple" then
            prevmode = 2
            
            for i = 1, 30 do 
                local e = Instance.new("Part")
                e.Anchored = true
                e.Transparency = 1
                e.CanCollide = false
                e.Size = vec3(0,0,0)
                e.CanTouch = false
                e.Position = vec3(0, -5, 0)
                e.Parent = workspace
                
        		local a = Instance.new("SelectionSphere")
        		a.Adornee = e
        		a.Transparency = 0.2
        		a.Color3 = c3n(1,1,1)
        		a.Parent = e
        		ins(objs, e)
            end



            spawn(function()
                

                while b_prediction:IsEnabled() do
                    for idx,obj in ipairs(objs) do
                        local dt = idx*0.04
                        local pos_3d = gameball.Position + ((gameball.Velocity*1.4) * dt - (grav * dt^2))
                        
                        obj.Position = pos_3d
                        
                        if pos_3d.Y < -1 then
                            for i = idx, #objs do
                                objs[i].Position=vec3(0,-5,0)
                            end
                            break
                        end
                    end
                    wait()
                end
            end)
        elseif mode == "GUI" then
            prevmode = 3 
            
            local c1, c2 = hsv(random(0,100)*0.01, 1, 1), hsv(random(0,100)*0.01, 1, 1)
            
            for i = 1, 25 do 
                local e = Instance.new("Part")
                e.Anchored = true
                e.Transparency = 0.8
                e.CanCollide = false
                e.Size = vec3(.1,.1,.1)
                e.CanTouch = false
                e.Position = vec3(0, -5, 0)
                e.Parent = workspace
                
                local a = Instance.new("BillboardGui")
                a.Size = UDim2.new(0.4, 6, 0.4, 6)
                a.LightInfluence = 0
                a.Enabled = true
                a.Name = "g"
                a.Parent = e 
                
                
                local t = Instance.new("TextLabel")
                t.BackgroundColor3 = c1:lerp(c2,i/25)
                t.Rotation = 90*(i/25)
                t.BorderColor3 = c3n(.1, .1, .1)
                t.BorderSizePixel = 1
                t.Size = UDim2.new(1, 0, 1, 0)
                t.BackgroundTransparency = 0.1
                t.Name = "f"
                t.TextScaled = true
                t.Font = Enum.Font.Nunito
                t.TextColor3 = c3n(1,1,1)
                t.TextStrokeTransparency = 0
                t.Text = ""
                t.Parent = a
                
                ins(objs, e) 
            end
            
            
            spawn(function()
                
                local magn
                while b_prediction:IsEnabled() do
                    pcall(function() 
                        magn = plr_humrp.Position
                    end)
                    local t = tick()
                    for idx,obj in ipairs(objs) do
                        local dt = idx*0.04
                        local pos_3d = gameball.Position + ((gameball.Velocity*1.4) * dt - (grav * dt^2))
                        
                        obj['g']['f'].Rotation = (sin(t+idx*0.1)*90)
                        obj.Position = pos_3d
                        
                        if pos_3d.Y < -1 then
                            for i = idx, #objs do
                                objs[i].Position=vec3(0,-5,0)
                            end
                            break
                        end
                    end
                    wait()
                end
            end)
            
            
        elseif mode == "Numbers" then
            prevmode = 4
            
            for i = 1, 25 do 
                local e = Instance.new("Part")
                e.Anchored = true
                e.Transparency = 1
                e.CanCollide = false
                e.CanTouch = false
                e.Size = vec3(.1,.1,.1)
                e.Position = vec3(0, -5, 0)
                e.Parent = workspace
                
                local a = Instance.new("BillboardGui")
                a.Size = UDim2.new(0.7, 6, 0.7, 6)
                a.LightInfluence = 0
                a.Enabled = true
                a.Name = "g"
                a.Parent = e 
                
                local t = Instance.new("TextLabel")
                t.TextColor3 = c3n(0,1,0):lerp(c3n(1,0,0),i/25)
                t.TextStrokeColor3 = c3n(0,0,0)
                t.BackgroundTransparency = 1
                t.Size = UDim2.new(1, 0, 1, 0)
                t.Name = "f"
                t.TextScaled = true
                t.Font = Enum.Font.Nunito
                t.TextStrokeTransparency = 0
                t.Text = i
                t.Parent = a
                
                ins(objs, e) 
            end


            spawn(function()
                

                while b_prediction:IsEnabled() do
                    for idx,obj in ipairs(objs) do
                        local dt = idx*0.04
                        local pos_3d = gameball.Position + ((gameball.Velocity*1.4) * dt - (grav * dt^2))
                        
                        obj.Position = pos_3d
                        
                        if pos_3d.Y < -1 then
                            for i = idx, #objs do
                                objs[i].Position=vec3(0,-5,0)
                            end
                            break
                        end
                    end
                    wait()
                end
            end)
        end
    end)    
    b_prediction:ConnectFlag("Disabled",function() 
        if prevmode == 1 then
            wait(0.5)
            for _,obj in ipairs(objs) do
                for x=1,3 do
                    pcall(function() 
                        obj:Remove()
                    end)
                end
            end
            objs = {}
        else
            for _,obj in ipairs(objs) do
                obj:Destroy() 
            end
            objs = {}
        end
    end)
    
    b_predictionmode:ConnectFlag("SelectionChanged",function() 
        if b_prediction:IsEnabled() then
            b_prediction:Toggle()
            b_prediction:Toggle()
        end
    end)
end
--clicktp
do
    p_cctp:ConnectFlag("Enabled",function()
        connections["CCTP"] = mouse.Button1Down:Connect(function()
            if serv_uis:IsKeyDown('LeftControl') then
                if not plr_humrp then return end
                
                pcall(function()
                    mouse.TargetFilter = workspace.RestrictedCircle
                end)

                local lv = plr_humrp.CFrame.LookVector
                local p = mouse.Hit.Position + vec3(0, 3, 0)
                plr_humrp.CFrame = cfn(p, p+lv)

            end
        end)

    end)

    p_cctp:ConnectFlag("Disabled",function()
        connections["CCTP"]:Disconnect()
    end)
end
--spamthrow
do
    b_spamshoot:ConnectFlag("Enabled",function()
        
        local startShooting = serv_replicated.Ball.StartShooting
        local endShooting = serv_replicated.Player.Passing.PassBall
        
        local w = serv_rs.RenderStepped
        
        while b_spamshoot:IsEnabled() do
            -- pass to self to fling ball
            endShooting:FireServer(plr_humrp)
            w:Wait()
        end
    end)
end
--auto ib
do 
    b_autoinbound:ConnectFlag("Enabled",function() 
        connections["IB"] = workspace.ChildAdded:Connect(function(c) 
            if c.Name == "ThrowIn" then
                -- if the ib thing gets spawned then
                -- wait for the circle thing
                local f = workspace:WaitForChild("RestrictedCircle", 5)
                
                if f.Display.BrickColor == plr.TeamColor then
                    
                    if gameball.Parent == workspace then
                        plr_humrp.CFrame = c.CFrame
                    end
                end
            end
        end)
    end)

    b_autoinbound:ConnectFlag("Disabled",function()
        connections["IB"]:Disconnect()
    end)
end
--power dunks
do 
    b_powerdunk:ConnectFlag("Enabled",function() 
        local new = PhysicalProperties.new(100, 0.3, 0.5)
        
        -- whoever made power dunks originally
        -- just pasted inf yield 
        
        connections['PD'] = plr.CharacterAdded:Connect(function(c) 
            wait(0.05)
            for i,v in ipairs(c:GetChildren()) do
                if find(v, "CustomPhysicalProperties") then
                    v.CustomPhysicalProperties = new
                end
            end
        end)
        
        for i,v in ipairs(plr.Character:GetChildren()) do
            if find(v, "CustomPhysicalProperties") then
                v.CustomPhysicalProperties = new
            end
        end
    end)

    b_powerdunk:ConnectFlag("Disabled",function() 
        local new = PhysicalProperties.new(0.7, 0.3, 0)

        for i,v in ipairs(plr.Character:GetChildren()) do
            if find(v, "CustomPhysicalProperties") then
                v.CustomPhysicalProperties = new
            end
        end
    end)
end
--ball fly
do 
    local ballfly
    
    b_fly:ConnectFlag("Enabled",function() 
        local g = curr_rim

        ballfly = Instance.new("BodyPosition")
        ballfly.Parent = gameball
        ballfly.D = 125
        ballfly.MaxForce = vec3(999999, 999999, 999999)
        ballfly.Position = vec3(g.X / 1.1, g.Y, g.Z)
        
        while b_fly:IsEnabled() do
            pcall(function() 
                local g = curr_rim
                
                ballfly.Position = vec3(g.X / 1.1, g.Y, g.Z)
                ballfly.Parent = gameball
            end)
            wait(20)
        end 
    end)

    b_fly:ConnectFlag("Disabled",function() 
        ballfly:Destroy()
    end)
end
-- no delay
do
    p_nodelay:ConnectFlag("Enabled",function() 
        local chr = plr.Character

        connections["ND"] = plr.CharacterAdded:Connect(function(c) 
            wait(0.05)
            local s = getsenv(c["BallControl"]["Defense - Client"])["Steal_Ball"]
            setconstant(s, 31, 0)
            
        end)

        if not find(chr, "BallControl") then 
            warn("[ND] No character, waiting until next spawn to enable") 
            return 
        end
        
        
        
        local s = getsenv(chr["BallControl"]["Defense - Client"])["Steal_Ball"]
        setconstant(s, 31, 0)

    end)
    p_nodelay:ConnectFlag("Disabled",function() 
        connections["ND"]:Disconnect()

        local chr = plr.Character
        if not find(chr, "BallControl") then
            --ui:NewMessagebox("Oopsies","You have to be spawned in!")
            ui:SendNotification("Oops","You have to be spawned in",3)
            p_nodelay:Toggle()
            return
        end

        local s = getsenv(chr["BallControl"]["Defense - Client"])["Steal_Ball"]
        setconstant(s, 31, 1.2)
    end)
end
-- hbe
do 
    p_hbe:ConnectFlag("Enabled",function() 
        if not plr.Character then
            p_hbe:Hide("Waiting for character spawn...")
            plr.CharacterAdded:Wait()
            p_hbe:Unhide()
            wait(0.35)
        end
        
        
        local h = find(plr.Character, "HumanoidRootPart")
        
        
        connections["HBE1"] = plr.CharacterAdded:Connect(function(c)
            local h = c:WaitForChild("HumanoidRootPart", 3)
            if not h then 
                warn("[HBE] Couldn't apply HBE properly! Try resetting")
                ui:SendNotification("Oopsies","Something went wrong, check your console " .. (syn and getsynasset and "(internal synapse ui)" or "(F9 or ins)"), 3)
                return 
            end 
            
			local size = p_hbesize:GetValue()
			h.Size = vec3(size, 2, size)
			h.Transparency = 0.7

			connections["HBE2"]:Disconnect()
			wait()
			connections["HBE2"] = p_hbesize:ConnectFlag("ValueChanged",function(size) 
            	h.Size = vec3(size, 2, size)
        	end)
        end)

        if not h then 
            warn("[HBE] No character, waiting until respawn")
            return 
        end
        
        local size = p_hbesize:GetValue()
        h.Size = vec3(size, 2, size)
        h.Transparency = 0.7
        
        connections["HBE2"] = p_hbesize:ConnectFlag("ValueChanged",function(size) 
            h.Size = vec3(size, 2, size)
        end)
        
    end)
    p_hbe:ConnectFlag("Disabled",function() 
        local h = find(plr.Character, "HumanoidRootPart")
        if h then
            h.Size = vec3(2, 2, 1)
            h.Transparency = 1  
        end
        
        connections["HBE1"]:Disconnect()
        connections["HBE2"]:Disconnect()
    end)
    
    local hbe2cons = {}
    p_hbe2:ConnectFlag("Enabled",function()
        for _,p in ipairs(serv_players:GetPlayers()) do
            if p == plr then continue end
            
            local con = p.CharacterAdded:Connect(function(c) 
                if p.Team ~= plr.Team then
                    local humrp = c:WaitForChild("HumanoidRootPart", 5)
                    humrp.Size = vec3(p_hbesize:GetValue(), 2, p_hbesize:GetValue())
                    humrp.Transparency = 0.7
                end
            end)
            
            ins(hbe2cons, con)
            
            local humrp = find(p.Character, "HumanoidRootPart")
            if humrp and p.Team ~= plr.Team then
                humrp.Size = vec3(p_hbesize:GetValue(), 2, p_hbesize:GetValue())
                humrp.Transparency = 0.7
            end
        end
        
        connections["OHBE1"] = p_hbesize:ConnectFlag("ValueChanged",function() 
            for _,p in ipairs(serv_players:GetPlayers()) do
                if p == plr then continue end
                local humrp = find(p.Character, "HumanoidRootPart")
                if humrp and p.Team ~= plr.Team then
                    humrp.Size = vec3(p_hbesize:GetValue(), 2, p_hbesize:GetValue())
                    humrp.Transparency = 0.7
                end
            end
        end)
        
    end)
    p_hbe2:ConnectFlag("Disabled",function() 
        for _,con in ipairs(hbe2cons) do con:Disconnect() end
        for _,p in ipairs(serv_players:GetPlayers()) do 
            if p == plr then continue end
            local humrp = find(p.Character, "HumanoidRootPart")
            if humrp then 
                humrp.Size = vec3(2,2,1) 
                humrp.Transparency = 1 
            end
        end
        if connections["OHBE1"] then
            connections["OHBE1"]:Disconnect()
        end
        
        
    end)
end
-- speedhack
do 
    p_speed:ConnectFlag("Enabled",function()
        local hum = find(plr.Character, "Humanoid")
        connections["SPD"] = plr.CharacterAdded:Connect(function(c) 
            hum = c:WaitForChild("Humanoid", 4)
            if not hum then
                warn("[SPD] Humanoid not found; speedhack won't work. Try resetting.") 
            end
        end)
        serv_rs:BindToRenderStep("JH3-SPD", 1400, function() 
            pcall(function() 
                hum.WalkSpeed = 21
            end)
        end)
    end)
    
    p_speed:ConnectFlag("Disabled",function()
        serv_rs:UnbindFromRenderStep("JH3-SPD")
        
        local hum = find(plr.Character, "Humanoid")
        if not hum then return end 
        
        if serv_uis:IsKeyDown("LeftShift") then -- Enum.KeyCode.LeftShift
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
    
    
    p_njcd:ConnectFlag("Enabled",function() 
        -- get hum
        local function hook(c) 
            local hum = find(c, "Humanoid") or c:WaitForChild("Humanoid", 3)
            local humrp = find(c, "HumanoidRootPart")
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
            
            serv_ctx:UnbindAction("JH3-NJCD")
            
            serv_ctx:BindActionAtPriority("JH3-NJCD",function(_,is) 
                if is == Enum.UserInputState.Begin then
                    if hum.FloorMaterial == Enum.Material.Air then
                        return
                    end 
                    
                    
                    anim:play(0.25)
                    wait(0.02)
                    
                    if (humrp.Position - leftside.Position).Magnitude < 10 then
                        hum.JumpPower = 21.52
                    elseif (humrp.Position - rightside.Position).Magnitude < 10 then
                        hum.JumpPower = 21.52
                    else
                        hum.JumpPower = 18.64
                    end
                    
                    hum.Jump = true
                    wait(0.02)
                    hum.JumpPower = 0
                    
                end
            end, false, 999999, Enum.KeyCode.Space)
        end
        
        connections["NJCD2"] = plr.CharacterAdded:Connect(function(c) 
            hook(c)
            
            
        end)
        
        if find(plr.Character, "Humanoid") then         
            hook(plr.Character) 
        end 
    end)
    
    p_njcd:ConnectFlag("Disabled",function() 
        serv_ctx:UnbindAction("JH3-NJCD")
        connections["NJCD2"]:Disconnect()
    end)
end
-- AUTO GREEN
do 
    b_autogreen:ConnectFlag("Enabled",function() 
        local stop = serv_replicated.Ball.EndShooting
        local m = b_autogreenm:GetSelection()
        
        if m == "Keyrelease" then
            connections["AG1"] = workspace.ChildAdded:Connect(function(c) 
                if c.Name ~= "ShotMeter" then return end
                if find(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    local circle = (
                        find(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        find(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    
                    
                    local pointer
                    
                    wait(0.02)
                    local children = circle:GetChildren()
                    for i,v in pairs(children) do
                        if v.BackgroundColor3.R == 1 then
                            if tonumber(v.Name) > 15 then
                                pointer = circle[v.Name-3]
                                break
                            end
                        end
                    end
                    
                    if not pointer then pointer = circle["130"] end
                    
                    
                    pointer.BackgroundColor3 = c3n(0.27, 0.14, 0.76)
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
                if find(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    
                    local circle = (
                        find(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        find(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    circle:WaitForChild("1",2)
                    circle.Visible = false
                    
                    local pointer
                    
                    wait(0.02)
                    
                    local children = circle:GetChildren()
                    for i,v in ipairs(children) do
                        if v.BackgroundColor3.R == 1 then
                            if tonumber(v.Name) > 15 then
                                pointer = circle[v.Name]
                                break
                            end
                        end
                    end
                    if not pointer then pointer = circle["134"] end
                    
                    wait()
                    
                    for x = pointer.Name, 200 do
                        circle[x]:Destroy()
                    end
                    circle.Visible = true
                end
            end)
            
        elseif m == "Public" then
            connections["AG1"] = workspace.ChildAdded:Connect(function(c) 
                if c.Name ~= "ShotMeter" then return end
                if find(plr.Character, "Basketball") or statepointer.Value == "Free Throw" then
                    local circle = (
                        find(c, "SurfaceGui") or 
                        c:WaitForChild("SurfaceGui", 3)
                    )
                    circle = (
                        find(circle, "Circle") or 
                        circle:WaitForChild("Circle", 3)
                    )
                    
                    
                    local pointer
                    
                    wait(0.02)
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
                    
                    
                    pointer.BackgroundColor3 = c3n(0.27, 0.14, 0.76)
                    pointer.Name = "amoung pequeno"
                end
            end)
            
        end
    end)

    b_autogreen:ConnectFlag("Disabled",function() 
        connections["AG1"]:Disconnect()
    end)
    
    b_autogreenm:ConnectFlag("SelectionChanged",function(n) 
        if b_autogreen:IsEnabled() then
            b_autogreen:Toggle()
            b_autogreen:Toggle()
        end
    end)

end
-- AIMBOT
do 
    b_aimbot:ConnectFlag("Enabled",function() 
        local mode = b_aimbotm:GetSelection()
        local humrp = find(plr.Character, "HumanoidRootPart")
        if not humrp then
            b_aimbot:Hide("Waiting for respawn...")
            local c = plr.CharacterAdded:Wait()
            b_aimbot:Unhide()
            
            c:WaitForChild("HumanoidRootPart",2)
        end
        humrp = nil
        
        local freethrow_end = serv_replicated.Player.Shooting.FreeThrow.EndShooting
        local freethrow_start = serv_replicated.Player.Shooting.FreeThrow.StartShooting
        
        local shoot_end = serv_replicated.Ball.EndShooting
        local shoot_start = serv_replicated.Ball.StartShooting
        
        local layup_end = serv_replicated.Ball.Layup

        
        
        local color_table = {
            Great = c3n(1,1,0),
            Good = rgb(255,170,0),
            Bad = rgb(120,0,0),
            _ = c3n(0,1,0),
        }
        
        
        
        
        if connections["AIM2"] then connections["AIM2"]:Disconnect() end
        if mode == "Classic" then
            connections["AIM2"] = serv_uis.InputBegan:Connect(function(io,gpe) 
                if io.KeyCode == Enum.KeyCode.R then
                    local d = (plr_humrp.Position - curr_rim).Magnitude
                    local time_delay = (b_aimbotd:IsEnabled() and b_aimbotdamt:GetValue()*0.001) or (0.499 + (d * 0.0001))
                    
                    if gameball.Parent ~= plr.Character or serv_uis:GetFocusedTextBox() then
                        return        
                    end
                    
                    if statepointer.Value == "Free Throw" then 
                        local surf = workspace:WaitForChild("ShotMeter",1):WaitForChild("SurfaceGui",1)
                        
                        local frame 
                        for i,v in ipairs(surf.Circle:GetChildren()) do
                            if i < 20 then continue end
                            if v.BackgroundColor3.R == 1 then
                                frame = v 
                                break
                            end
                        end
                        freethrow_start:FireServer()
                        frame:GetPropertyChangedSignal("BackgroundColor3"):Wait()
                        local invoke,a,b,c = freethrow_end:InvokeServer()
                        
                        
                        local cl = surf:Clone()
                        surf.Enabled = false
                        
                        local color = invoke or c3n(0,255,0)
                        for i,v in ipairs(cl.Circle:GetChildren()) do 
                            v.BackgroundColor3 = color
                            v.BorderColor3 = color
                        end
                        
                        cl.Parent = surf.Parent
                    
                        ui:SendNotification("Aimbot [Free throw]",
                            "Ping:"..tostring(ping:GetValue()):sub(1,10)
                        ,2)
                        
                    else
                        local surf
                        
                        delay(.15, function() 
                            surf = find(workspace, "ShotMeter")
                            surf = surf and surf.SurfaceGui or nil
                        end)
                        shoot_start:FireServer()
                        wait(time_delay)
                        
                        if not surf then return end
                        
                        local invoke = shoot_end:InvokeServer(true,"Perfect")
                        local cl = surf:Clone()
                        surf.Enabled = false
                        
                        local color = color_table[invoke] or color_table['_']
                        for i,v in ipairs(cl.Circle:GetChildren()) do
                            v.BackgroundColor3 = color
                            v.BorderColor3 = color
                        end
                        
                        cl.Parent = surf.Parent
                    
                        ui:SendNotification("Aimbot",
                            "Delay:"..tostring(time_delay):sub(1,10)..
                            "\nAccuracy:"..tostring(invoke)..
                            "\nPing:"..tostring(ping:GetValue()):sub(1,10)..
                            "\nDistance:"..tostring(d):sub(1,10)
                        ,2)
                    end
                end
            end)
        end
        
    end)
    
    b_aimbot:ConnectFlag("Disabled",function()
        if connections["AIM2"] then connections["AIM2"]:Disconnect() end
    end)
end
-- stealaura
do 
    local going = false
    p_stealaura:ConnectFlag("Enabled",function() 
        local c = plr.Character
        local h = find(c, "Humanoid")
        local humrp = find(c, "HumanoidRootPart")
        
        connections["STA"] = plr.CharacterAdded:Connect(function(c) 
            going = true
            
            h = c:WaitForChild("Humanoid",3)
            humrp = c:WaitForChild("HumanoidRootPart",3)
            wait(0.1)
            
            local a = h:LoadAnimation(c.BallControl["Defense - Client"].Steal.Left)
            local b = h:LoadAnimation(c.BallControl["Defense - Client"].Steal.Right)
            spawn(function()
                while going do
                    a:Play(0, 0.05, 0.2)
                    wait(0.001)
                    b:Play(0, 0.05, 0.2)
                    
                    
                    -- this might slightly improve stealaura
                    -- but its not worth the performance loss
                    -- maybe something w/ touching the balls parent
                    --[[
                    for _,p in ipairs(serv_players:GetPlayers()) do
                        if p == plr then continue end
                        pcall(function() 
                            local humrp2 = p.Character.HumanoidRootPart
                            firetouchinterest(humrp, humrp2, 1)
                            firetouchinterest(humrp, humrp2, 0)
                        end) 
                    end
                    ]]
                
                
                    wait(0.001)
                end
            end)
        end)
        
        if h then 
            going = true
            local a = h:LoadAnimation(c.BallControl["Defense - Client"].Steal.Left)
            local b = h:LoadAnimation(c.BallControl["Defense - Client"].Steal.Right)
            spawn(function()
                while going do
                    a:Play(0, 0.05, 0.2)
                    wait()
                    b:Play(0, 0.05, 0.2)
                    wait()
                end
            end)
        end
    end) 
    p_stealaura:ConnectFlag("Disabled",function() 
        going = false
        if connections["STA"] then
            connections["STA"]:Disconnect() 
        end
    end)
    
    
    
end
-- antisteal
do 
    p_antisteal:ConnectFlag("Enabled",function() 
        local start = serv_replicated.Ball.StartShooting
        local stop = serv_replicated.Ball.EndShooting
        
        connections["AS1"] = serv_uis.InputBegan:Connect(function(io, gpe) 
            if io.KeyCode == Enum.KeyCode.G then 
                if gpe then return end
                spawn(function() 
                    --local id = random(0,1500)
                    --warn("[AS] New thread",id)
                    start:FireServer()
                    stop:InvokeServer()
                    --warn("[AS] Ended",id)
                end)
            end
        end)
        
        ui:SendNotification("Antisteal","Spam G while you aren't shooting to prevent steals.",3)
    end)

    p_antisteal:ConnectFlag("Disabled",function() 
        connections["AS1"]:Disconnect()
    
    
    end)
end
--auto block
do 
    p_autoblock:ConnectFlag("Enabled",function() 
        local c = plr.Character
        
        local hum = find(c, "Humanoid")
        local humrp = find(c, "HumanoidRootPart")
        local anim
        
        if not hum then 
            p_autoblock:Hide("Waiting for character spawn...")
            plr.CharacterAdded:Wait()
            p_autoblock:Unhide()
            
            wait(0.35)
            c = plr.Character
            hum = find(c, "Humanoid") or c:WaitForChild("Humanoid",4)
            humrp = find(c, "HumanoidRootPart")
        end
        
        anim = hum:LoadAnimation(c["BallControl"]["Defense - Client"].Block)
        
        connections["AB1"] = plr.CharacterAdded:Connect(function(c) 
            -- get humanoid
            hum = c:WaitForChild("Humanoid", 3)
            -- wait for other instances
            wait(0.05)
            -- get humrp and load anim
            humrp = find(plr.Character, "HumanoidRootPart")
            anim = hum:LoadAnimation(c:WaitForChild("BallControl", 3)["Defense - Client"].Block)
        end)
        
        local function jump() 
            if hum.FloorMaterial == Enum.Material.Air then
                return
            end 
            
            serv_rs:BindToRenderStep("JH3-AB",900,function() 
                hum:Move(cfn(humrp.Position, gameball.Position).LookVector)
            end)
            wait(0.1)
            anim:play(0.25)
            wait(0.02)
            
            hum.JumpPower = 18.64
            hum.Jump = true
            wait(0.02)
            hum.JumpPower = 0
            wait(0.2)
            serv_rs:UnbindFromRenderStep("JH3-AB")
        end
        
        
        spawn(function() 
            while p_autoblock:IsEnabled() do
                wait(0.02)
                for _,p in ipairs(serv_players:GetPlayers()) do
                    if p == plr then continue end
                    if p.TeamColor == plr.TeamColor then 
                        continue 
                    end 
                    
                    pcall(function()
                        local h = p.Character.HumanoidRootPart 
                        if (h.Position - humrp.Position).Magnitude < p_autoblockrange:GetValue() then
                            local hum = p.Character.Humanoid
                            
                            for _,track in ipairs(hum:GetPlayingAnimationTracks()) do
                                local id = track.Animation.AnimationId
                                if id:match("376938580") or id:match("470725369") or id:match("125750702") then
                                    if (gameball.PlayerWhoShot.Value ~= plr and gameball.Parent ~= plr.Character) then 
                                        print("[AUTO BLOCK] False positive, cancelling + delaying")
                                        wait(0.15)
                                        return
                                    end
                                    if p_autoblockfacecheck:IsEnabled() then
                                        local cross = humrp.CFrame.LookVector:Cross(h.CFrame.LookVector).Magnitude
                                        if cross > 0.5 then
                                            print("[AUTO BLOCK] Face check failed")
                                            return
                                        end
                                    end
                                    if statepointer.Value == "Free Throw" then
                                        print("[AUTO BLOCK] In free throws, cancelled jump")
                                        wait(0.15)
                                        return
                                    end
                                    --they're jumpshotting so jump after them
                                    wait(0.17)
                                    jump()
                                    wait(1)
                                    break
                                end
                            end
                        end
                    end)
                end
            end
        end)
    end)
    
    p_autoblock:ConnectFlag("Disabled",function() 
        serv_rs:UnbindFromRenderStep("JH3-AB")
        connections["AB1"]:Disconnect()
        
    end)
end
--better dunks
do 
    b_betterdunks:ConnectFlag("Enabled",function()
        
        if not plr.Character then
            b_betterdunks:Hide("Waiting for character spawn...")
            plr.CharacterAdded:Wait()
            b_betterdunks:Unhide()
            wait(0.35)
            
        end
        
        local hum = find(plr.Character, "Humanoid")
        local ev = serv_replicated.Ball.Dunk.End
        
        
        
        local function enable(h) 
            connections["bd2"] = h.AnimationPlayed:Connect(function(at) 
                if not at then
                    return
                end
                local id = at.Animation.AnimationId
                if id:match("470209556") or id:match("470698510") then
                    wait(0.3)
                    ev:FireServer()
                end
            end)
        
        
        end
        
        
        connections["bd1"] = plr.CharacterAdded:Connect(function(c) 
            hum = c:WaitForChild("Humanoid", 4)
            connections["bd2"]:Disconnect()
            enable(hum)
            
        end)        

        if hum then enable(hum) end
    end)

    b_betterdunks:ConnectFlag("Disabled",function() 
        if connections["bd2"] then
            connections["bd2"]:Disconnect()
        end
        if connections["bd1"] then
            connections["bd1"]:Disconnect()
        end
    
    end)
end
--face all
do 
    local force = serv_replicated.Player.Passing.ForceReceiverLook
    
    p_lookall:ConnectFlag("Clicked",function() 
        for _,p in ipairs(serv_players:GetPlayers()) do
            force:FireServer(p)
        end
    end)
end
-- jump boost
do
    local booster = Instance.new("BodyForce")
    booster.Force = vec3(0, p_jumpboostamt:GetValue(), 0)
    booster.Name = "艺簋蚉缉詢綄胹證"
    
    
    p_jumpboost:ConnectFlag("Enabled",function()
        if booster == nil then
            -- failsafe
            booster = Instance.new("BodyForce")
            booster.Force = vec3(0, p_jumpboostamt:GetValue(), 0)
            booster.Name = "艺簋蚉缉詢綄胹證" 
        end
        
        
        connections["BOOST1"] = plr.CharacterAdded:Connect(function(c) 
            booster.Parent = c:WaitForChild("HumanoidRootPart",5)
            hook(c)
        end)
        
        local function hook(c) 
            if connections["BOOST2"] then
                connections["BOOST2"]:Disconnect()
            end
            
            connections["BOOST2"] = c.ChildAdded:Connect(function(nc) 
                if nc.Name == "Basketball" then
                    
                    booster.Parent = nil
                    
                    local sc = true
                    
                    while sc do
                        local nc = c.ChildRemoved:Wait()
                        if nc.Name == "Basketball" then
                            wait(0.6)
                            booster.Parent = c.HumanoidRootPart 
                            
                            sc = false
                            break
                        end
                    end
                end
            end)
        end
        
        local c = plr.Character
        if c then
            hook(c)
            local b = find(c, "Basketball")
            if not b then
                booster.Parent = c.HumanoidRootPart
            end
        end
        
    end) 
    
    p_jumpboost:ConnectFlag("Disabled",function()
        
        booster.Parent = nil
        connections["BOOST1"]:Disconnect()
        connections["BOOST2"]:Disconnect()
    end)
    
    p_jumpboostamt:ConnectFlag("ValueChanged",function(v) 
        booster.Force = vec3(0, v, 0)
    end)
    
end
-- fix game
do 

    m_fixgame:ConnectFlag("Clicked",function() 
        local hum = find(plr.Character, "Humanoid")
        local humrp = find(plr.Character, "HumanoidRootPart")
        
        if hum and cam.CameraSubject ~= hum then
            cam.CameraSubject = hum
            warn("Fixed camera not being focused on player")
        end
        
        if humrp and humrp.Anchored == true then
            humrp.Anchored = false
            warn("Fixed character being stuck")
        end
            
        
        ui:SendNotification("Fix game","Successfully fixed any issues. Check console for more details",4)
    end)
    
end
-- nightmode
do 
    
    m_nightmode:ConnectFlag("Enabled",function() 
        local d = {}
        sethiddenproperty(game.Lighting, "Technology",Enum.Technology.Future)
        
        ins(d,find(workspace,"JH3-Nightmode"))
        ins(d,find(gameball,"Spotlight"))
        ins(d,find(serv_lighting,"JH3-Bloom"))
        
        for _,i in ipairs(d) do 
            i:Destroy() 
        end
        
        serv_lighting.Ambient = rgb(5, 5, 6)
        serv_lighting.Brightness = 0.1
        serv_lighting.GlobalShadows = true
        serv_lighting.TimeOfDay = 1
        
        local jhfolder = Instance.new("Folder")
        jhfolder.Name = "JH3-Nightmode"
        jhfolder.Parent = workspace
        
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 1.2
        bloom.Threshold = 0.8
        bloom.Size = 500
        bloom.Name = "JH3-Bloom"
        bloom.Parent = serv_lighting
        
        local shadow = Instance.new("Part")
        shadow.Position = vec3(0,300,0)
        shadow.Anchored = true
        shadow.Name = "shadow"
        shadow.CanCollide = false
        shadow.Transparency = 0
        shadow.Color = rgb(0, 0, 0)
        shadow.Size = vec3(3000, 500, 3000)
        shadow.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
        shadow.Parent = jhfolder
        
        local spot = Instance.new("Part")
        spot.Anchored = true
        spot.CanCollide = false
        spot.Name = "aimball"
        spot.Transparency = 1 
        spot.Size = vec3(1,1,1)
        spot.Position = vec3(0, 20, 0)
        spot.Parent = jhfolder
        
        local light = Instance.new("SpotLight")
        light.Color = rgb(255, 255, 253)
        light.Brightness = 1.7
        light.Range = 999
        light.Shadows = true
        light.Angle = 50
        light.Face = Enum.NormalId.Front
        light.Parent = spot
        
        for z = -3, 3 do 
            spawn(function()
                for x = -3, 3 do
                    local p1 = Instance.new("Part")
                    p1.Anchored = true
                    p1.Position = vec3(35 * x, 60, 35 * z)
                    p1.Name = "1"
                    p1.CanCollide = false
                    p1.Transparency = 0
                    p1.Color = rgb(2,2,8)
                    p1.Size = vec3(43, 4, 4)
                    p1.Rotation = vec3(z*6, 0, 90)
                    p1.TopSurface = Enum.SurfaceType.Smooth
                    p1.BottomSurface = Enum.SurfaceType.Smooth
                    p1.Shape = Enum.PartType.Cylinder
                    p1.Parent = jhfolder
                    
                    local p2 = p1:Clone()
                    p2.Name = "2"
                    p2.Material = Enum.Material.Neon
                    p2.Size = vec3(1, 3.5, 3.5)
                    p2.Anchored = false
                    p2.Shape = Enum.PartType.Cylinder
                    p2.Parent = p1
                    
                    local weld = Instance.new("Weld")
                    weld.Part0 = p1
                    weld.Part1 = p2
                    weld.C0 = cfn(-21.5,0,0)
                    weld.C1 = cfn(0,0,0)
                    weld.Parent = p2
                    
                    local light = Instance.new("SpotLight")
                    light.Color = rgb(255, 255, 245)
                    light.Brightness = 0.4
                    light.Range = 70
                    light.Shadows = true
                    light.Angle = 80
                    light.Face = Enum.NormalId.Left
                    light.Parent = p2
                    
                    p2.Color = light.Color
                    
                    local light = Instance.new("SpotLight")
                    light.Color = rgb(255, 255, 235)
                    light.Brightness = 0.3
                    light.Range = 55
                    light.Shadows = true
                    light.Angle = 85
                    light.Face = Enum.NormalId.Left
                    light.Parent = p2
                    
                    
                    wait(0.05)
                    p2.Anchored = true
                    
                    
                end
            end)
        end 
        
        spawn(function() 
            while m_nightmode:IsEnabled() do
                wait(0.1)
                twn(spot, 
                {CFrame = cfn(
                    vec3(0, 20, 0), 
                    gameball.Position+vec3(0,1,0)
                )}, 1)
                
            end
        end)
    end)
    
    
    m_nightmode:ConnectFlag("Disabled",function() 
        local d = {}
        ins(d, find(workspace,"JH3-Nightmode"))
        ins(d, find(gameball,"Spotlight"))
        ins(d, find(serv_lighting,"JH3-Bloom"))
        
        for _,i in ipairs(d) do 
            print(_,i)
            i:Destroy()
        end
        
        sethiddenproperty(game.Lighting, "Technology",Enum.Technology.Compatibility)
        
        serv_lighting.Brightness = 1
        serv_lighting.Ambient = Color3.fromRGB(127, 127, 127)
        serv_lighting.GlobalShadows = false
        serv_lighting.TimeOfDay = 14
    
    
    end)
end
-- custom stamina 
do 
    local stambarui
    m_cstamgui:ConnectFlag("Enabled",function() 
        local c1 = c3n(0, 0.9, 0.2)--c3n(0, 0.9, 0.1)
        local c2 = c3n(0.9, 0, 0.2)--c3n(0.9, 0, 0.1)

        local staminavalue = plr.PlayerScripts.Events.Player.Stamina.Stamina
        
        local function enable(h) 
            stambarui = Instance.new("BillboardGui")
            stambarui.AlwaysOnTop = true
            stambarui.Size = UDim2.fromScale(0, 0.6)
            stambarui.StudsOffsetWorldSpace = vec3(0, 1.25, 0)
            stambarui.Parent = h
            
            local bg = Instance.new("Frame")
            bg.BackgroundColor3 = c3n(0.13, 0.13, 0.15)
            bg.BorderColor3 = c3n(0.03, 0.03, 0.05)
            bg.Size = UDim2.new(1, 0, 1, 0)
            bg.BorderSizePixel = 0
            bg.ClipsDescendants = true
            bg.ZIndex = 2
            bg.Parent = stambarui
            
            local backframe = Instance.new("Frame")
            backframe.BackgroundColor3 = c3n(0.03, 0.03, 0.05)
            backframe.BorderColor3 = c3n(0.13, 0.13, 0.15)
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
            shadow.AnchorPoint = vec2(0.5, 0.5)
            shadow.Size = UDim2.new(1, 15, 1, 15)
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
            shade.BackgroundColor3 = c3n(0, 0, 0)
            shade.BackgroundTransparency = 0.9
            shade.ZIndex = 15
            shade.Parent = bg
            
            local stambar = Instance.new("Frame")
            stambar.AnchorPoint = vec2(1, 0)
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
            tlabel.TextColor3 = c3n(0, 0, 0)
            tlabel.BackgroundTransparency = 1
            tlabel.TextTransparency = 0.2
            tlabel.TextStrokeTransparency = 1
            tlabel.TextXAlignment = Enum.TextXAlignment.Right
            tlabel.Size = UDim2.new(1, 0, 1, 0)
            tlabel.Position = UDim2.new(0, 0, 0, 0)
            tlabel.TextScaled = true
            tlabel.AnchorPoint = vec2(0, 0)
            tlabel.Parent = stambar
            tlabel.ZIndex = 6
    
            twn(stambarui, {Size = UDim2.fromScale(4, 0.6)}, 0.3)
            
            connections["STAM1"] =  staminavalue.Changed:Connect(function(val) 
                local amnt = val / 1000
                
                stambar.Position = UDim2.new(amnt, 0, 0, 0)
                stambar.BackgroundColor3 = c2:Lerp(c1, amnt)
                
                local n = tostring(floor((amnt*100)+0.5))
    
                tlabel.Text = "<i>"..n.."%</i>" 
                
                if tlabel.Text:match("0") then
                    tlabel.TextTransparency = 0
                    twn(tlabel, {TextTransparency = 0.2}, 1) 
                    
                end
                
                local a,b = abs(floor(val) - 495), abs(floor(val) - 505)
                
                if a < 5 then
                    twn(tlabel, {Position = UDim2.new(0.3, 0, 0, 0), TextColor3 = c3n(1, 1, 1)}, 1)
                elseif b < 5 then
                    twn(tlabel, {Position = UDim2.new(0, 0, 0, 0), TextColor3 = c3n(0, 0, 0)}, 1)
                end
            end)
        end
        
        local h = find(plr.Character, "Head")
        if h then
            local bar1 = find(h, "StaminaBar")
            if bar1 then bar1.Enabled = false end
        
            enable(h)
        end
        
        connections["STAM2"] = plr.CharacterAdded:Connect(function(c) 
            wait(1)
            h = c:WaitForChild("Head", 5)
            connections["STAM1"]:Disconnect()
            
            wait(0.05)
            if h then
                local bar1 = h:WaitForChild("StaminaBar",2)
                bar1.Enabled = false
                
                enable(h)
            end
        end)
    end)

    m_cstamgui:ConnectFlag("Disabled",function() 
        stambarui:Destroy()
        pcall(function() 
            connections["STAM1"]:Disconnect()
            connections["STAM2"]:Disconnect()
        end)
        
        local bar1 = find(plr.Character.Head, "StaminaBar")
        
        if bar1 then 
            if p_infstam:IsEnabled() then return end
            bar1.Enabled = true 
        end
        
    end)

end
-- screenshare protection
do 
    m_hidegui:ConnectFlag("Enabled",function() 
        ui:SendNotification("Temporarily disabled","Disabled for now! Please wait for an update",3)
        --[[
        local screen = ui:GetScreenGUI()
        ui:NewMessagebox("Hide GUI","Chat \"/e enable\" to see the gui and \"/e disable\" to hide it",{
            {
                Text = "Ok, hide now",
                Callback = function(self) screen.Enabled = false self:Close() end
            },
            {
                Text = "Ok",
                Callback = function(self) self:Close() end
            }
            
        },70,-30)
        
        local chatbox = plr.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller
        
        connections["HIDE1"] = plr.Chatted:Connect(function(msg) 
            msg=msg:lower()
            if msg:match("/e enable") then
                screen.Enabled = true
                wait(0.02)
                for _,chatmsg in ipairs(chatbox:GetChildren()) do
                    if find(chatmsg, "TextLabel") then
                        if chatmsg.TextLabel.Text:match("can't use Emotes") then
                            chatmsg:Destroy()
                        end
                    end
                end
            elseif msg:match("/e disable") then
                screen.Enabled = false
                wait(0.02)
                for _,chatmsg in ipairs(chatbox:GetChildren()) do
                    if find(chatmsg, "TextLabel") then
                        if chatmsg.TextLabel.Text:match("can't use Emotes") then
                            chatmsg:Destroy()
                        end
                    end
                end
            end
        end)]]
    end)
    
    m_hidegui:ConnectFlag("Disabled",function() 
        if connections"HIDE1" then
            connections["HIDE1"]:Disconnect()
        end
    end)
    
    m_panic:ConnectFlag("Clicked",function() 
        ui:SendNotification("Temporarily disabled","Disabled for now! Please wait for an update",3)
        --for _,b in ipairs(ui:GetAllToggles()) do
        --    if b:GetText() ~= "Hide GUI" then 
        --        b:Disable()    
        --    end
        --end
    end)
    
end
-- deafen
do 
    m_deafen:ConnectFlag("Enabled",function() 
        connections["DE"] = workspace.ChildAdded:Connect(function(child) 
            if child.ClassName == "Sound" then
                child.Volume = 0
                wait(0.05)
                child:Destroy()
            end
        end)
    end)
    m_deafen:ConnectFlag("Disabled",function() 
        connections["DE"]:Disconnect()
    end)
end
-- tp to ball
do 
    p_tptoball:ConnectFlag("Enabled",function() 
        local tptoball
        local mode = p_tptoballmode:GetSelection()
        
        local humrp = find(plr.Character, "HumanoidRootPart")
        connections["TPB"] = plr.CharacterAdded:Connect(function(c) 
            humrp = c:WaitForChild("HumanoidRootPart",5)
        end)
        
        
        
        if mode == "Always" then
            tptoball = function()
                humrp.CFrame = gameball.CFrame
            end
            
        elseif mode == "When not holding" then
            tptoball = function() 
                if gameball.Parent ~= plr.Character then
                    humrp.CFrame = gameball.CFrame
                end
            end
            
        elseif mode == "When teams not holding" then
            tptoball = function()
                local h = find(gameball.Parent, "Head")
                if h then
                    local p = serv_players:GetPlayerFromCharacter(gameball.Parent)
                    if p.Team ~= plr.Team then
                        humrp.CFrame = gameball.CFrame
                    end
                else
                    humrp.CFrame = gameball.CFrame 
                end
            end
            
        elseif mode == "When other team holding" then
            tptoball = function()
                local h = find(gameball.Parent, "Head")
                if h then
                    local p = serv_players:GetPlayerFromCharacter(gameball.Parent)
                    if p.Team ~= plr.Team then
                        humrp.CFrame = gameball.CFrame
                    end
                end
            end
            
        else
            tptoball = function() end
            ui:SendNotification("Oopsies","Invalid TP to ball mode (this message shouldn't appear, DM topit)",6) 
        end
        
        
        serv_rs:BindToRenderStep("JH3-TPB",600,function() 
            pcall(tptoball)
        end)
    end)

    p_tptoball:ConnectFlag("Disabled",function() 
        serv_rs:UnbindFromRenderStep("JH3-TPB")
        connections["TPB"]:Disconnect()
        
    end)    
end
--highlight
do 
    local highlight
    b_highlight:ConnectFlag("Enabled",function() 
        
        
		highlight = Instance.new("SphereHandleAdornment")
		highlight.Name = "瞁礼窣聽縶符眱"
		highlight.Adornee = gameball
		highlight.AlwaysOnTop = true
		highlight.ZIndex = 10
		highlight.Radius = gameball.Size.X*0.5
		highlight.Transparency = 0.4
		highlight.Color3 = c3n(1,1,1)
		highlight.Parent = gameball
		
		local pick = random(1,3) do
		    if pick == 1 then
        		local cl = 0
        		serv_rs:BindToRenderStep("JH3-BH", 1888, function(dt)
        		    cl = (cl>10 and 0 or (cl + dt*2))
        		    
        		    highlight.Color3 = hsv(cl*0.1, 1, 1)
        		    
        		end)
		    elseif pick == 2 then
    	        highlight.Color3 = c3n(1,1,1)
    	    else
        		local cl = 0
        		serv_rs:BindToRenderStep("JH3-BH", 1888, function(dt)
        		    cl = sin(tick())*0.1
        		    highlight.Color3 = hsv(0.7+cl, 1, 1)
        		    
        		end)
            end
		end
    end)
    
    b_highlight:ConnectFlag("Disabled",function() 
        highlight:Destroy()
        
        serv_rs:UnbindFromRenderStep("JH3-BH")
        print("Disabled")
    end)
end
-- cam fix
do 
    m_camfix:ConnectFlag("Enabled",function() 
        
        if cam.CameraType == Enum.CameraType.Custom then
            pcall(function() 
                cam.CameraSubject = plr.Character.Humanoid
            end)
        end
        connections["CF1"] = cam:GetPropertyChangedSignal("CameraType"):Connect(function() 
            wait(0.02)
            pcall(function() 
                cam.CameraSubject = plr.Character.Humanoid
            end)
        end)
    end)
    
    m_camfix:ConnectFlag("Disabled",function() 
        if connections["CF1"] then connections["CF1"]:Disconnect() end
    end)
    
    m_camfix:Toggle()
end
-- ball cam
do 
    
    local campart = Instance.new("Part")
    campart.Name = "旨媟橬嫯椎柽枮幸"
    campart.Position = vec3(0,1,0)
    campart.Size = vec3(0,0,0)
    campart.Transparency = 1
    campart.CanCollide = false
    campart.CanTouch = false
    campart.Anchored = false
    campart.Parent = nil
    
    local floaty = Instance.new("BodyPosition")
    floaty.D = 150
    floaty.P = 1250
    floaty.MaxForce = vec3(9e4,9e4,9e4)
    floaty.Position = vec3(0,1,0)
    floaty.Parent = campart
    
    b_cam:ConnectFlag("Enabled",function() 
        campart.Parent = workspace
        cam.CameraSubject = campart
        
        local parent = gameball
        
        connections["BC1"] = gameball.AncestryChanged:Connect(function(self, selfparent) 
            if selfparent == workspace then
                parent = gameball
            elseif find(selfparent, "Head") then
                parent = selfparent["Head"]
            else
                parent = plr.Character.Head
            end
        end)
        
        serv_rs:BindToRenderStep("JH3-BC",1234,function()
            pcall(function()
                floaty.Position = parent.Position
                cam.CameraSubject = campart
            end)
        end)
    end)
    
    b_cam:ConnectFlag("Disabled",function() 
        serv_rs:UnbindFromRenderStep("JH3-BC")
        if connections["BC1"] then connections["BC1"]:Disconnect() end
        
        campart.Parent = nil
        cam.CameraSubject = (plr.Character and find(plr.Character, "Humanoid") or plr.Character)
    end)
    
end
-- autolayup
do 
    b_autolayup:ConnectFlag("Enabled",function() 
        
    end)
    
    b_autolayup:ConnectFlag("Disabled",function() 
        
    end)
    
    if false then
    function MODULECODE:AutoLayup()
    AutoLayup_LOOP = true
    local pos = rimpositions.GetOffensiveRim(plr) - Vector3.new(0, 8, 0)
    local e = Instance.new("Part")
    e.CanCollide = false
    e.Position = pos
    e.Transparency = 0.5 
    e.Anchored = true 
    e.Size = Vector3.new(1, 1, 1)
    e.Parent = game.Workspace
    
    JFR.Async(function()
        while AutoLayup_LOOP do
            
            if (plr.Character.HumanoidRootPart.Position - pos).Magnitude < 12 and pcall(function() return plr.Character["Basketball"] end) then 
                MODULECODE:Layup()
                wait(0.5)
            end
            wait(0.1)
        end
    end)
    e:Destroy()
end
end
end
-- antivoid
do 
    p_antivoid:ConnectFlag("Enabled",function() 
        while p_antivoid:IsEnabled() do 
            if plr_humrp.CFrame.Y < 0 then
                plr_humrp.CFrame = cfn(plr_humrp.CFrame.X, 3, plr_humrp.CFrame.Z)
            end
            wait(0.05)
        end
    end)
end
-- { Finish } --


ui:Ready()



ui:ConnectFlag("Exiting",function(toggles) 
    for i,v in ipairs(toggles) do
        if v:IsEnabled() then
            v:Toggle() 
        end
    end
    for i,v in pairs(connections) do
        print("Disconnected",i)
        pcall(function()
            v:Disconnect() 
        end)
    end
end)

b_aimbotm:SetSelection(1)
b_aimbotm:ConnectFlag("SelectionChanged",function(val,idx) 
    if val == "One press" then
        b_aimbot:Hide("Unfinished")
    else
        b_aimbot:Unhide()
    end
end)

-- bypass """""anticheat"""""
do
    local function BypassAnticheat(c) 
        wait(1.5)
        local move = c:WaitForChild("Movement",5)
        local script = (move and find(move, "Constrain")) or nil
        
        if not script then 
            warn("[ANTICHEAT BYPASS] Couldn't find script")
            return 
        end
        
        script.Disabled = true
        print("[ANTICHEAT BYPASS] Bypassed anticheat")
        if getscripthash then
            if getscripthash(script):sub(1,15) ~= "45a54c7a09b3775" then
                warn("[ANTICHEAT BYPASS] Looks like anticheat updated, let topit know")
            end
        else
            --[[
            ui:SendNotification("Script support","Your exploit may not support all features, check console for info")
            warn("[ANTICHEAT BYPASS] Missing function 'getscripthash', can't verify if the anticheat bypass will work")
            
            if getgc == nil then
                warn("[ANTICHEAT BYPASS] Missing function 'getgc', your exploit must be really shit")
            end
            if debug == nil then
                warn("[ANTICHEAT BYPASS] Missing library 'debug', your exploit must be really shit")
            end
            if getconnections == nil then
                warn("[ANTICHEAT BYPASS] Missing function 'getconnections', your exploit must be really shit")
            end
            
            
            warn("[ANTICHEAT BYPASS] For better script support, use an exploit such as Comet, KRNL, Fluxus, or Synapse")]]
        end
        --[[
        cresume(ccreate(function()
            local matches = {}
            for _,proto in ipairs(getgc()) do
                if islclosure(proto) then
                    pcall(function() 
                        local c1 = getconstant(proto, 1)
                        local c2 = getconstant(proto, 2)
                        local c7 = getconstant(proto, 7)
                        
                        
                        if c1 == "Velocity" then
                            if c2 == "X" then
                                if c7 == "Magnitude" then
                                    ins(matches, proto) 
                                end
                            end
                            wait(0.0001)
                        end
                        
                        
                    end) 
                end
            end
            
            
            for _,con in ipairs(getconnections(serv_rs.Heartbeat)) do
                for _,proto in ipairs(matches) do 
                    if con.Function == proto then
                        con:Disable()
                    end
                end
            end
            
            print("[ANTICHEAT BYPASS] Bypassed anticheat")
            matches = nil
        end))]]
        
    end
    
    
    
    connections["AC_BYP1"] = plr.CharacterAdded:Connect(BypassAnticheat) 
    if plr.Character then
        BypassAnticheat(plr.Character) 
    end
end
-- custom afk
do 
    
    local function handle() 
        -- get remotes and other stuff
        local clientafk1 = plr.PlayerScripts.Events.Player.IsAFK -- bindables that do clientside
        local clientafk2 = plr.PlayerScripts.Resetting.SetState -- afk handling
        
        local returning = serv_replicated.Player.AFK.IsReturning -- server remotes that 
        local away = serv_replicated.Player.AFK.IsAway -- actually make you afk
        
        local afktext1 = plr.PlayerGui.AFK.Manual -- the afk messages 
        local afktext2 = plr.PlayerGui.AFK.Automatic -- that might show up
        
        
        -- get where sidebuttons are located
        local afkbutton = plr.PlayerGui.Sidebar.Container
        
        
        for _,child in ipairs(afkbutton:GetChildren()) do
            if child.ClassName == "TextButton" then
                local t = find(child, "Top")
                
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
                    local t = find(child, "Top")
                    
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
            local a = find(afkbutton, "ButtonActive");
            local b = find(afkbutton, "Clicked");
            local c = find(afkbutton, "Arrow");
            
            (a and a.Destroy or warn)(a or "[CUSTOM AFK] Button missing ButtonActive boolvalue");
            (b and b.Destroy or warn)(b or "[CUSTOM AFK] Button missing Clicked bindable");
            (c and c.Destroy or warn)(c or "[CUSTOM AFK] Button missing Arrow");
        end
        
        -- handle mouse events, self explanatory
        do 
            local bcolor1 = rgb(255, 170, 0)
            local bcolor2 = rgb(229, 153, 0)
            local bcolor3 = rgb(191, 127, 0)
            
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
                    wait(0.04)
                    workspace.CurrentCamera.CameraSubject = find(plr.Character, "Humanoid")
                end
            end)
            
            afkbutton.Top.BackgroundColor3 = bcolor1
            afkbutton.Bottom.BackgroundColor3 = bcolor2
            
        end
        
        -- animate the older button out and delete it
        spawn(function()
            local t = twn(old,{Position = UDim2.new(-2, 0, 2, 20)}, 0.5)
            t.Completed:Wait()
            old:Destroy()
        end)
        -- disable the normal afk script
        pcall(function() 
            plr.PlayerScripts.GameControl["AFK - Client"].Disabled = true
        end)
        -- animate the newer button in after a short delay
        delay(0.7, function() twn(afkbutton, {Position = UDim2.new(0, 0, 2, 20)}, 0.3) end)
        
        
        
        -- override afk message
        afktext1.Visible = true
        afktext2.Visible = false
        afktext1.Text = "Welcome, "..plr.DisplayName..".\nJeff Hoops custom AFK loaded."
        
        delay(4, function()
            afktext1.Visible = false
        end)
    end
    
    -- finish
    handle()
end
-- intro
do 
    --[[
    local screen = ui:GetScreenGUI()
    local text = Instance.new("TextLabel")
    text.Font = Enum.Font.Nunito
    text.BackgroundTransparency = 1
    text.Size = UDim2.fromScale(0.5,0.3)
    text.Text = "Jeff Hoops"
    text.TextColor3 = c3n(1,1,1)
    text.TextStrokeColor3 = c3n(0,0,0)
    text.TextStrokeTransparency = 0
    text.TextScaled = true
    text.Position = UDim2.fromScale(-0.1,0.2)
    text.Parent = screen
    twn(text, {Position = UDim2.fromScale(0.1,0.2)},0.3)
    wait(1)
    text:Destroy()]]
end
-- ping check
do 
    ui:SendNotification("Notice","This is using a beta version of a new UI library that is incomplete and may not be stable",5)
    delay(3, function()
        if floor(ping:GetValue()) > 100 then
            ui:SendNotification("High ping","Your client has high ping ("..floor(ping:GetValue()).."), so some features may not work as expected",4)
        end
    end)
end


