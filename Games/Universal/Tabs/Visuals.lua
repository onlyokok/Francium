local Visuals = {}

function Visuals:Construct(Package)
    local VisualsOptions = self.Tab:AddLeftGroupbox("options")

    VisualsOptions:AddToggle('EspEnabled', {
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

    VisualsOptions:AddToggle('EspLimitDistance', {
        Text = 'limit distance',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.LimitDistance = Value
        end
    })

    VisualsOptions:AddSlider("EspMaxDistance", {
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

    VisualsOptions:AddDivider()

    VisualsOptions:AddToggle('EspCheckTeam', {
        Text = 'check team',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.CheckTeam = Value
        end
    })

    VisualsOptions:AddToggle('EspUseTeamColor', {
        Text = 'use team color',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.UseTeamColor = Value
        end
    })

    VisualsOptions:AddDivider()

    local Fonts = {
        ui = 0,
        system = 1,
        plex = 2,
        monospace = 3
    }

    VisualsOptions:AddDropdown("EspTextFont", {
        Values = {"ui", "system", "plex", "monospace"},
        Default = 4,
        Multi = false,
        Text = "text font",
        Callback = function(Value)
            Package.Helpers.Esp.Settings.TextFont = Fonts[Value]
        end
    })

    VisualsOptions:AddSlider("EspTextSize", {
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

    local Players = self.Tab:AddRightGroupbox("players")

    Players:AddToggle("EspName", {
        Text = "name",
        Default = false,
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
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.ShowDistance = Value
        end
    })

    Players:AddToggle('EspBox', {
        Text = 'box',
        Default = false,
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
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.HealthBar = Value
        end
    })

    Players:AddToggle('EspHealthText', {
        Text = 'health text',
        Default = false,
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

    Players:AddToggle('EspChams', {
        Text = 'chams',
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.Settings.Chams = Value
        end
    }):AddColorPicker("EspChamsColorPicker", {
        Default = Color3.fromRGB(255, 0, 0),
        Title = "color",
        Transparency = .75
    })

    Options.EspChamsColorPicker:OnChanged(function()
        Package.Helpers.Esp.Settings.ChamsColor = Options.EspChamsColorPicker.Value
        Package.Helpers.Esp.Settings.ChamsTransparency = Options.EspChamsColorPicker.Transparency
    end)

    local Misc = self.Tab:AddRightGroupbox("world")

    local ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)

    Misc:AddToggle("Ambient", {
        Text = "ambient",
        Default = false,
    }):AddColorPicker("AmbientColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
    })

    Misc:AddToggle("DisableShadows", {
        Text = "disable shadows",
        Default = false,
        Callback = function(Value)
            game.Lighting.GlobalShadows = not Value
        end
    })

    Misc:AddDivider()

    Misc:AddToggle("Zoom", {
        Text = "zoom",
        Default = false,
    }):AddKeyPicker('KeyPicker', {
        Default = 'None',
        SyncToggleState = true,
        Mode = 'Toggle',
        NoUI = true,
    })

    Misc:AddSlider("ZoomValue", {
        Text = "value",
        Default = 40,
        Min = 10,
        Max = 70,
        Rounding = 0,
        Compact = false,
    })

    Misc:AddToggle("FieldOfView", {
        Text = "field of view",
        Default = false,
    })

    Misc:AddSlider("FieldOfViewValue", {
        Text = "value",
        Default = 70,
        Min = 70,
        Max = 120,
        Rounding = 0,
        Compact = false,
    })

    Misc:AddDivider()

    Misc:AddToggle("Brightness", {
        Text = "brightness",
        Default = false,
    })

    Misc:AddSlider("BrightnessValue", {
        Text = "value",
        Default = 2,
        Min = 2,
        Max = 20,
        Rounding = 0,
        Compact = false,
    })

    Misc:AddDivider()

    Package.Interface.Linoria:GiveTask(task.spawn(function()
        while task.wait() do
            if Toggles.Ambient.Value then
                ColorCorrection.TintColor = Options.AmbientColorPicker.Value
            else
                ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
            end

            if not Toggles.Zoom.Value then
                if Toggles.FieldOfView.Value then
                    workspace.CurrentCamera.FieldOfView = Options.FieldOfViewValue
                else
                    workspace.CurrentCamera.FieldOfView = 70
                end
            else
                workspace.CurrentCamera.FieldOfView = Options.ZoomValue.Value
            end

            if Toggles.Brightness.Value then
                game.Lighting.Brightness = Options.BrightnessValue.Value
            else
                game.Lighting.Brightness = 2
            end
        end
    end))

    Package.Interface.Linoria:GiveSignal(workspace.CurrentCamera.Changed:Connect(function()
        if Toggles.FieldOfView.Value then
            if not Toggles.Zoom.Value then
                workspace.CurrentCamera.FieldOfView = Options.FieldOfViewValue.Value
            end
        end
    end))

    Package.Interface.Linoria:GiveSignal(game.Lighting.Changed:Connect(function()
        if Toggles.Brightness.Value then
            game.Lighting.Brightness = Options.BrightnessValue.Value
        end
    end))

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