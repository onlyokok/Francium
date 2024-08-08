local Visuals = {}

function Visuals:Construct(Package)
    local Options = self.Tab:AddLeftGroupbox("options")

    Options:AddToggle('EspEnabled', {
        Text = 'enabled',
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.Enabled = Value
        end
    }):AddKeyPicker("EspEnabledKeyPicker", {
        Default = "None",
        SyncToggleState = true,
        Mode = "Toggle",
        NoUI = true,
    })

    Options:AddToggle('EspLimitDistance', {
        Text = 'limit distance',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.LimitDistance = Value
        end
    })

    Options:AddSlider("EspMaxDistance", {
        Text = "max distance",
        Default = 20000,
        Min = 0,
        Max = 20000,
        Rounding = 0,
        Compact = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.MaxDistance = Value
        end
    })

    Options:AddDivider()

    Options:AddToggle('EspCheckTeam', {
        Text = 'check team',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.CheckTeam = Value
        end
    })

    Options:AddToggle('EspUseTeamColor', {
        Text = 'use team color',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.UseTeamColor = Value
        end
    })

    Options:AddDivider()

    local Fonts = {
        UI = 0,
        System = 1,
        Plex = 2,
        Monospace = 3
    }

    Options:AddDropdown("EspTextFont", {
        Values = {"UI", "System", "Plex", "Monospace"},
        Default = 4,
        Multi = false,
        Text = "text font",
        Callback = function(Value)
            Package.Helpers.Esp.Settings.TextFont = Fonts[Value]
        end
    })

    Options:AddSlider("EspTextSize", {
        Text = "text size",
        Default = 12,
        Min = 10,
        Max = 20,
        Rounding = 0,
        Compact = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.TextSize = Value
        end
    })

    local Players = self.Tab:AddLeftGroupbox("players")

    Players:AddToggle("EspName", {
        Text = "name",
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.Name = Value
        end
    }):AddColorPicker("EspNameColorPicker", {
        Default = Color3.new(1, 1, 1),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.Settings.NameColor = Value
        end
    })

    Players:AddToggle('EspDistance', {
        Text = 'distance',
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.ShowDistance = Value
        end
    })

    Players:AddToggle('EspBox', {
        Text = 'box',
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.Box = Value
        end
    }):AddColorPicker("EspBoxColorPicker", {
        Default = Color3.new(1, 1, 1),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.Settings.BoxColor = Value
        end
    })

    Players:AddToggle('EspHealthBar', {
        Text = 'health bar',
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.HealthBar = Value
        end
    })

    Players:AddToggle('EspHealthText', {
        Text = 'health text',
        Default = true,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.HealthText = Value
        end
    }):AddColorPicker("EspHealthColorPicker", {
        Default = Color3.fromRGB(0, 255, 0),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.Settings.HealthTextColor = Value
        end
    })

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
    self.Tab = Window:AddTab("visuals")

    self:Construct(Package)
end

return Visuals