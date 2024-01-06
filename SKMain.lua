--[[----------------------------------------------------------------------------------------|
#  > File Name: SKMain.lua
#  > Last Edit: 2023-12-30 14:58
--]]
-------------------------------------------------------------------------------------------|

--\\ Loading Handler //--

_G.SK = {}
_G.SK.Loaded = false
if _G.SK.Loaded == true then
	return
elseif _G.SK.Loaded == false then
	if not game:IsLoaded() then
		warn("Skywarp is waiting for the game to load.")
		game.Loaded:Wait()
		warn("Skywarp initiated.")
	end
end

--\\ Static Configuration //--
sk = _G.SK
sk.Ver = "1.4 Netflix CE"
sk.Commands = {}
sk.Binds = {}
sk.Components = {}
sk.LiveSettings = {}
sk.Cosemetics = {}
sk.Bases = {}
sk.Waypoints = {}
sk.CommandHistory = {}
sk.GameOverride = { 292439477 }
sk.GalaticCenter = CFrame.new(0, 2147483647, 0)

--\\ Dynamic Configuration //--
sk.Settings = {
	["CurrentBase"] = nil,
	["ClickTPIncrementR6"] = Vector3.new(0, 3.5, 0),
	["ClickTPIncrementR15"] = Vector3.new(0, 3.75, 0),
	["AntiAFK"] = true,
	["AllowTabCheck"] = true,
	["ChatPrefix"] = "$",
	["FlySpeed"] = 1,
	["VehicleFlySpeed"] = 1,
	["HighlightColor"] = Color3.fromRGB(255, 255, 255),
	["AutoWalkSpeedValue"] = 16,
	["AutoJumpPowerValue"] = 50,
	["R6ProflyIncrement"] = Vector3.new(0, 3.5, 0),
	["R15ProflyIncrement"] = Vector3.new(0, 3.35, 0),
	["ProflyColor"] = BrickColor.new("Really red"),
	["ProflyMaterial"] = Enum.Material.ForceField,
	["ProflySize"] = Vector3.new(5, 1, 5),
	["SpeedupValue"] = 150,
	["ChangeMaxCameraZoom"] = true
}

sk.BindSettings = {
	["FocusBind"] = Enum.KeyCode.RightAlt,
	["ClickTP"] = Enum.KeyCode.V,
	["UndoClickTP"] = Enum.KeyCode.Z,
	["RedoClickTP"] = Enum.KeyCode.X,
	["Fly"] = Enum.KeyCode.F1,
	["Noclip"] = Enum.KeyCode.F2,
	["DestroyPart"] = Enum.KeyCode.F3,
	["Profly"] = Enum.KeyCode.LeftControl,
	["Speedup"] = Enum.KeyCode.LeftAlt,
	["BreakVelocity"] = Enum.KeyCode.T,
	["Transport"] = Enum.KeyCode.Y,
}

sk.CosemeticSettings = {
	GloveCosemetic = {
		["BrickColor"] = BrickColor.new("Really black"),
		["Material"] = Enum.Material.Neon,
	},
}

sk.Temp = {
	["Pos1"] = nil,
	["Pos2"] = nil,
	["Pos3"] = nil,
	["DeathCount"] = 0,
	["OldBasePos"] = nil,
	["Spawn"] = nil,
	["ogBright"] = nil,
	["ogTime"] = nil,
	["ogFog"] = nil,
	["ogShadow"] = nil,
	["ogAmbient"] = nil,
	["ogAntiFall"] = nil,
	["ogAWS"] = nil,
	["NoclipHeartbeat"] = nil,
	["cWeldPart"] = nil,
	["cWeld"] = nil,
	["ogCFrame"] = nil,
	["ogWeld"] = nil,
	["TabbedOut"] = false,
	["TransportPlayerPos"] = nil,
	["oGUltraInstinctPos"] = nil,
	["TransportSpeed"] = 2,
  ["Flying"] = false,
  ["QEFly"] = true,
}

--\\ Services //--
local PathService       = game:GetService("PathfindingService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local DebrisService     = game:GetService("Debris")
local TweenService      = game:GetService("TweenService")
local VirutalUser       = game:GetService("VirtualUser")
local TeleportService   = game:GetService("TeleportService")

local PlayerService     = game:GetService("Players")
local LightingService   = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui        = game:GetService("StarterGui")
local PlayerGui         = PlayerService.LocalPlayer.PlayerGui

--\\ Secure GUI //--
local OverlaySK         = Instance.new("ScreenGui")
OverlaySK.Parent        = PlayerGui
OverlaySK.Name          = "!SKYWARP!"
OverlaySK.ResetOnSpawn  = false
OverlaySK.Enabled       = true
sk.OverlayUI            = OverlaySK

--\\ Part Storage //--
local PartStorage       = Instance.new("Folder")
PartStorage.Parent      = workspace
PartStorage.Name        = "!SKYWARP!"
sk.PartStorage          = PartStorage

--\\ CoreGUI Storage //--
local Storage           = Instance.new("Folder")
Storage.Parent          = sk.OverlayUI
Storage.Name            = "!SKYWARP!"
sk.Storage              = Storage

--\\ Resource Storage //--
local RStorage          = Instance.new("Folder")
RStorage.Parent         = sk.Storage
RStorage.Name           = "!SKRESOURCES!"
sk.RStorage             = RStorage

_G.SK.Loaded            = true
local SKCMD             = Instance.new("ScreenGui")
SKCMD.ResetOnSpawn      = false

--\\ Player Variables //--
local Player            = PlayerService.LocalPlayer
local MouseId           = Player:GetMouse().Icon
sk.PlayerRig            = nil;

--\\ Functions //--
function sk:Log(source, text)
	if source == nil then
		print("[Skywarp] " .. "> " .. text)
	else
		print("[Skywarp]:" .. "[" .. source .. "] " .. "> " .. text)
	end
end

function sk:RandomGenerate(length)
	local Alphabet = {
		[1] = "a",
		[2] = "b",
		[3] = "c",
		[4] = "d",
		[5] = "e",
		[6] = "f",
		[7] = "g",
		[8] = "h",
		[9] = "i",
		[10] = "j",
		[11] = "k",
		[12] = "l",
		[13] = "m",
		[14] = "n",
		[15] = "o",
		[16] = "p",
		[17] = "q",
		[18] = "r",
		[19] = "s",
		[20] = "t",
		[21] = "u",
		[22] = "v",
		[23] = "w",
		[24] = "x",
		[25] = "y",
		[26] = "z",
		[27] = "1",
		[28] = "2",
		[29] = "3",
		[30] = "4",
		[31] = "0",
		[32] = "5",
		[33] = "6",
		[34] = "7",
		[35] = "8",
		[36] = "9",
	}

	local count = 0
	local len = length
	local string1 = ""

	task.spawn(function()
		repeat
			count = count + 1
			string1 = string1 .. Alphabet[math.random(1, 36)]
		until count == len
	end)
	return string1
end

function sk:GetPlayer(args, tbl)
	if tbl == nil then
		--> Thanks CMD-X!
		tbl = PlayerService:GetPlayers()
		local cmdlp = Player
		if args == "me" then
			return cmdlp
		elseif args == "random" then
			return tbl[math.random(1, #tbl)]
		elseif args == "new" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v.AccountAge < 30 and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "old" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v.AccountAge > 30 and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "bacon" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair") and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "friend" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "notfriend" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "ally" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v.Team == cmdlp.Team and v ~= cmdlp then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "enemy" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v.Team ~= cmdlp.Team then
					vAges[#vAges + 1] = v
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "near" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v ~= cmdlp then
					local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position)
						.magnitude
					if math < 30 then
						vAges[#vAges + 1] = v
					end
				end
			end
			return vAges[math.random(1, #vAges)]
		elseif args == "far" then
			local vAges = {}
			for _, v in pairs(tbl) do
				if v ~= cmdlp then
					local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position)
						.magnitude
					if math > 30 then
						vAges[#vAges + 1] = v
					end
				end
			end
			return vAges[math.random(1, #vAges)]
		else
			for _, v in pairs(tbl) do
				if v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower()) then
					return v
				end
			end
		end
	else
		for _, plr in pairs(tbl) do
			if plr.UserName:lower():find(args:lower()) or plr.DisplayName:lower():find(args:lower()) then
				return plr
			end
		end
	end
end

function sk:ChatLog(text, color, font, fontsize)
	StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = text,
		Color = color,
		Font = font,
		FontSize = fontsize
	})
end

function sk:GetMousePosition()
	return Vector2.new(Player:GetMouse().X, Player:GetMouse().Y)
end

function sk:AddBind(name, desc, alias, uisenum, toggled, beginFunc, exitFunc)
	table.insert(sk.Binds, {
		NAME = name,
		DESC = desc,
		ALIAS = alias,
		STATUS = toggled,
		ENUM = uisenum,
	})
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		else
			if input.KeyCode == uisenum then
				for _i, v in pairs(sk.Binds) do
					if v.NAME == name or v.ALIAS == name then
						if v.STATUS == true then
							coroutine.resume(coroutine.create(function()
								beginFunc()
								if v.STATUS == false then
									coroutine.yield()
								end
							end))
						end
					end
				end
			end
		end
	end)
end

function sk:AddHoldableBind(name, desc, alias, uisenum, toggled, beginFunc, exitFunc)
	table.insert(sk.Binds, {
		NAME = name,
		DESC = desc,
		ALIAS = alias,
		STATUS = toggled,
		ENUM = uisenum,
		ACTIVATED = false,
	})
	UserInputService.InputBegan:Connect(function(input,processed)
		if processed then return else
			if input.KeyCode == uisenum then
				for _i,v in pairs(sk.Binds) do
					if v.NAME == name or v.ALIAS == name then
						if v.STATUS == true and v.ACTIVATED == false then
							v.ACTIVATED = true
							coroutine.resume(coroutine.create(function()
								beginFunc()
							end))
						end
					end
				end
			end
		end
	end)
	UserInputService.InputEnded:Connect(function(input,processed)
		if processed then return else
			if input.KeyCode == uisenum then
				for _i,v in pairs(sk.Binds) do
					if v.NAME == name or v.ALIAS == name then
						if v.STATUS == true and v.ACTIVATED == true then
							v.ACTIVATED = false
							coroutine.resume(coroutine.create(function()
								exitFunc()
							end))
						end
					end
				end
			end
		end
	end)
end

function sk:SetBindToggle(name, toggled)
	for _i, v in pairs(sk.Binds) do
		if v.NAME == name then
			v.STATUS = toggled
		end
	end
end

function sk:GetBind(name)
	for _i, v in pairs(sk.Binds) do
		if v.NAME == name then
			return (v)
		end
	end
end

function sk:GetCommand(name)
	for _i, v in pairs(sk.Commands) do
		if v.NAME == name or v.ALIAS == name then
			return (v)
		end
	end
end

function sk:AddComponent(name, desc, alias, toggled)
	table.insert(sk.Components, {
		NAME = name,
		DESC = desc,
		ALIAS = alias,
		STATUS = toggled,
	})
end

function sk:SetComponentToggle(name, toggled)
	for _i, v in pairs(sk.Components) do
		if v.NAME == name or v.ALIAS == name then
			v.STATUS = toggled
		end
	end
end

function sk:GetComponent(name)
	for _i, v in pairs(sk.Components) do
		if v.NAME == name or v.ALIAS == name then
			return (v)
		end
	end
end

function sk:AddBase(name, model, teleport, toggled)
	table.insert(sk.Bases, {
		NAME = name,
		MODEL = model,
		TP = teleport,
		TOGGLED = toggled
	})
end

function sk:CreateCommand(name, desc, alias, func, setString)
	local x = func;
	local y = desc;
	local c = alias;
	local d = name;
	local e = setString;

	table.insert(sk.Commands, {
		NAME = d,
		ALIAS = c,
		FUNC = x,
		DESC = y,
		STR = e,
		TOGGLED = false,
	})
end

function sk:ExecuteCommand(name, arg)
	for _i, v in pairs(sk.Commands) do
		if name ~= nil and name == v.NAME or name == v.ALIAS then
			local a = v;
			coroutine.resume(coroutine.create(function()
				a.FUNC(arg)
				coroutine.yield()
			end))
		end
	end
end

function sk:CommandInputable(sent, area)
	local inp = sent;
	local instance = area;
	inp = string.lower(sent)

	if inp ~= "" or " " then
		local arguments = {}
		instance.Text = ""

		for argu in string.gmatch(inp, "[^%s]+") do
			table.insert(arguments, argu)
		end

		for _i, v in pairs(sk.Commands) do
			if arguments[1] == v.NAME or arguments[1] == v.ALIAS then
				if v.STR == nil or v.STR == false then
					coroutine.resume(coroutine.create(function()
						v.FUNC(arguments[2], arguments[3], arguments[4], arguments[5])
						coroutine.yield()
						table.insert(sk.CommandHistory, v)
					end))
				elseif v.STR == true then
					local str

					if arguments[1] == v.Command then
						str = string.len(v.Command) + 2
					elseif arguments[1] == v.ALIAS then
						str = string.len(v.ALIAS) + 2
					end

					local newStr = string.sub(inp, str, 1000)
					coroutine.resume(coroutine.create(function()
						v.FUNC(newStr, arguments[2], arguments[3], arguments[4], arguments[5])
						coroutine.yield()
					end))
				end
			end
		end
	end
end

function sk:AddLiveSetting(settingName, desc, toggled)
	table.insert(sk.LiveSettings, {
		NAME = settingName,
		DESC = desc,
		STATUS = toggled,
	})
end

function sk:GetLSetting(settingName)
	for _i, v in pairs(sk.LiveSettings) do
		if v.NAME == settingName then
			return v
		end
	end
end

function sk:AddCosemetic(name, desc, toggled, rig, funct)
	table.insert(sk.Cosemetics, {
		NAME = name,
		DESC = desc,
		STATUS = toggled,
		RIG = rig,
		FUNC = funct
	})
	pcall(function()
		funct()
	end)
end

function sk:GetCosemetic(name)
	for _i, v in pairs(sk.Cosemetics) do
		if v.NAME == name then
			return v
		end
	end
end

function sk:Time()
	local HOUR = math.floor((tick() % 86400) / 3600)
	local MINUTE = math.floor((tick() % 3600) / 60)
	local SECOND = math.floor(tick() % 60)
	local AP = HOUR > 11 and 'PM' or 'AM'
	HOUR = (HOUR % 12 == 0 and 12 or HOUR % 12)
	HOUR = HOUR < 10 and '0' .. HOUR or HOUR
	MINUTE = MINUTE < 10 and '0' .. MINUTE or MINUTE
	SECOND = SECOND < 10 and '0' .. SECOND or SECOND
	return HOUR .. ':' .. MINUTE .. ':' .. SECOND .. ' ' .. AP
end

function sk:GetPlayers()
	task.wait(1)
	return #PlayerService:GetPlayers()
end

--\\ Setting handlers //--
--\\ Live Settings //--
sk:AddLiveSetting("synctp", "Stops server tweening when you click tp, is experimental", true)
sk:AddLiveSetting("syncgoto", "Stops server tweening when you use goto command (is experimental)", true)

--\\ Component Registers //--
sk:AddComponent("antifall", "Prevents the player from ragdolling & tripping.", "atf", true)
sk:AddComponent("highlightselection", "Highlights the part your cursor is over.", "hls", false)
sk:AddComponent("autowalkspeed", "Constantly sets the player's walkspeed", "aws", false)
sk:AddComponent("autojumppower", "Constantly sets the player's jumppower", "ajp", false)
sk:AddComponent("cursoricon", "Changes the player's cursor.", "cid", false)
sk:AddComponent("anticorpse", "Teleports you as you die to hide your corpse", "aco", true)

--\\ Get Player Rig //--
if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
	sk.PlayerRig = "R6"
	sk:Log("PlayerRig", "Player is R6")
elseif Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
	sk.PlayerRig = "R15"
	sk:Log("PlayerRig", "Player is R15")
end

--\\ UI //--
Player.PlayerGui:SetTopbarTransparency(1)
local topBar = Instance.new("ScreenGui")
local frame = Instance.new("Frame");
local text = Instance.new("TextLabel")
topBar.IgnoreGuiInset = true
frame.Size = UDim2.new(1, 0, 0, 38)
frame.BackgroundTransparency = 0.6
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
text.Font = Enum.Font.Code
text.TextSize = 18
text.TextWrapped = false
text.TextScaled = false
text.Size = UDim2.new(1, 0, 0, 38)
text.TextColor = BrickColor.new("Institutional white")
text.TextTransparency = 1
text.BackgroundTransparency = 1

text.Parent = frame
frame.Parent = topBar
topBar.Parent = SKCMD

local SKInfo = Instance.new("ScreenGui")
local PlayerCount = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local RainbowMe = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UICorner = Instance.new("UICorner")
local PingCount = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local ImageLabel_2 = Instance.new("ImageLabel")
local RainbowMe_2 = Instance.new("Frame")
local UIGradient_2 = Instance.new("UIGradient")
local UICorner_2 = Instance.new("UICorner")

SKInfo.Name = "!SKInfo"
SKInfo.Parent = SKCMD
SKInfo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

PlayerCount.Name = "PlayerCount"
PlayerCount.Parent = SKInfo
PlayerCount.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
PlayerCount.BorderSizePixel = 0
PlayerCount.ClipsDescendants = true
PlayerCount.Position = UDim2.new(0.00666364795, 0, 0.753209898, 0)
PlayerCount.Size = UDim2.new(0, 111, 0, 31)

TextLabel.Parent = PlayerCount
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.380407929, 0, 0.0967741907, 0)
TextLabel.Size = UDim2.new(0, 61, 0, 25)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14.000
TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left

ImageLabel.Parent = PlayerCount
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.108108118, 0, 0.0967741907, 0)
ImageLabel.Size = UDim2.new(0.225225225, 0, 0.806451619, 0)
ImageLabel.Image = "rbxassetid://11295273292"

RainbowMe.Name = "RainbowMe"
RainbowMe.Parent = PlayerCount
RainbowMe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RainbowMe.Position = UDim2.new(-0.0816446915, 0, 0, 0)
RainbowMe.Size = UDim2.new(0, 15, 0, 31)

UIGradient.Color = ColorSequence.new { ColorSequenceKeypoint.new(0.00, Color3.fromRGB(53, 2, 255)), ColorSequenceKeypoint.new(0.06, Color3.fromRGB(255, 140, 0)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 247, 1)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(18, 255, 2)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 179, 255)), ColorSequenceKeypoint.new(0.87, Color3.fromRGB(213, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(61, 61, 255)) }
UIGradient.Parent = RainbowMe

UICorner.CornerRadius = UDim.new(0.100000001, 0)
UICorner.Parent = PlayerCount

PingCount.Name = "PingCount"
PingCount.Parent = SKInfo
PingCount.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
PingCount.BorderSizePixel = 0
PingCount.ClipsDescendants = true
PingCount.Position = UDim2.new(0.00666364795, 0, 0.788888931, 0)
PingCount.Size = UDim2.new(0, 111, 0, 31)

TextLabel_2.Parent = PingCount
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0.380407929, 0, 0.0967741907, 0)
TextLabel_2.Size = UDim2.new(0, 61, 0, 25)
TextLabel_2.Font = Enum.Font.SourceSansBold
TextLabel_2.Text = "NILms"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 14.000
TextLabel_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextWrapped = true
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
local PingCountText = TextLabel_2

ImageLabel_2.Parent = PingCount
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.BorderSizePixel = 0
ImageLabel_2.Position = UDim2.new(0.108108118, 0, 0.0967741907, 0)
ImageLabel_2.Size = UDim2.new(0.225225225, 0, 0.806451619, 0)
ImageLabel_2.Image = "rbxassetid://11326879610"

RainbowMe_2.Name = "RainbowMe"
RainbowMe_2.Parent = PingCount
RainbowMe_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RainbowMe_2.Position = UDim2.new(-0.0816446915, 0, 0, 0)
RainbowMe_2.Size = UDim2.new(0, 15, 0, 31)

UIGradient_2.Color = ColorSequence.new { ColorSequenceKeypoint.new(0.00, Color3.fromRGB(53, 2, 255)), ColorSequenceKeypoint.new(0.06, Color3.fromRGB(255, 140, 0)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 247, 1)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(18, 255, 2)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(0, 179, 255)), ColorSequenceKeypoint.new(0.87, Color3.fromRGB(213, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(61, 61, 255)) }
UIGradient_2.Parent = RainbowMe_2

UICorner_2.CornerRadius = UDim.new(0.100000001, 0)
UICorner_2.Parent = PingCount

--\\ Ping Handler //--
--local PerformanceStats = CoreGUI.RobloxGui:FindFirstChild("PerformanceStats", true)
--local PingValue
--if PerformanceStats then
--for _i,v in pairs(PerformanceStats:GetDescendants()) do
--if v.Position == UDim2.new({0, 10}, {0.550000012, 0}) then
--PingValue = v.ValueLabel
--end
--end
--end

task.spawn(function()
	local tweenService = game:GetService("TweenService")
	local grad1 = UIGradient
	local grad2 = UIGradient_2

	while task.wait() do
		TextLabel.Text = tostring(sk:GetPlayers())
		PingCountText.Text = Player:GetNetworkPing() * 1000 * 2.5
		local tween = tweenService:Create(grad1, TweenInfo.new(2, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) })
		tween:Play()
		tween = tweenService:Create(grad2, TweenInfo.new(2, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) })
		tween:Play()
		task.wait(2)
		grad1.Offset = Vector2.new(1, 0)
		grad2.Offset = Vector2.new(1, 0)
		local tween2 = tweenService:Create(grad1, TweenInfo.new(2, Enum.EasingStyle.Linear), { Offset = Vector2.new(0, 0) })
		tween2:Play()
		tween2 = tweenService:Create(grad2, TweenInfo.new(2, Enum.EasingStyle.Linear), { Offset = Vector2.new(0, 0) })
		tween2:Play()
		task.wait(2)
	end
end)

local MainFrame = Instance.new("Frame")
local CMDBar = Instance.new("TextBox")
local aUIGradient = Instance.new("UIGradient")
local Frame = Instance.new("Frame")
local Decor = Instance.new("TextLabel")

SKCMD.Name = "!SKCMD"
SKCMD.Parent = sk.Storage
SKCMD.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SKCMD.Enabled = false

MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Parent = SKCMD
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.BorderColor3 = Color3.fromRGB(85, 79, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Size = UDim2.new(0, 270, 0, 35)
MainFrame.ZIndex = 999999999

CMDBar.Name = "CMDBar"
CMDBar.Parent = MainFrame
CMDBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
CMDBar.BackgroundTransparency = 0.200
CMDBar.BorderSizePixel = 0
CMDBar.Position = UDim2.new(0.125925928, 0, 0, 0)
CMDBar.Size = UDim2.new(0, 235, 0, 35)
CMDBar.ZIndex = 5
CMDBar.Font = Enum.Font.SourceSansBold
CMDBar.Text = ""
CMDBar.TextColor3 = Color3.fromRGB(255, 255, 255)
CMDBar.TextSize = 14.000
CMDBar.TextXAlignment = Enum.TextXAlignment.Left

aUIGradient.Color = ColorSequence.new { ColorSequenceKeypoint.new(0.00, Color3.fromRGB(53, 2, 255)), ColorSequenceKeypoint.new(0.18, Color3.fromRGB(255, 140, 0)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 247, 1)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(18, 255, 2)), ColorSequenceKeypoint.new(0.71, Color3.fromRGB(0, 179, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(213, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(61, 61, 255)) }
aUIGradient.Parent = MainFrame

Frame.Parent = MainFrame
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame.Size = UDim2.new(0, 270, 0, 35)

Decor.Name = "Decor"
Decor.Parent = MainFrame
Decor.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Decor.BackgroundTransparency = 1.000
Decor.BorderColor3 = Color3.fromRGB(27, 42, 53)
Decor.BorderSizePixel = 0
Decor.Position = UDim2.new(-0.00370370364, 0, 0, 0)
Decor.Size = UDim2.new(0, 35, 0, 35)
Decor.Font = Enum.Font.DenkOne
Decor.Text = ">"
Decor.TextColor3 = Color3.fromRGB(255, 255, 255)
Decor.TextSize = 32.000
Decor.TextWrapped = true

local Text = CMDBar
local UI = SKCMD

task.spawn(function()
	while task.wait() do
		local tween = TweenService:Create(aUIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear),
			{ Offset = Vector2.new(-1, 0) })
		tween:Play()
		task.wait(1)
		aUIGradient.Offset = Vector2.new(1, 0)
		local tween2 = TweenService:Create(aUIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear),
			{ Offset = Vector2.new(0, 0) })
		tween2:Play()
		task.wait(1)
	end
end)

Text.FocusLost:Connect(function()
	sk:CommandInputable(Text.Text, Text)
	MainFrame.Transparency = 0
	Decor.BackgroundTransparency = 1
	Decor.Transparency = 1
	local trans = TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		Transparency = 1
	})
	trans:Play()
	trans = TweenService:Create(Decor, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1,
		Transparency = 1
	})
	trans:Play()
	task.wait(0.1)
	SKCMD.Enabled = false
end)

--\\ Command Registers //--
sk:CreateCommand("help", "List all commands and binds.", "help", function()
	print(" ")
	sk:Log("Help", "All Skywarp Commands")
	for _i, v in pairs(sk.Commands) do
		sk:Log("H", " " .. tostring(v.NAME) .. " " .. " " .. tostring(v.ALIAS) .. " " .. " " .. tostring(v.DESC))
	end
	print(" ")
	sk:Log("Help", "All Skywarp Bindings")
	for _i, v in pairs(sk.Binds) do
		sk:Log("H", tostring(v.NAME) .. " " .. " " .. tostring(v.ENUM) .. " " .. " " .. tostring(v.STATUS))
	end
	print(" ")
	sk:Log("Help", "All Skywarp Components")
	for _i, v in pairs(sk.Components) do
		sk:Log("H", tostring(v.NAME) .. " " .. " " .. tostring(v.STATUS))
	end
	print(" ")
	sk:Log("Help", "All Live Settings")
	for _i, v in pairs(sk.LiveSettings) do
		sk:Log("H", tostring(v.NAME) .. " " .. " " .. tostring(v.STATUS))
	end
	sk:Log("Help", "All Skywarp Bases")
	for _i, v in pairs(sk.Bases) do
		sk:Log("H", tostring(v.NAME) .. " " .. " " .. tostring(v.DESC) .. " " .. " " .. tostring(v.TOGGLED))
	end
end, true)

sk:CreateCommand("bind", "Modify binds", "b", function(type, sname)
  for _i, v in pairs(sk.Binds) do
    if type == "enable" or type == "e" then
      if v.NAME == sname or v.ALIAS == sname then
        if v.NAME == "focusbar" or v.ALIAs == "fub" then return end
        v.STATUS = true
      elseif sname == "all" or sname == "All" then
        if v.NAME == "focusbar" or v.ALIAS == "fub" then return end
        v.STATUS = true 
      end
    else if type == "disable" or type == "d" then
      if v.NAME == sname or v.ALIAS then
        if v.NAME == "focusbar" or v.ALIAS == "fub" then return end
        v.STATUS = false
      elseif sname == "all" or sname == "All" then
        if v.NAME == "focusbar" or v.ALIAS == "fub" then return end
        v.STATUS = false
      end
    end
  end
  end
end, false)

sk:CreateCommand("component", "Modify components", "c", function(type, sname)
  if type == "disable" or type == "d" then
    for _i, v in pairs(sk.Components) do
      if v.NAME == sname then
        v.STATUS = false
      elseif sname == "all" or sname == "All" then
        for i,x in pairs(sk.Components) do
          x.STATUS = false
        end
      end
    end
  elseif type == "enable" or type == "e" then
    for _i, v in pairs(sk.Components) do
      if v.NAME == sname then
        v.STATUS = true 
      elseif sname == "all" or sname == "All" then
        for i,x in pairs(sk.Components) do
          x.STATUS = true
        end
      end
    end
  end
end, false)

sk:CreateCommand("livesetting", "Change Live Settings", "ls", function(type, sname)
  if type == "disable" or type == "d" then
    for _i, v in pairs(sk.LiveSettings) do
      if v.NAME == sname then
        v.STATUS = false
      end
    end
  elseif type == "enable" or type == "e" then
    for _i, v in pairs(sk.LiveSettings) do
      if v.NAME == sname then
        v.STATUS = true
      end
    end
  end
end, false)

sk:CreateCommand("say", "Say something in chat", "say", function(arg)
	local message = arg
	local target = "All"
	ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, target)
end, true)

sk:CreateCommand("enablecoregui", "Enables all CoreGui Elements", "ecg", function()
	game:GetService("StarterGui"):SetCoreGuiEnabled('Backpack', true)
	game:GetService("StarterGui"):SetCoreGuiEnabled('PlayerList', true)
	game:GetService("StarterGui"):SetCoreGuiEnabled('Chat', true)
	game:GetService("StarterGui"):SetCore('ResetButtonCallback', true)
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end, false)

sk:CreateCommand("clicktp", "Teleports to players cursor.", "ctp", function()
	local mouse = Player:GetMouse()
	if sk:GetLSetting("synctp").STATUS == true then
		if mouse.Target.CanCollide == false or mouse.Target.Transparency == 1 then
			local mousePos = mouse.Hit
			local mouseTar = mouse.Target

			sk.Temp.cWeldPart = Instance.new("Part")
			sk.Temp.cWeldPart.Parent = sk.PartStorage
			sk.Temp.cWeldPart.CanCollide = false
			sk.Temp.cWeldPart.Anchored = false
			sk.Temp.cWeldPart.CFrame = mousePos
			sk.Temp.cWeldPart.Transparency = 1

			sk.Temp.cWeld = Instance.new("WeldConstraint")
			sk.Temp.cWeld.Parent = sk.Temp.cWeldPart
			sk.Temp.cWeld.Part0 = sk.Temp.cWeldPart
			sk.Temp.cWeld.Part1 = mouseTar

			sk.Temp.Pos3 = Player.Character.HumanoidRootPart.CFrame

			--# WARNING: REMOVING THIS LINE DELETES THE OPERATION SYSTEM !
			--# what is this why is this here ?? ? ?
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

			local TemporaryPart = Instance.new("Part")
			TemporaryPart.CanCollide = false
			TemporaryPart.Anchored = true
			TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
			TemporaryPart.Transparency = 1

			workspace.CurrentCamera.CameraSubject = TemporaryPart
			Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
				Player.Character.HumanoidRootPart.CFrame.Z)
			Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
				Player.Character.HumanoidRootPart.CFrame.Z)
			task.wait(0.07)
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
			TemporaryPart:Destroy()
			sk.Temp.cWeldPart:Destroy()
			if sk.PlayerRig == "R6" then
				Player.Character.HumanoidRootPart.CFrame = sk.Temp.cWeldPart.CFrame + sk.Settings.ClickTPIncrementR6
			else
				Player.Character.HumanoidRootPart.CFrame = sk.TempcWeldPart.CFrame + sk.Settings.ClickTPIncrementR15
			end
			mouse.TargetFilter = nil
		else
			local mousePos = mouse.Hit
			sk.Temp.Pos3 = Player.Character.HumanoidRootPart.CFrame
			local mouseTar = mouse.Target

			sk.Temp.cWeldPart = Instance.new("Part")
			sk.Temp.cWeldPart.Parent = sk.PartStorage
			sk.Temp.cWeldPart.CanCollide = false
			sk.Temp.cWeldPart.Anchored = false
			sk.Temp.cWeldPart.CFrame = mousePos
			sk.Temp.cWeldPart.Transparency = 1

			sk.Temp.cWeld = Instance.new("WeldConstraint")
			sk.Temp.cWeld.Parent = sk.Temp.cWeldPart
			sk.Temp.cWeld.Part0 = sk.Temp.cWeldPart
			sk.Temp.cWeld.Part1 = mouseTar

			local TemporaryPart = Instance.new("Part")
			TemporaryPart.CanCollide = false
			TemporaryPart.Anchored = true
			TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
			TemporaryPart.Transparency = 1

			workspace.CurrentCamera.CameraSubject = TemporaryPart
			Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
				Player.Character.HumanoidRootPart.CFrame.Z)
			Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
				Player.Character.HumanoidRootPart.CFrame.Z)
			task.wait(0.07)
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
			TemporaryPart:Destroy()
			sk.Temp.cWeldPart:Destroy()
			if sk.PlayerRig == "R6" then
				Player.Character.HumanoidRootPart.CFrame = sk.Temp.cWeldPart.CFrame + sk.Settings.ClickTPIncrementR6
			else
				Player.Character.HumanoidRootPart.CFrame = sk.Temp.cWeldPart.CFrame + sk.Settings.ClickTPIncrementR15
			end
		end
	elseif sk:GetLSetting("synctp").STATUS == false then
		if mouse.Target.CanCollide == false or mouse.Target.Transparency == 1 then
			local mousePos = mouse.Hit
			sk.Temp.Pos3 = Player.Character.HumanoidRootPart.CFrame
			if sk.PlayerRig == "R6" then
				Player.Character.HumanoidRootPart.CFrame = mousePos + sk.Settings.ClickTPIncrementR6
			else
				Player.Character.HumanoidRootPart.CFrame = mousePos + sk.Settings.ClickTPIncrementR15
			end
			mouse.TargetFilter = nil
		else
			local mousePos = mouse.Hit
			sk.Temp.Pos3 = Player.Character.HumanoidRootPart.CFrame
			if sk.PlayerRig == "R6" then
				Player.Character.HumanoidRootPart.CFrame = mousePos + sk.Settings.ClickTPIncrementR6
			else
				Player.Character.HumanoidRootPart.CFrame = mousePos + sk.Settings.ClickTPIncrementR15
			end
		end
	end
end, false)

sk:CreateCommand("undoclicktp", "Undo player's previous clicktp.", "uctp", function()
	if sk.Temp.Pos3 == nil then return end
	if sk:GetLSetting("synctp").STATUS == true then
		sk.Temp.Pos2 = Player.Character.HumanoidRootPart.CFrame
		local TemporaryPart = Instance.new("Part")
		TemporaryPart.CanCollide = false
		TemporaryPart.Anchored = true
		TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
		TemporaryPart.Transparency = 1

		workspace.CurrentCamera.CameraSubject = TemporaryPart
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		task.wait(0.07)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
		TemporaryPart:Destroy()
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.Pos3
	else
		sk.Temp.Pos2 = Player.Character.HumanoidRootPart.CFrame
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.Pos3
	end
end, false)

sk:CreateCommand("redoclicktp", "Redo player's previous click tp.", "rctp", function()
	if sk.Temp.Pos2 == nil then return end
	if sk:GetLSetting("synctp").STATUS == true then
		local TemporaryPart = Instance.new("Part")
		TemporaryPart.CanCollide = false
		TemporaryPart.Anchored = true
		TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
		TemporaryPart.Transparency = 1

		workspace.CurrentCamera.CameraSubject = TemporaryPart
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		task.wait(0.07)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
		TemporaryPart:Destroy()
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.Pos2
	else
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.Pos2
	end
end, false)

sk:CreateCommand("goto", "Teleports to a player.", "tp", function(arg)
	local plr = sk:GetPlayer(arg)
	if sk:GetLSetting("syncgoto").STATUS == true then
		local TemporaryPart = Instance.new("Part")
		TemporaryPart.CanCollide = false
		TemporaryPart.Anchored = true
		TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
		TemporaryPart.Transparency = 1
		workspace.CurrentCamera.CameraSubject = TemporaryPart
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
			Player.Character.HumanoidRootPart.CFrame.Z)
		task.wait(0.07)
		workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
		TemporaryPart:Destroy()
		Player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
	else
		Player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
	end
end, false)

sk:CreateCommand("freeze", "Freezes the player.", "frez", function()
	for _i, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
		end
	end
end, false)

sk:CreateCommand("unfreeze", "Unfreezes the player.", "thaw", function()
	for _i, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = false
		end
	end
end, false)

sk:CreateCommand("gravity", "Changes workspace Gravity.", "grav", function(arg)
	if arg then
		workspace.Gravity = arg
	else
		workspace.Gravity = 196
	end
end, false)

sk:CreateCommand("respawn", "Makes the player respawn", "re", function()
	local char = game:GetService("Players").LocalPlayer.Character
	if char:FindFirstChildOfClass("Humanoid") then
		char:FindFirstChildOfClass("Humanoid"):ChangeState(15)
	end
	char:ClearAllChildren()

	local newChar = Instance.new("Model")
	newChar.Parent = sk.PartStorage
	game:GetService("Players").LocalPlayer.Character = newChar
	task.wait()
	game:GetService("Players").LocalPlayer.Character = char
	newChar:Destroy()
end, false)

sk:CreateCommand("fixcam", "Fixes the player's camera", "fixc", function()
	local plr = game:GetService("Players").LocalPlayer
	local speaker = plr
	workspace.CurrentCamera:Destroy()
	task.wait(0.1)

	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA("Humanoid")
	workspace.CurrentCamera.CameraType = "Custom"
	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false

	task.wait(1)
end, false)

sk:CreateCommand("launch", "Launches the player upwards.", "l", function(arg)
	for _i, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("Part") or v:IsA("BasePart") then
			v.Velocity = Vector3.new(0, arg, 0)
		end
	end
end, false)

local CameraPlacement
sk:CreateCommand("ultrainstinct", "Dodge those bullets", "uinst", function()
	local toggle = sk:GetCommand("ultrainstinct")
	if toggle.TOGGLED == false then
		toggle.TOGGLED = true
		CameraPlacement = Instance.new("Part")
		CameraPlacement.Parent = sk.PartStorage
		CameraPlacement.Anchored = true
		CameraPlacement.CanCollide = false
		CameraPlacement.Transparency = 0.9
		CameraPlacement.Size = Vector3.new(1, 1, 1)
		CameraPlacement.Position = Player.Character:FindFirstChild("Head").Position
		CameraPlacement.BrickColor = BrickColor.new("Really red")
		CameraPlacement.Material = Enum.Material.Neon

		workspace.CurrentCamera.CameraSubject = CameraPlacement
		sk.Temp.oGUltraInstinctPos = Player.Character.HumanoidRootPart.CFrame

		task.spawn(function()
			while task.wait() do
				if toggle.TOGGLED == true then
					Player.Character.HumanoidRootPart.CFrame = sk.Temp.oGUltraInstinctPos * CFrame.new()
				else
					break
				end
			end
		end)
	end
end)

sk:CreateCommand("unultrainstinct", "Undodge those bullets", "ununi", function()
	local toggle = sk:GetCommand("ultrainstinct")
	if toggle.TOGGLED == true then
		toggle.TOGGLED = false

		workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
		CameraPlacement:Destroy()
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.oGUltraInstinctPos
	end
end)

sk:CreateCommand("droptools", "Drops all tools", "dt", function(arg)
	for _i, v in pairs(Player.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.CanBeDropped = true
			v.Parent = Player.Character
		end
	end
	task.wait()
	for _i, v in pairs(Player.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = workspace
		end
	end
end, false)

sk:CreateCommand("walkspeed", "Changes the player's walkspeed", "ws", function(arg)
	Player.Character.Humanoid.WalkSpeed = arg
end, false)

sk:CreateCommand("jumppower", "Changes the player's jumppower", "jp", function(arg)
	Player.Character.Humanoid.JumpPower = arg
end, false)

sk:CreateCommand("follow", "Follows the a player around", "fo", function(arg)
	if sk:GetCommand("follow").TOGGLED == false then
		local cho = sk:GetPlayer(arg)
		sk:GetCommand("follow").TOGGLED = true

		coroutine.resume(coroutine.create(function()
			repeat
				task.wait()
				if sk:GetCommand("follow").TOGGLED == true then
					Player.Character.Humanoid.Sit = false
					Player.Character.Humanoid:MoveTo(cho.Character.HumanoidRootPart.Position)
				end
			until sk:GetCommand("follow").TOGGLED == false
		end))
	end
end)

sk:CreateCommand("unfollow", "Stops following", "unfo", function(arg)
	if sk:GetCommand("follow").TOGGLED == true then
		sk:GetCommand("follow").TOGGLED = false
	end
end)

sk:CreateCommand("aifollow", "Experiment Bot AI", "aif", function(arg)
	--TODO:
	--When to jump check using raycasts.
	if sk:GetCommand("aifollow").TOGGLED == false then
		pcall(function()
			local cho = sk:GetPlayer(arg)
			sk:GetCommand("aifollow").TOGGLED = true

			coroutine.resume(coroutine.create(function()
				repeat
					task.wait()
					if sk:GetCommand("aifollow").TOGGLED == true then
						local p = Instance.new("Part")
						p.Parent = sk.PartStorage
						p.Anchored = true
						p.Transparency = 1
						p.CanCollide = false
						p.CFrame = cho.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
						Player.Character.Humanoid.Sit = false
						--> Player.Character.Humanoid:MoveTo(cho.Character.HumanoidRootPart.Position)
						Player.Character.Humanoid:MoveTo(p.Position)
						Player.CameraMode = Enum.CameraMode.LockFirstPerson
						--> Player.Character.Humanoid.Jump = cho.Character.Humanoid.Jump
						workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,
							cho.Character.HumanoidRootPart.CFrame.p)
						p:Destroy()
					else
						coroutine.yield()
					end
				until sk:GetCommand("aifollow").TOGGLED == false or cho.Character.Humanoid.Health <= 0
				sk:GetCommand("aifollow").TOGGLED = false
				coroutine.yield()
				Player.CameraMode = Enum.CameraMode.Classic
			end))
		end)
	end
end)

sk:CreateCommand("unaifollow", "Stops AI", "unaif", function()
	if sk:GetCommand("aifollow").TOGGLED == true then
		sk:GetCommand("aifollow").TOGGLED = false
		Player.CameraMode = Enum.CameraMode.Classic
	end
end)

sk:CreateCommand("aihunt", "Attacks target", "aih", function(arg)
	if sk:GetCommand("aihunt").TOGGLED == false then
		local cho = sk:GetPlayer(arg)
		local choc = cho.Character
		sk:GetCommand("aihunt").TOGGLED = true

		coroutine.resume(coroutine.create(function()
			repeat
				task.wait()
				if sk:GetCommand("aihunt").TOGGLED == true then
					local p = Instance.new("Part")
					p.Parent = sk.PartStorage
					p.Anchored = true
					p.Transparency = 1
					p.CanCollide = false
					p.CFrame = cho.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 18)
					Player.Character.Humanoid.Sit = false
					Player.Character.Humanoid:MoveTo(p.Position)
					Player.CameraMode = Enum.CameraMode.LockFirstPerson
					workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p,
						cho.Character.HumanoidRootPart.CFrame.p)
					p:Destroy()
				end
			until sk:GetCommand("aihunt").TOGGLED == false or choc:FindFirstChild("Humanoid").Health <= 0
			sk:GetCommand("aihunt").TOGGLED = false
		end))
	end
end)

sk:CreateCommand("unaihunt", "Stop hunting", "unaih", function(arg)
	if sk:GetCommand("aihunt").TOGGLED == true then
		sk:GetCommand("aihunt").TOGGLED = false
	end
end)

sk:CreateCommand("pathfindfollow", "Path finds to player.", "pff", function(arg)
	if sk:GetCommand("pathfindfollow").TOGGLED == false then
		local cho = sk:GetPlayer(arg)
		local path = PathService:CreatePath()

		sk:GetCommand("pathfindfollow").TOGGLED = true
		coroutine.resume(coroutine.create(function()
			if sk:GetCommand("pathfindfollow").TOGGLED == true then
				Player.Character.Humanoid.Died:Connect(function()
					if sk:GetCommand("pathfindfollow").TOGGLED == true then
						sk:GetCommand("pathfindfollow").TOGGLED = false
					end
				end)
				local function PathFindFunction()
					repeat
						task.wait()
						if sk:GetCommand("pathfindfollow").TOGGLED == true then
							local _success, _response = pcall(function()
								path:ComputeAsync(Player.Character.HumanoidRootPart.Position, cho.Character.HumanoidRootPart.Position)
								local waypoints = path:GetWaypoints()
								local distance
								for _waypointIndex, waypoint in pairs(waypoints) do
									local waypointPosition = waypoint.Position
									Player.Character.Humanoid:MoveTo(waypointPosition)
									repeat
										task.wait()
										distance = (waypointPosition - Player.Character.Humanoid.Parent.PrimaryPart.Position).magnitude
									until
									distance <= 5
								end
							end)
						end
						--if not success then
						PathFindFunction()
						--end
					until sk:GetCommand("pathfindfollow").TOGGLED == false
				end

				PathFindFunction()
			else
				coroutine.yield()
			end
		end))
	end
end)

sk:CreateCommand("unpathfindfollow", "Stops pathfinding to player.", "unpff", function(arg)
	if sk:GetCommand("pathfindfollow").TOGGLED == true then
		sk:GetCommand("pathfindfollow").TOGGLED = false
	end
end)

sk:CreateCommand("unlockworkspace", "Unlocks all workspace parts", "unlockws", function()
	for _i, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Locked = false
		end
	end
end)

sk:CreateCommand("breakvelocity", "Breaks the player's velocity", "bv", function()
	for _i, v in pairs(Player.Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Velocity = Vector3.new(0, 0, 0)
			v.RotVelocity = Vector3.new(0, 0, 0)
		end
	end
end, false)

sk:CreateCommand("flash", "Flash like z vanish", "flas", function()
	local enabled = sk:GetCommand("flash").TOGGLED
	if enabled == false then
		sk:GetCommand("flash").TOGGLED = true
		enabled = true

		task.spawn(function()
			while task.wait(0.01) do
				if sk:GetCommand("flash").TOGGLED == true then
					local oldPos = Player.Character.HumanoidRootPart.CFrame
					local TemporaryPart = Instance.new("Part")
					TemporaryPart.CanCollide = false
					TemporaryPart.Anchored = true
					TemporaryPart.CFrame = Player.Character:FindFirstChild("Head").CFrame
					TemporaryPart.Transparency = 1
					workspace.CurrentCamera.CameraSubject = TemporaryPart
					Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
						Player.Character.HumanoidRootPart.CFrame.Z)
					Player.Character.HumanoidRootPart.CFrame = CFrame.new(Player.Character.HumanoidRootPart.CFrame.X, 99999999,
						Player.Character.HumanoidRootPart.CFrame.Z)
					task.wait(0.07)
					workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
					TemporaryPart:Destroy()
					Player.Character.HumanoidRootPart.CFrame = oldPos
					if sk:GetCommand("flash").TOGGLED == false then
						break
					end
				else
					break
				end
			end
		end)
	end
end)

sk:CreateCommand("unflash", "Unflashes", "unflas", function()
	if sk:GetCommand("flash").TOGGLED == true then
		sk:GetCommand("flash").TOGGLED = false
	end
end)

local camPart;
sk:CreateCommand("canceltransport", "Cancel's Transport command", "cts", function()
	if sk:GetCommand("transport").TOGGLED == true then
		sk:GetCommand("transport").TOGGLED = false

		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

		workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
		Player.Character.Head.Anchored = false
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.TransportPlayerPos
		camPart:Destroy()
	end
end)

sk:CreateCommand("gototransport", "Teleport's you to the transport's camera part", "gts", function()
	if sk:GetCommand("transport").TOGGLED == true then
		sk:GetCommand("transport").TOGGLED = false

		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
		Player.Character.Head.Anchored = false
		Player.Character.HumanoidRootPart.CFrame = camPart.CFrame
		camPart:Destroy()
	end
end)

sk:CreateCommand("changetransportspeed", "Change transport's speed", "chts", function(arg)
	sk.Temp.TransportSpeed = tonumber(arg)
end)

sk:CreateCommand("transport", "Allow you to travel fast yet precisely", "ts", function()
	local enabled = sk:GetCommand("transport")
	if enabled.TOGGLED == false then
		enabled.TOGGLED = true

		sk.Temp.TransportPlayerPos = Player.Character.HumanoidRootPart.CFrame

		local distance = 15
		local focused = false
		local focusedPart = nil

		local forward = false --# W
		local left = false    --# A
		local right = false   --# D
		local back = false    --# S
		local up = false      --# E
		local down = false    --# Q

		camPart = Instance.new("Part")
		camPart.Parent = sk.PartStorage
		camPart.Name = tostring(sk:RandomGenerate(100))
		camPart.Anchored = true
		camPart.Position = Player.Character.HumanoidRootPart.Position
		camPart.Size = Vector3.new(1, 1, 1)
		camPart.BrickColor = BrickColor.new("Really red")
		camPart.Material = Enum.Material.ForceField
		camPart.Transparency = 0

		workspace.CurrentCamera.CameraSubject = camPart
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

		task.spawn(function()
			RunService.RenderStepped:Connect(function()
				if enabled.TOGGLED == true then
					workspace.CurrentCamera.CFrame = CFrame.new(camPart.Position + (camPart.CFrame.UpVector * distance)) *
						CFrame.Angles(math.rad(-90), 0, 0)

					Player.Character.HumanoidRootPart.CFrame = camPart.CFrame * CFrame.new(0, 5000, 0)
					Player.Character.Humanoid.Sit = false
					sk:ExecuteCommand("breakvelocity")
				else
					return
				end
			end)
		end)

		Player:GetMouse().WheelForward:Connect(function()
			if enabled.TOGGLED == true then
				distance = distance - 10
			else
				return
			end
		end)

		Player:GetMouse().WheelBackward:Connect(function()
			if enabled.TOGGLED == true then
				distance = distance + 10
			else
				return
			end
		end)

		Player:GetMouse().Button1Down:Connect(function()
			if focused == false and Player:GetMouse().Target and enabled.TOGGLED == true then
				focusedPart = Player:GetMouse().Target
				print(focusedPart.Name)

				if focusedPart ~= nil then
					focused = true

					task.spawn(function()
						while task.wait() do
							if focused and enabled.TOGGLED == true then
								--camPart.Position.X = focusedPart.Position.X
								--camPart.Position.Z = focusedPart.Position.Z
								camPart.Position = focusedPart.Position
							else
								break
							end
						end
					end)
				end
			else
				focusedPart = nil
				focused = false
			end
		end)

		--# Movement
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.W and enabled.TOGGLED then
				forward = true
				left = false
				back = false
				right = false

				task.spawn(function()
					while task.wait() do
						if forward == true and enabled.TOGGLED == true then
							camPart.Position = camPart.Position + Vector3.new(0, 0, -sk.Temp.TransportSpeed)
						else
							break
						end
					end
				end)
			elseif input.KeyCode == Enum.KeyCode.A and enabled.TOGGLED then
				forward = false
				left = true
				right = false
				back = false

				task.spawn(function()
					while task.wait() do
						if left == true and enabled.TOGGLED == true then
							camPart.Position = camPart.Position + Vector3.new(-sk.Temp.TransportSpeed, 0, 0)
						else
							break
						end
					end
				end)
			elseif input.KeyCode == Enum.KeyCode.D and enabled.TOGGLED then
				forward = false
				left = false
				right = true
				back = false

				task.spawn(function()
					while task.wait() do
						if right == true and enabled.TOGGLED == true then
							camPart.Position = camPart.Position + Vector3.new(sk.Temp.TransportSpeed, 0, 0)
						else
							break
						end
					end
				end)
			elseif input.KeyCode == Enum.KeyCode.S and enabled.TOGGLED then
				forward = false
				left = false
				right = false
				back = true

				task.spawn(function()
					while task.wait() do
						if back == true and enabled.TOGGLED == true then
							camPart.Position = camPart.Position + Vector3.new(0, 0, sk.Temp.TransportSpeed)
						else
							break
						end
					end
				end)
			elseif input.KeyCode == Enum.KeyCode.E and enabled.TOGGLED then
				up = true

				task.spawn(function()
					while task.wait() do
						if up == true and enabled.TOGGLED == true then
							camPart.Position = camPart.Position + Vector3.new(0, 0.1, 0)
						else
							break
						end
					end
				end)
			elseif input.KeyCode == Enum.KeyCode.Q and enabled.TOGGLED then
				down = true

				task.spawn(function()
					while task.wait() do
						if down == true and enabled.TOGGLED then
							camPart.Position = camPart.Position + Vector3.new(0, -0.1, 0)
						else
							break
						end
					end
				end)
			end
		end)

		UserInputService.InputEnded:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.W and enabled.TOGGLED then
				forward = false
			elseif input.KeyCode == Enum.KeyCode.A and enabled.TOGGLED then
				left = false
			elseif input.KeyCode == Enum.KeyCode.D and enabled.TOGGLED then
				right = false
			elseif input.KeyCode == Enum.KeyCode.S and enabled.TOGGLED then
				back = false
			elseif input.KeyCode == Enum.KeyCode.Q and enabled.TOGGLED then
				down = false
			elseif input.KeyCode == Enum.KeyCode.E and enabled.TOGGLED then
				up = false
			end
		end)
	end
end)

sk:CreateCommand("nomaterials", "Removes all Materials from parts", "nomats", function()
	for _i, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
		end
	end
end)

sk:CreateCommand("spectate", "View a player.", "view", function(arg)
	local spec = sk:GetPlayer(arg)
	workspace.CurrentCamera.CameraSubject = spec.Character.Humanoid
	sk:GetCommand("view").TOGGLED = true
end, false)

sk:CreateCommand("unspectate", "Disables the viewing of a player", "unview", function(arg)
	if sk:GetCommand("view").TOGGLED == true then
		workspace.CurrentCamera.CameraSubject = Player.Character.Humanoid
		sk:GetCommand("view").TOGGLED = false
	end
end, false)

sk:CreateCommand("noclip", "Allows the player to phase through walls.", "nc", function()
	if sk:GetCommand("nc").TOGGLED == false then
		task.wait(0.1)
		sk:GetCommand("nc").TOGGLED = true
		local function NoclipLoop()
			for _, child in pairs(Player.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
				end
			end
		end
		sk.Temp.NoclipHeartbeat = game:GetService('RunService').Stepped:Connect(NoclipLoop)
	end
end)

sk:CreateCommand("unnoclip", "Disables Noclip", "unnc", function()
	sk:GetCommand("noclip").TOGGLED = false
	sk.Temp.NoclipHeartbeat:Disconnect()
end, false)

sk:CreateCommand("esp", "Enables ESP from Prisma", "es", function()
	local cmdlp = game.Players.LocalPlayer
	local cmdp = game.Players
	ESPNEnabled = false
	TrackN = false
	function CreateN(xPlayer, xHead)
		local ESP = Instance.new("BillboardGui", xHead)
		local ESPSquare = Instance.new("Frame", ESP)
		local ESPText = Instance.new("TextLabel", ESP)
		ESP.Name = "ESP"
		ESP.Adornee = xHead
		ESP.AlwaysOnTop = true
		ESP.ExtentsOffset = Vector3.new(0, 1, 0)
		ESP.Size = UDim2.new(0, 5, 0, 5)
		ESPText.Name = "NAME"
		ESPText.BackgroundColor3 = Color3.new(255, 255, 255)
		ESPText.BackgroundTransparency = 1
		ESPText.BorderSizePixel = 0
		ESPText.Position = UDim2.new(0, 0, 0, -40)
		ESPText.Size = UDim2.new(1, 0, 10, 0)
		ESPText.Visible = true
		ESPText.ZIndex = 10
		ESPText.Font = Drawing.Fonts.Monospace--Enum.Font.SourceSansSemibold
		ESPText.TextStrokeTransparency = 0
		ESPText.TextColor = xPlayer.TeamColor
		ESPText.TextSize = 18
		local uitext_size_constraint = Instance.new("UITextSizeConstraint",ESPText)
		uitext_size_constraint.MaxTextSize = 14
		uitext_size_constraint.MinTextSize = 9
		if xPlayer.DisplayName == xPlayer.Name then
			ESPText.Text = xPlayer.Name
		else
			ESPText.Text = xPlayer.DisplayName.." ("..xPlayer.Name..")"
		end
		coroutine.resume(coroutine.create(function()
			while task.wait() do
				pcall(function()
					if xHead.Parent.Humanoid.Health <= 0 then
						coroutine.yield()
					end

					if xPlayer:IsFriendsWith(plr.UserId) then
						ESPText.TextColor3 = colour
					else
						ESPText.TextColor = xPlayer.TeamColor
					end
				end)
			end
		end))
	end
	ESPNEnabled = true
	local function Handler(player)
		if player ~= plr and ESPNEnabled then
			repeat
				wait()
				local suc = pcall(function()
					CreateN(player,player.Character.Head)
				end)
			until suc
		end
	end
	for i,v in pairs(game.Players:GetPlayers()) do
		Handler(v)
		v.CharacterAdded:Connect(function()
			task.wait(1)
			Handler(v)
		end)
	end
	game.Players.PlayerAdded:Connect(function(play)
		task.wait(1)
		Handler(play)
		play.CharacterAdded:Connect(function()
			Handler(play)
		end)
	end)
end, false)

sk:CreateCommand("unesp", "Disables ESP", "unes", function()
	ESPNEnabled = false
	pcall(function()
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Character then
				if v.Character.Head:FindFirstChild("ESP") then
					v.Character.Head.ESP:Destroy()
				end
			end
		end
	end)
end, false)


sk:CreateCommand("sit", "Makes the player sit.", "sit", function()
	Player.Character.Humanoid.Sit = true
end, false)

sk:CreateCommand("destroypart", "Destroys the part the player is looking at.", "dp", function()
	local mouse = Player:GetMouse()
	local t = mouse.Target
	t:Destroy()
end, false)

sk:CreateCommand("profly", "Allows you to fly with a part", "pf", function()
	if sk:GetCommand("pf").TOGGLED == false then
		sk:GetCommand("pf").TOGGLED = true
		coroutine.resume(coroutine.create(function()
			while task.wait() do
				if sk:GetCommand("pf").TOGGLED == true then
					local eproflyPart = Instance.new("Part")
					eproflyPart.Anchored = true
					eproflyPart.Material = sk.Settings.ProflyMaterial
					eproflyPart.Transparency = 0.4
					eproflyPart.Parent = sk.PartStorage
					if sk.PlayerRig == "R6" then
						eproflyPart.CFrame = Player.Character.HumanoidRootPart.CFrame - sk.Settings.R6ProflyIncrement
					elseif sk.PlayerRig == "R15" then
						eproflyPart.CFrame = Player.Character.HumanoidRootPart.CFrame - sk.Settings.R15ProflyIncrement
					end

					eproflyPart.Anchored = true
					eproflyPart.BrickColor = sk.Settings.ProflyColor
					eproflyPart.Size = sk.Settings.ProflySize
					DebrisService:AddItem(eproflyPart, 0.01)
				else
					coroutine.yield()
				end
			end
		end))
	end
end)

sk:CreateCommand("unprofly", "Disables profly", "unpf", function()
	sk:GetCommand("pf").TOGGLED = false
end)

--# Flying stuff (From IY)
local FLYING = sk:GetCommand("fly")
-- local vfly = sk:GetCommand("vfly")
local QEfly = sk.Temp.QEFly
local iyflyspeed = sk.Settings.FlySpeed
local vehicleflyspeed = sk.Settings.VehicleFlySpeed

local function sFLY(vfly)
  local IYMouse = Player:GetMouse()
	repeat wait() until Player and Player.Character and Player.Character.HumanoidRootPart and Player.Character.Humanoid
	repeat wait() until IYMouse
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = Player.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat wait()
				if not vfly and Player.Character:FindFirstChildOfClass('Humanoid') then
					Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Player.Character:FindFirstChildOfClass('Humanoid') then
				Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
	if Player.Character:FindFirstChildOfClass('Humanoid') then
		Player.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
	end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

sk:CreateCommand("flyspeed", "Changes flight speed", "fspeed", function(arg)
  sk.Settings.FlySpeed = arg
end, false)

sk:CreateCommand("vehicleflyspeed", "Changes vehicle flight speed", "vflyspeed", function(arg)
  sk.Settings.VehicleFlySpeed = arg
end, false)

sk:CreateCommand("vehiclefly", "VFly (From IY)", "vfly", function()
  sFLY(true)
end, false)

sk:CreateCommand("unvehiclefly", "Disables VFly (From IY)", "unvfly", function()
  NOFLY()
end)

sk:CreateCommand("fly", "Finally I added fly to this after like 15 years", "f", function()
  sFLY(false)
end, false)

sk:CreateCommand("unfly", "Disables flight", "unf", function()
  NOFLY()
end, false)

sk:CreateCommand("awsvalue", "Sets the autowalkspeed value", "awsv", function(arg)
	sk.Settings.AutoWalkSpeedValue = arg
end, false)

sk:CreateCommand("ajpvalue", "Sets the autojumppower value", "ajpv", function(arg)
	sk.Settings.AutoJumpPowerValue = arg
end, false)

sk:CreateCommand("speedup", "Allows the player to speed up.", "sp", function()
	sk.Temp.ogAWS = sk:GetComponent("aws").STATUS
	sk:GetComponent("aws").STATUS = false
	Player.Character.Humanoid.WalkSpeed = sk.Settings.SpeedupValue
	sk:GetCommand("sp").STATUS = true
end)

sk:CreateCommand("unspeedup", "Disables speedup.", "unsp", function()
	if sk:GetCommand("sp").STATUS == true then
		sk:GetCommand("sp").STATUS = false
		Player.Character.Humanoid.WalkSpeed = 16
		sk:GetCommand("aws").STATUS = sk.Temp.ogAWS
	end
end)

sk:CreateCommand("commandhistory", "Prints Command History", "commandh", function(arg)
	for _i, v in pairs(sk.CommandHistory) do
		print(v.NAME)
	end
end, false)

sk:CreateCommand("editmode", "A experimental mode for quickly editing scripts.", "edit", function()
	local player = game:GetService("Players").LocalPlayer

	local platF = Instance.new("Part")
	platF.Parent = workspace
	platF.Anchored = true
	platF.CanCollide = true
	platF.CFrame = CFrame.new(999, 999, 9999)
	platF.Size = Vector3.new(100, 0, 100)
	platF.BrickColor = BrickColor.new("Bright green")
	platF.Material = Enum.Material.Grass

	local currentCharacter
	currentCharacter = player.Character

	local newCharacter
	local nH
	local currentPos
	function assignCharacter()
		currentCharacter.HumanoidRootPart.CFrame = platF.CFrame * CFrame.new(0, 3, 0)
		currentCharacter.Archivable = true

		newCharacter = currentCharacter:Clone()
		newCharacter.Parent = workspace
		for _i, v in pairs(currentCharacter:GetChildren()) do
			if v:IsA("LocalScript") then
				local clone = v:Clone()
				clone.Disabled = true
				clone.Parent = newCharacter
			end
		end

		player.Character = newCharacter
		workspace.CurrentCamera.CameraSubject = newCharacter.Humanoid
		nH = newCharacter.Humanoid
		nH.Died:Connect(function()
			currentPos = newCharacter.HumanoidRootPart.CFrame
			warn("Fake Character has died.")
			newCharacter:Destroy()
			assignCharacter()
			newCharacter.HumanoidRootPart.CFrame = currentPos
		end)
	end

	--# First time run
	assignCharacter()

	currentCharacter.Humanoid.Died:Connect(function()
		warn("Real character has died.")
		task.wait(3)
		assignCharacter()
	end)
end)

sk:CreateCommand("spawnpoint", "Sets the players spawnpoint", "spawn", function()
	sk.Temp.Spawn = nil;
	local s = Instance.new("Part")
	s.Parent = sk.PartStorage
	s.Name = "Spawnpoint"
	s.Anchored = false
	s.Transparency = 1
	s.BrickColor = BrickColor.new("Really black")
	s.Size = Vector3.new(0.1, 0.1, 0.1)
	s.CFrame = Player.Character.HumanoidRootPart.CFrame
	s.CanCollide = false

	local r = Ray.new(s.CFrame.p, Vector3.new(0, -100, 0))
	local pr = workspace:FindPartOnRay(r, Player.Character)
	if pr then
		local weld = Instance.new("WeldConstraint")
		weld.Parent = sk.PartStorage
		weld.Part0 = s
		weld.Part1 = pr
		s.CFrame = Player.Character.HumanoidRootPart.CFrame
	end
	sk.Temp.Spawn = s
end)

sk:CreateCommand("rspawn", "Removes the player's set spawnpoint", "rs", function()
	sk.Temp.Spawn = nil
end)

sk:CreateCommand("fullbright", "Maps every bright.", "fb", function()
	sk.Temp.ogBright = LightingService.Brightness
	sk.Temp.ogTime = LightingService.ClockTime
	sk.Temp.ogFog = LightingService.FogEnd
	sk.Temp.ogShadow = LightingService.GlobalShadows
	sk.Temp.ogAmbient = LightingService.OutdoorAmbient
	LightingService.Brightness = 2
	LightingService.ClockTime = 14
	LightingService.FogEnd = 100000
	LightingService.GlobalShadows = false
	LightingService.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

sk:CreateCommand("unfullbright", "Restores original lighting settings", "unfb", function()
	LightingService.Brightness = sk.Temp.ogBright
	LightingService.ClockTime = sk.Temp.ogTime
	LightingService.FogEnd = sk.Temp.ogFog
	LightingService.GlobalShadows = sk.Temp.ogShadow
	LightingService.OutdoorAmbient = sk.Temp.ogAmbient
end)

sk:CreateCommand("speedupvalue", "Changes speedup values", "suv", function(arg)
	sk.Settings.SpeedupValue = arg
end)

sk:CreateCommand("trip", "Trips the player over. From IY.", "stun", function()
	if sk:GetComponent("antifall").STATUS == true then
		sk.Temp.ogAntiFall = sk:GetComponent("antifall").STATUS
		sk:GetComponent("antifall").STATUS = false
		Player.Character.Humanoid:ChangeState(0)
		Player.Character.HumanoidRootPart.Velocity = Player.Character.HumanoidRootPart.Velocity * 30
	end
end)

sk:CreateCommand("enablecosemetic", "Enables cosemetic", "ecos", function(arg)
	if sk:GetCosemetic(arg) then
		local a = sk:GetCosemetic(arg)
		a.TOGGLED = true
	end
end)

sk:CreateCommand("disablecosemetic", "Disables cosemetic", "dcos", function(arg)
	if sk:GetCosemetic(arg) then
		local a = sk:GetCosemetic(arg)
		a.TOGGLED = false
	end
end)

sk:CreateCommand("gotobase", "Teleports you to your base", "gb", function()
	for _i, v in pairs(sk.Bases) do
		if v.TOGGLED == true then
			sk.Temp.OldBasePos = Player.Character.HumanoidRootPart.CFrame
			Player.Character.HumanoidRootPart.CFrame = v.TP
		end
	end
end)

sk:CreateCommand("leavebase", "Leaves base.", "lb", function()
	Player.Character.HumanoidRootPart.CFrame = sk.Temp.OldBasePos
end)

sk:CreateCommand("switchbase", "Switch current base.", "sb", function(arg)
	for _i, v in pairs(sk.Bases) do
		if v.NAME == arg then
			for _i, x in pairs(sk.Bases) do
				if x.NAME ~= arg then
					x.TOGGLED = false
				end
			end
			for _i, x in pairs(sk.Bases) do
				if x.NAME == arg then
					x.TOGGLED = true
				end
			end
		end
	end
end)

--\\ Bind Registers //--
sk:AddHoldableBind("speedup", "Speeds the player up.", "sp", sk.BindSettings.Speedup, true, function()
	sk:ExecuteCommand("speedup")
end, function()
	sk:ExecuteCommand("unspeedup")
	sk:ExecuteCommand("breakvelocity")
end)

sk:AddBind("breakvelocity", "Breaks the player's velocity.", "bv", sk.BindSettings.BreakVelocity, true, function()
	sk:ExecuteCommand("breakvelocity")
end)

sk:AddBind("transport", "Oribtal Cannon", "ts", sk.BindSettings.Transport, true, function()
	local toggle = sk:GetCommand("transport")

	if toggle.TOGGLED == true then
		sk:ExecuteCommand("gototransport")
	elseif toggle.TOGGLED == false then
		sk:ExecuteCommand("transport")
	end
end)

sk:AddBind("focusbar", "Focuses the commandbar", "fub", sk.BindSettings.FocusBind, true, function()
	if SKCMD.Enabled == true then
		MainFrame.Transparency = 0
		Decor.BackgroundTransparency = 1
		Decor.Transparency = 1
		SKCMD.Enabled = false
		local trans = TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection
			.Out), {
				Transparency = 1
			})
		trans:Play()
		trans = TweenService:Create(Decor, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1,
			Transparency = 1,
		})
		trans:Play()
	elseif SKCMD.Enabled == false or SKCMD.Enabled == "false" or not SKCMD.Enabled then
		MainFrame.Transparency = 1
		Decor.BackgroundTransparency = 1
		Decor.Transparency = 0
		SKCMD.Enabled = true

		local trans = TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection
			.Out), {
				Transparency = 0
			})
		trans:Play()
		trans = TweenService:Create(Decor, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1,
			Transparency = 0
		})
		trans:Play()
		task.wait(0.0000001)
		Text:CaptureFocus()
	end
end)

sk:AddBind("clicktp", "Teleport Player to mouse.", "ctp", sk.BindSettings.ClickTP, true, function()
	sk:ExecuteCommand("clicktp")
end)

sk:AddBind("undoclicktp", "Undo player's previous click tp.", "uctp", sk.BindSettings.UndoClickTP, true, function()
	sk:ExecuteCommand("undoclicktp")
end)

sk:AddBind( "redoclicktp", "Redo player's undo click tp.", "rctp", sk.BindSettings.RedoClickTP, true, function()
	sk:ExecuteCommand("redoclicktp")
end)

sk:AddBind("destroypart", "Destroy the part.", "dp", sk.BindSettings.DestroyPart, true, function()
	sk:ExecuteCommand("destroypart")
end)

sk:AddBind("noclip", "Allows the player to phase through walls", "nc", sk.BindSettings.Noclip, true, function()
	local n = sk:GetCommand("noclip")
	if n.TOGGLED == false then
		sk:ExecuteCommand("noclip")
		sk:Log("Bind", "Executing noclip")
	elseif n.TOGGLED == true then
		sk:ExecuteCommand("unnoclip")
	end
end)

sk:AddBind("profly", "Allows the player to fly with parts.", "pf", sk.BindSettings.Profly, true, function()
	local n = sk:GetCommand("profly").TOGGLED
	if n == false then
		sk:ExecuteCommand("profly")
	elseif n == true then
		sk:ExecuteCommand("unprofly")
	end
end)

--\\ Spawn & Death Handler //--
Player.CharacterAdded:Connect(function()
	if sk.Temp.Spawn and sk.Temp.Spawn ~= nil then
		task.wait(1)
		Player.Character.HumanoidRootPart.CFrame = sk.Temp.Spawn.CFrame
	end
end)

Player.Character.Humanoid.Died:Connect(function()
	sk.Temp.DeathCount = tonumber(sk.Temp.DeathCount) + 1
end)

--\\ ChatLog Handers //--
sk:ChatLog("[Skywarp] >> Loaded SKMain.lua", Color3.fromRGB(120, 150, 222), Enum.Font.SourceSansBold, Enum.FontSize
	.Size8)

PlayerService.PlayerAdded:Connect(function(Name)
	sk:ChatLog("[Skywarp] >> " .. tostring(Name) .. " " .. "[" .. tostring(Name.DisplayName) .. "]" .. " Has joined.",
		Color3.new(25, 25, 230), Enum.Font.SourceSansBold, Enum.FontSize.Size8)
end)
PlayerService.PlayerRemoving:Connect(function(Name)
	sk:ChatLog("[Skywarp] >> " .. tostring(Name) .. " " .. "[" .. tostring(Name.DisplayName) .. "]" .. " Has left.",
		Color3.new(25, 25, 230), Enum.Font.SourceSansBold, Enum.FontSize.Size8)
end)

--\\ Checks //--
UserInputService.WindowFocused:Connect(function()
	if sk.Settings.AllowTabCheck == false then return end
	sk.Temp.TabbedOut = false

	local function TabbedIn()
		if sk.PlayerRig == "R6" then
			Player.Character["Head"].Material = Enum.Material.SmoothPlastic
			Player.Character["Torso"].Material = Enum.Material.SmoothPlastic
			Player.Character["Left Arm"].Material = Enum.Material.SmoothPlastic
			Player.Character["Right Arm"].Material = Enum.Material.SmoothPlastic
			Player.Character["Left Leg"].Material = Enum.Material.SmoothPlastic
			Player.Character["Right Leg"].Material = Enum.Material.SmoothPlastic
		elseif sk.PlayerRig == "R15" then
			return false
		end
	end

	TabbedIn()
end)

UserInputService.WindowFocusReleased:Connect(function()
	if sk.Settings.AllowTabCheck == false then return end
	sk.Temp.TabbedOut = true

	local function TabbedOut()
		if sk.PlayerRig == "R6" then
			Player.Character["Head"].Material = Enum.Material.ForceField
			Player.Character["Torso"].Material = Enum.Material.ForceField
			Player.Character["Left Arm"].Material = Enum.Material.ForceField
			Player.Character["Right Arm"].Material = Enum.Material.ForceField
			Player.Character["Left Leg"].Material = Enum.Material.ForceField
			Player.Character["Right Leg"].Material = Enum.Material.ForceField
		elseif sk.PlayerRig == "R15" then
			return false
		end
	end

	TabbedOut()
end)

--\\ Cosemetic Registers //--
sk:AddCosemetic("glove", "Glove Cosemetic", false, "R6", function()
	if sk.PlayerRig == "R6" and sk:GetCosemetic("glove") then
		local function InitGlove()
			if sk:GetCosemetic("glove").TOGGLED == false then return end
			if sk:GetCosemetic("glove").TOGGLED == true then
				local p1 = Instance.new("Part")
				p1.Name = "LeftGlove"
				p1.Parent = sk.PartStorage
				p1.Size = Vector3.new(1.1, 1.3, 1.1)
				p1.Orientation = Player.Character["Left Arm"].Orientation
				p1.CanCollide = false
				p1.Anchored = false
				p1.Position = Player.Character["Left Arm"].Position + Vector3.new(0, -0.01, 0)
				p1.BrickColor = sk.CosemeticSettings.GloveCosemetic.BrickColor
				p1.Material = sk.CosemeticSettings.GloveCosemetic.Material

				local p2 = Instance.new("WeldConstraint")
				p2.Parent = sk.PartStorage
				p2.Part0 = Player.Character["Left Arm"]
				p2.Part1 = p1
			end
		end
		if sk:GetCosemetic("glove").TOGGLED == true then
			InitGlove()
		end

		Player.CharacterAdded:Connect(function()
			task.wait(1)
			InitGlove()
		end)
	end
end)

--\\ Game Setting Overrides //--
for _i, v in pairs(sk.GameOverride) do
	if game.PlaceId == v then
		sk:ExecuteCommand("db", "all")
		sk:ExecuteCommand("dc", "all")
	end
end

--\\ Create Visualization Components //--
local Selection = Instance.new("Highlight");
Selection.OutlineColor = sk.Settings.HighlightColor
Selection.FillTransparency = 1
Selection.Parent = sk.PartStorage
Selection.DepthMode = Enum.HighlightDepthMode.Occluded

for _i, v in pairs(sk.OverlayUI:GetChildren()) do
  v.Parent.Name = tostring(sk:RandomGenerate(100))
  v.Name = tostring(sk:RandomGenerate(100))
end

for _i, v in pairs(sk.Storage:GetChildren()) do
  v.Name = tostring(sk:RandomGenerate(100))
end

for _i, v in pairs(SKCMD:GetDescendants()) do
  v.Name = tostring(sk:RandomGenerate(100))
end

sk.PartStorage.Name = tostring(sk:RandomGenerate(100))

--\\ Runtime Handler //--
RunService.RenderStepped:Connect(function()
	for _i, v in pairs(sk.Bases) do
		if v.TOGGLED == false then
			if v.MODEL.Parent ~= sk.RStorage then
				v.MODEL.Parent = sk.RStorage
			end
		elseif v.TOGGLED == true then
			if v.MODEL.Parent == sk.RStorage then
				v.MODEL.Parent = sk.PartStorage
			end
		end
	end
	if sk.Settings.ChangeMaxCameraZoom == true then
		Player.CameraMaxZoomDistance = 500
		Player.CameraMinZoomDistance = 0.1
	end
	if sk:GetComponent("cursoricon").STATUS == true then
		Player:GetMouse().Icon = "rbxassetid://68308747"
	else
		Player:GetMouse().Icon = MouseId
	end
	if sk:GetComponent("hls").STATUS == true then
		pcall(function()
			Selection.Adornee = Player:GetMouse().Target
			Selection.Parent = workspace.Camera
		end)
	else
		pcall(function()
			Selection.Adornee = nil
		end)
	end
	if sk:GetComponent("atf").STATUS == true then
		pcall(function()
			Player.Character.Humanoid.PlatformStand = false
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		end)
	else
		pcall(function()
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			Player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		end)
	end
	if sk:GetComponent("aws").STATUS == true then
		pcall(function()
			Player.Character.Humanoid.WalkSpeed = sk.Settings.AutoWalkSpeedValue
		end)
	end
	if sk:GetComponent("ajp").STATUS == true then
		pcall(function()
			Player.Character.Humanoid.JumpPower = sk.Settings.AutoJumpPowerValue
		end)
	end
  if sk:GetComponent("aco").STATUS == true then
    pcall(function()
      if Player.Character.Humanoid.Health <= 0.90 then
        Player.Character.HumanoidRootPart.CFrame = sk.GalaticCenter
      end
    end)
  end
end)
