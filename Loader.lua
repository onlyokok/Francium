local Stem = "https://raw.githubusercontent.com/onlyokok/Francium/main"

local Games = `{Stem}/Games`
local Modules = `{Stem}/Modules`

local Package = {
    Title = "francium rewrite",
    Interface = {
        Linoria = loadstring(game:HttpGet(`{Modules}/Interface/Linoria.lua`))(),
    },
}

Package.Interface.Linoria:Notify("loaded linoria")

Package.Interface.Addons = {
    SaveManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/SaveManager.lua`))(),
    ThemeManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/ThemeManager.lua`))()
}

Package.Interface.Linoria:Notify("loaded addons")

Package.Helpers = {
    Esp = loadstring(game:HttpGet(`{Modules}/Helpers/Esp.lua`))(),
}

Package.Interface.Linoria:Notify("loaded esp")

local Success, Value = pcall(function()
    return game:HttpGet(`{Games}/{game.PlaceId}/Main.lua`)
end)

if Success then
    Package.Interface.Linoria:Notify("found game, please wait while the script loads")
    loadstring(Value)()(Package)
else
    Package.Interface.Linoria:Notify("unable to find game, please wait while the universal script loads")
    loadstring(game:HttpGet(`{Games}/Universal/Main.lua`))()(Package)
end

Package.Interface.Linoria:Notify("press leftalt to toggle the interface")