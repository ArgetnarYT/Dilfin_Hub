    -- varbs
    local plr = game:GetService("Players").LocalPlayer
    local wrk = game:GetService("Workspace")
    local vu = game:GetService("VirtualUser")
    -- anti afk
    plr.Idled:connect(function()
        vu:Button2Down(Vector2.new(0, 0), wrk.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), wrk.CurrentCamera.CFrame)
    end)


--libs
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
--Window
local Window = Rayfield:CreateWindow({
	Name = "Dilfin Hub",
	LoadingTitle = "Dilfin Hub",
	LoadingSubtitle = "Thanks for using script!",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = "Dilfin Hub", -- Create a custom folder for your hub/game
		FileName = "cfg"
	},
        Discord = {
        	Enabled = true,
        	Invite = "9WGczwFcZx", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = true, -- Set this to true to use our key system
	KeySettings = {
		Title = "Dilfin Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/9WGczwFcZx)",
		FileName = "Dilfin Hub Key",
		SaveKey = true,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "6J6tDgtE5QYS6opK6CS9rwLfEMQpwvJR"
	}
})
--func

mouse=game.Players.LocalPlayer:GetMouse()
camera=game.Workspace.CurrentCamera
UserInputService=game:GetService('UserInputService')
VirtualInputManager=game:GetService('VirtualInputManager')
RunService=game:GetService('RunService')
player=game.Players.LocalPlayer

walkspeed_value=game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
jumppower_value=game.Players.LocalPlayer.Character.Humanoid.JumpPower
gravity_value=game.Workspace.Gravity
infinite_jump=false
esp=false
autoez=false
loop_teleport=false
ctrl_tp=false
ambient=game.Lighting.Ambient
outdoor_ambient=game.Lighting.OutdoorAmbient
fogstart=game.Lighting.FogStart
brightness=game.Lighting.Brightness
clocktime=game.Lighting.ClockTime
shadows=game.Lighting.GlobalShadows
tab_image=590553552
----

function checkmark(text, duration)
	Rayfield:Notify({
		Title='Dilfin Hub',
		Content=text,
		Duration=duration,
		Image=4914902889
	})
end
-- SPEED WALK, JUMP POWER, INFINITE JUMP
mouse.KeyDown:connect(function(i)
	key=i:byte()
	for i,v in {119, 97, 115, 100} do --WASD
		if v==key then
			player.Character.Humanoid.WalkSpeed=walkspeed_value
			return
		end
	end
	if key==32 then --Spacebar
		player.Character.Humanoid.JumpPower=jumppower_value
		game.Workspace.Gravity=gravity_value
		if infinite_jump then
			player.Character.Humanoid:ChangeState('Jumping')
			wait(0.1)
			player.Character.Humanoid:ChangeState('Seated')
		end
	end
end)
-- CTRL TP
UserInputService.InputBegan:Connect(function(i, _)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		if ctrl_tp and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z))
		end
	end
end)




--Tab
local universal = Window:CreateTab("Universal", 3075924681) -- Title, Image
--Ui
universal:CreateSection('Player')
universal:CreateSlider({
	Name='Walk Speed',
	Range={0, 100},
	Increment=1,
	Suffix='Speed',
	CurrentValue=16,
	Flag='universal_walk_speed',
	Callback=function(i)
		walkspeed_value=i
	end,
})
universal:CreateSlider({
	Name='Jump Power',
	Range={0, 300},
	Increment=1,
	Suffix='Power',
	CurrentValue=50,
	Flag='universal_jump_power',
	Callback=function(i)
		jumppower_value=i
	end,
})
universal:CreateSlider({
	Name='Gravity',
	Range={0, 300},
	Increment=1,
	Suffix='',
	CurrentValue=196,
	Flag='universal_gravity',
	Callback=function(i)
		gravity_value=i
	end,
})
universal:CreateToggle({
	Name='Noclip',
	CurrentValue=false,
	Flag='universal_noclip',
	Callback=function(state)
		if state then
			noclip=RunService.Stepped:Connect(function()
				for i,v in pairs(player.Character:GetDescendants()) do
					if v:IsA('BasePart') and v.CanCollide then
						v.CanCollide=false
					end
				end
				wait()
			end)
		else
			noclip:Disconnect()
		end
	end,
})
universal:CreateToggle({
	Name='Infinite Jump',
	CurrentValue=false,
	Flag='universal_infinite_jump',
	Callback=function(state)
		infinite_jump=state
	end,
})
universal:CreateSection('Teleport')
universal:CreateToggle({
	Name='Loop Teleport',
	CurrentValue=false,
	Flag='universal_loop_teleport',
	Callback=function(state)
		loop_teleport=state
	end,
})
universal:CreateInput({
	Name='Teleport to',
	PlaceholderText='Player',
	RemoveTextAfterFocusLost=false,
	Callback=function(i)
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Name:lower():sub(1, #i)==i:lower() or v.DisplayName:lower():sub(1, #i)==i:lower() then
				while true do
					player.Character.HumanoidRootPart.CFrame=v.Character.HumanoidRootPart.CFrame
					if not loop_teleport then
						break
					end
					wait()
				end
			end
		end
	end,
})
universal:CreateToggle({
	Name='Сtrl+Click Teleport',
	CurrentValue=false,
	Flag='universal_ctrl_tp',
	Callback=function(state)
		ctrl_tp=state
	end,
})
universal:CreateSection('Visual')
universal:CreateToggle({
	Name='Full Brightness',
	CurrentValue=false,
	Flag='universal_full_brightness',
	Callback=function(state)
		if state then
			game.Lighting.Brightness=2
			game.Lighting.ClockTime=14
			game.Lighting.GlobalShadows=false
			game.Lighting.OutdoorAmbient=Color3.fromRGB(128, 128, 128)
		else
			game.Lighting.Brightness=brightness
			game.Lighting.ClockTime=clocktime
			game.Lighting.GlobalShadows=shadows
			game.Lighting.OutdoorAmbient=outdoor_ambient
		end
	end,
})
universal:CreateSection('Server')
universal:CreateButton({
	Name='Rejoin',
	Callback=function()
		game:GetService('TeleportService'):Teleport(game.PlaceId, game.Players.LocalPlayer)
	end,
})
