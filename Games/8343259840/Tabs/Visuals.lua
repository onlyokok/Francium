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

    local World = self.Tab:AddRightGroupbox("world")

    local ColorCorrection = Instance.new("ColorCorrectionEffect", game.Lighting)

    World:AddToggle("Ambient", {
        Text = "ambient",
        Default = false,
    }):AddColorPicker("AmbientColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
    })

    World:AddToggle("DisableShadows", {
        Text = "disable shadows",
        Default = false,
        Callback = function(Value)
            game.Lighting.GlobalShadows = not Value
        end
    })

    World:AddDivider()

    World:AddToggle("FieldOfView", {
        Text = "field of view",
        Default = false,
    })

    World:AddSlider("FieldOfViewValue", {
        Text = "value",
        Default = 70,
        Min = 70,
        Max = 120,
        Rounding = 0,
        Compact = false,
    })

    Package.Interface.Linoria:GiveTask(task.spawn(function()
        while task.wait() do
            if Toggles.Ambient.Value then
                ColorCorrection.TintColor = Options.AmbientColorPicker.Value
            else
                ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
            end

            if Toggles.FieldOfView.Value then
                workspace.CurrentCamera.FieldOfView = Options.FieldOfViewValue
            else
                workspace.CurrentCamera.FieldOfView = 70
            end
        end
    end))

    Package.Interface.Linoria:GiveSignal(workspace.CurrentCamera.Changed:Connect(function()
        if Toggles.FieldOfView.Value then
            workspace.CurrentCamera.FieldOfView = Options.FieldOfViewValue.Value
        end
    end))

    local PointsOfInterest = self.Tab:AddRightGroupbox("points of interest")

    PointsOfInterest:AddToggle("Dealers", {
        Text = "dealers",
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupVisibility("Dealers", Value)
        end
    }):AddColorPicker("DealersColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupColor("Dealers", Value)
        end
    })

    for _,Dealer in next, workspace.Map.Shopz:GetChildren() do
        Package.Helpers.Esp.Instance("Dealers", Dealer, Dealer.Name)
    end

    PointsOfInterest:AddToggle("Atms", {
        Text = "atms",
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupVisibility("Atms", Value)
        end
    }):AddColorPicker("AtmsColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupColor("Atms", Value)
        end
    })

    for _,Atm in next, workspace.Map.ATMz:GetChildren() do
        Package.Helpers.Esp.Instance("Atms", Atm, Atm.Name)
    end

    PointsOfInterest:AddToggle("MoneyMakers", {
        Text = "money makers",
        Default = false,
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupVisibility("MoneyMakers", Value)
        end
    }):AddColorPicker("MoneyMakersColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
        Callback = function(Value)
            Package.Helpers.Esp.SetGroupColor("MoneyMakers", Value)
        end
    })

    for _,Child in next, workspace.Map.BredMakurz:GetChildren() do
        Package.Helpers.Esp.Instance("MoneyMakers", Child, Child.Name)
    end

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