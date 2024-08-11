local Settings = {}

function Settings:Construct(Package)
    local Menu = self.Tab:AddLeftGroupbox('menu')

    Menu:AddToggle('ShowKeybinds', {
        Text = 'show keybinds',
        Default = false,
        Callback = function(Value)
            Package.Interface.Linoria.KeybindFrame.Visible = Value
        end
    })

    Menu:AddToggle('ShowWatermark', {
        Text = 'show watermark',
        Default = true,
        Callback = function(Value)
            Package.Interface.Linoria:SetWatermarkVisibility(Value)
        end
    })

    local Other = self.Tab:AddLeftGroupbox('other')

    Other:AddInput('NameChange', {Default = Package.Title, Numeric = false, Finished = false, Text = 'window title', Placeholder = '. . .'})
    
    Options.NameChange:OnChanged(function()
        self.Window:SetWindowTitle(`{Options.NameChange.Value}`)
        Package.Interface.Linoria:SetWatermark(`{Options.NameChange.Value} | user`)
    end)

    Other:AddButton("rejoin", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)

    Package.Interface.Linoria:SetWatermark(`{Package.Title} | user`)

    Package.Interface.Linoria.KeybindFrame.Visible = Toggles.ShowKeybinds.Value

    Menu:AddLabel('menu keybind'):AddKeyPicker('MenuKeybind', { Default = 'LeftAlt', NoUI = true, Text = 'menu keybind' })
    Package.Interface.Linoria.ToggleKeybind = Options.MenuKeybind
end

function Settings:SetupManagers(Package)
    Package.Interface.Addons.SaveManager:SetLibrary(Package.Interface.Linoria)

    Package.Interface.Addons.SaveManager:IgnoreThemeSettings()

    Package.Interface.Addons.SaveManager:SetIgnoreIndexes({"MenuKeybind"})

    Package.Interface.Addons.SaveManager:SetFolder(`{Package.Title}/{game.PlaceId}`)

    Package.Interface.Addons.SaveManager:BuildConfigSection(self.Tab)
    Package.Interface.Addons.SaveManager:LoadAutoloadConfig()

    Package.Interface.Addons.ThemeManager:SetLibrary(Package.Interface.Linoria)

    Package.Interface.Addons.ThemeManager:SetFolder(Package.Title)

    Package.Interface.Addons.ThemeManager:ApplyToTab(self.Tab)
end

function Settings:Setup(Package, Window)
    self.Window = Window
    self.Tab = Window:AddTab("settings")

    self:Construct(Package)
    self:SetupManagers(Package)
end

return Settings