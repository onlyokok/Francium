local Stem = "https://raw.githubusercontent.com/onlyokok/Francium/main"

local Games = `{Stem}/Games`
local Modules = `{Stem}/Modules`

local Package = {
    Title = "francium rewrite",
    Interface = {
        Linoria = loadstring(game:HttpGet(`{Modules}/Interface/Linoria.lua`))(),
    },
}

Package.Interface.Linoria:Notify("Loaded Linoria")

Package.Interface.Addons = {
    SaveManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/SaveManager.lua`))(),
    ThemeManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/ThemeManager.lua`))()
}

Package.Interface.Linoria:Notify("Loaded Addons")

Package.Helpers = {
    Esp = loadstring(game:HttpGet(`{Modules}/Helpers/Esp.lua`))(),
}

Package.Interface.Linoria:Notify("Loaded Esp")

local Success, Value = pcall(function()
    return game:HttpGet(`{Games}/{game.PlaceId}/Main.lua`)
end)

if Success then
    Package.Interface.Linoria:Notify("Found game, please wait while the script loads")
    loadstring(Value)()(Package)
else
    Package.Interface.Linoria:Notify("Unable to find game, please wait while the universal script loads")
    loadstring(game:HttpGet(`{Games}/Universal/Main.lua`))()(Package)
end