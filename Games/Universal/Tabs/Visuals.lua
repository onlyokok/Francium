local Visuals = {}

function Visuals:Construct(Package)
    local function MakeSection(Title, Side)
        if Side:lower() == "left" then
            return self.Tab:AddLeftGroupbox(Title)
        elseif Side:lower() == "right" then
            return self.Tab:AddRightGroupbox(Title)
        end
    end

    local function MakeOptionsSection(Side)
        local Section = MakeSection("Options", Side)

        Section:AddToggle('EspEnabled', {
            Text = 'Enabled',
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.Enabled = Value
            end
        }):AddKeyPicker("EspEnabledKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Esp Enabled",
            NoUI = true,
        })
    
        Section:AddToggle('EspLimitDistance', {
            Text = 'Limit Distance',
            Default = false,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.LimitDistance = Value
            end
        })
    
        Section:AddSlider("EspMaxDistance", {
            Text = "Max Distance",
            Default = 20000,
            Min = 0,
            Max = 20000,
            Rounding = 0,
            Compact = false,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.MaxDistance = Value
            end
        })
    
        Section:AddDivider()
    
        Section:AddToggle('EspCheckTeam', {
            Text = 'Check Team',
            Default = false,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.CheckTeam = Value
            end
        })
    
        Section:AddToggle('EspUseTeamColor', {
            Text = 'Use Team Color',
            Default = false,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.UseTeamColor = Value
            end
        })
    
        Section:AddDivider()
    
        local Fonts = {
            UI = 0,
            System = 1,
            Plex = 2,
            Monospace = 3
        }
    
        Section:AddDropdown("EspTextFont", {
            Values = {"UI", "System", "Plex", "Monospace"},
            Default = 4,
            Multi = false,
            Text = "Text Font",
            Callback = function(Value)
                Package.Helpers.Esp.Settings.TextFont = Fonts[Value]
            end
        })
    
        Section:AddSlider("EspTextSize", {
            Text = "Text Size",
            Default = 12,
            Min = 10,
            Max = 20,
            Rounding = 0,
            Compact = false,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.TextSize = Value
            end
        })
    
        Section:AddDivider()
    
        Section:AddToggle("EspName", {
            Text = "Name",
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.Name = Value
            end
        }):AddColorPicker("EspNameColorPicker", {
            Default = Color3.new(1, 1, 1),
            Title = "Name Color",
            Callback = function(Value)
                Package.Helpers.Esp.Settings.NameColor = Value
            end
        })
    
        Section:AddToggle('EspDistance', {
            Text = 'Distance',
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.ShowDistance = Value
            end
        })
    
        Section:AddToggle('EspBox', {
            Text = 'Box',
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.Box = Value
            end
        }):AddColorPicker("EspBoxColorPicker", {
            Default = Color3.new(1, 1, 1),
            Title = "Box Color",
            Callback = function(Value)
                Package.Helpers.Esp.Settings.BoxColor = Value
            end
        })
    
        Section:AddToggle('EspHealthBar', {
            Text = 'Health Bar',
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.HealthBar = Value
            end
        })
    
        Section:AddToggle('EspHealthText', {
            Text = 'Health Text',
            Default = true,
            Callback = function(Value)
                Package.Helpers.Esp.Settings.HealthText = Value
            end
        }):AddColorPicker("EspHealthColorPicker", {
            Default = Color3.fromRGB(0, 255, 0),
            Title = "Health Color",
            Callback = function(Value)
                Package.Helpers.Esp.Settings.HealthTextColor = Value
            end
        })

        return Section
    end

    MakeOptionsSection("Left")

    for _,Player in next, game.Players:GetPlayers() do
        if Player ~= game.Players.LocalPlayer then
            Package.Helpers.Esp.New(Player)
        end
    end

    Package.Interface.Linoria:GiveSignal(game.Players.PlayerAdded:Connect(function(Player)
        Package.Helpers.Esp.New(Player)
    end))
end

function Visuals:Setup(Package, Window)
    self.Tab = Window:AddTab("Visuals")

    self:Construct(Package)
end

return Visuals