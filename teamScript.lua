local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

--[[
	TeamShow function to show a single team
	When the team is clicked it displays the team name
	and a list of players in that team
]]--

local function teamShow(Team)
	local TeamGui = script.Parent.Parent.Parent.Parent.TeamGUI
	local TeamsGui = script.Parent.Parent.Parent.Parent.TeamsGUI
	local SamplePlr = script.Parent.Parent.Parent.Parent.SamplePlr
	TeamGui.TeamContainer.TextHolder.TeamText.Text = Team
	
	-- Display every player inside the Plrs scrolling frame
	
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr:WaitForChild("leaderstats"):WaitForChild("TeamValue").Value == Team and not TeamGui.TeamContainer.Plrs:FindFirstChild(tostring(plr)) then
			local newPlr = SamplePlr:Clone()
			newPlr.Visible = true
			newPlr.Parent = TeamGui.TeamContainer.Plrs
			newPlr.Name = tostring(plr)
			newPlr.PlayerName.Text = tostring(plr)
			newPlr.PlayerTeam.Text = tostring(Team)
		end
	end
	
	-- Tweens to show up the team gui
	
	local tweenPropriety = {
		Position = UDim2.fromScale(0.273, 1.1),
		Visible = false
	}
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local Tween = TweenService:Create(TeamsGui.TeamsContainer, tweenInfo, tweenPropriety)
	Tween:Play()
	
	wait(0.3)
	
	tweenPropriety = {
		Position = UDim2.fromScale(0.273, 0.143),
		Visible = true
	}
	tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween = TweenService:Create(TeamGui.TeamContainer, tweenInfo, tweenPropriety)
	Tween:Play()
	
	TeamGui.TeamContainer.X.Activated:Connect(function()
		TweenService = game:GetService("TweenService")
		tweenPropriety = {
			Position = UDim2.fromScale(0.273, 1.1),
			Visible = false
		}
		tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		Tween = TweenService:Create(TeamGui.TeamContainer, tweenInfo, tweenPropriety)
		Tween:Play()

		wait(0.3)

		tweenPropriety = {
			Position = UDim2.fromScale(0.273, 0.143),
			Visible = true
		}
		tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		Tween = TweenService:Create(TeamsGui.TeamsContainer, tweenInfo, tweenPropriety)
		Tween:Play()
	end)
end

--[[
	Refresh function to refresh the teams displayed inside the gui
	Fires each time a player joins or quits and each time the value
	inside the "TeamValue" in leaderstats changes
]]--

local function refresh()
	local Teams = {
		Red = 0,
		Blue = 0, 
		Green = 0, 
		Purple = 0, 
		Black = 0, 
		White = 0, 
		Yellow = 0, 
		Grey = 0, 
		Pink = 0, 
		Brown = 0
	}
	
	-- Increase the counter if a player has that team
	for _, plr in ipairs(Players:GetPlayers()) do
		for team, plrnmbr in pairs(Teams) do
			if plr:WaitForChild("leaderstats"):WaitForChild("TeamValue").Value == tostring(team) then
				Teams[team] += 1
			end
		end
	end
	
	-- Create a frame for each team with at least 1 player
	for team, plrnmbr in pairs(Teams) do
		if not (plrnmbr == 0) and not script.Parent:FindFirstChild(team.."Team") then
			local newTeam = StarterGui.SampleTeam:Clone()
			newTeam.Parent = script.Parent
			newTeam.Name = tostring(team).."Team"
			newTeam.TeamName.Text = tostring(team)
			newTeam.TeamPlayers.Text = tostring(plrnmbr).." PLAYERS"
			newTeam.Visible = true
			newTeam.ShowPlayers.Activated:Connect(function()
				teamShow(tostring(team))
			end)
		end
	end
end

-- Events to trigger the refresh function
script.Parent.Parent.Changed:Connect(refresh)
Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)
Players.PlayerAdded:Connect(function(plr)
	plr:WaitForChild("leaderstats"):WaitForChild("TeamValue").Changed:Connect(refresh)
end)


-- Simple Blur Effect for Visual Improvement
local BlurEffect = game:GetService("Lighting").Blur

local Player = Players.LocalPlayer

-- All the GUIs Needed for the Code
local Buttons = Player.PlayerGui:WaitForChild("BasicGUI"):WaitForChild("Buttons")
local Teams = Player.PlayerGui:WaitForChild("TeamsGUI"):WaitForChild("TeamsContainer")

-- Basic Positions of the GUIs
local ButtonsPos = UDim2.fromScale(0, 0.937)
local GUIPos = UDim2.fromScale(0.273, 0.143)

-- Makes Sure Everything is Where it is Supposed to be
Buttons.Position = ButtonsPos
Buttons.Visible = true
Teams.Position = UDim2.fromScale(0.273, 1.1)
Teams.Visible = false

-- Tweens Away the Buttons
local function hideButtons()
	local tweenPropriety = {
		Position = UDim2.fromScale(0, 1),
		Visible = false
	}
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local Tween = TweenService:Create(Buttons, tweenInfo, tweenPropriety)
	Tween:Play()
end

-- Tweens in the Buttons
local function showButtons()
	local tweenPropriety = {
		Position = ButtonsPos,
		Visible = true
	}
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local Tween = TweenService:Create(Buttons, tweenInfo, tweenPropriety)
	Tween:Play()
end

-- Tweens in the Teams
local function showTeams()
	local tweenPropriety = {
		Position = GUIPos,
		Visible = true
	}
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local Tween = TweenService:Create(Teams, tweenInfo, tweenPropriety)
	Tween:Play()
	BlurEffect.Enabled = true
end

-- Tweens Away the Teams
local function hideTeams()
	local tweenPropriety = {
		Position = UDim2.fromScale(0.273, 1.1),
		Visible = false
	}
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local Tween = TweenService:Create(Teams, tweenInfo, tweenPropriety)
	Tween:Play()
	BlurEffect.Enabled = false
end

-- Once the Teams Button is Clicked, it Triggers the Functions to Hide the Buttons and to Show the Teams GUI
Buttons.TeamButton.MouseButton1Click:Connect(function()

	hideButtons()

	wait(0.2)

	showTeams()

end)

-- Once the X Button on top of the Teams GUI is Clicked, it Triggers the Functions to Hide the Teams GUI and to Show the Buttons
Teams.X.MouseButton1Click:Connect(function()

	hideTeams()

	wait(0.2)

	showButtons()

end)




-- Original Creator: 𝕻𝖗𝖎𝖒𝖚𝖘
