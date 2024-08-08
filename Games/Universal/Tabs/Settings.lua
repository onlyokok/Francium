local Settings = {}

function Settings:Construct(Package)
    local Menu = self.Tab:AddLeftGroupbox('Menu')

    Menu:AddToggle('ShowKeybinds', {
        Text = 'Show Keybinds',
        Default = false,
        Callback = function(Value)
            Package.Interface.Linoria.KeybindFrame.Visible = Value
        end
    })

    Menu:AddToggle('ShowWatermark', {
        Text = 'Show Watermark',
        Default = true,
        Callback = function(Value)
            Package.Interface.Linoria:SetWatermarkVisibility(Value)
        end
    })

    local Other = self.Tab:AddLeftGroupbox('Other')

    Other:AddInput('NameChange', {Default = Package.Title, Numeric = false, Finished = false, Text = 'Window Title', Placeholder = '. . .'})
    
    Options.NameChange:OnChanged(function()
        self.Window:SetWindowTitle(`{Options.NameChange.Value}`)
        Package.Interface.Linoria:SetWatermark(`{Options.NameChange.Value}`)
    end)

    Other:AddButton("Rejoin", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)

    Package.Interface.Linoria:SetWatermark(`{Package.Title}`)

    Package.Interface.Linoria.KeybindFrame.Visible = Toggles.ShowKeybinds.Value

    Menu:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', { Default = 'LeftBracket', NoUI = true, Text = 'Menu Keybind' })
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
    self.Tab = Window:AddTab("Settings")

    self:Construct(Package)
    self:SetupManagers(Package)
end

return Settings