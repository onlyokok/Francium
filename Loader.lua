local Stem = "https://raw.githubusercontent.com/onlyokok/Sena/main/"

local Games = `{Stem}/Games`
local Modules = `{Stem}/Modules`

local Package = {
    Interface = {
        Linoria = loadstring(game:HttpGet(`{Modules}/Interface/Linoria.lua`))(),
        Addons = {
            SaveManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/SaveManager.lua`))(),
            ThemeManager = loadstring(game:HttpGet(`{Modules}/Interface/Addons/ThemeManager.lua`))()
        }
    }
}

local Success, Value = pcall(function()
    return game:HttpGet(`{Games}/{game.PlaceId}/Main.lua`)
end)

if Success then
    loadstring(Value)()["Load"](Package)
else
    loadstring(game:HttpGet(`{Games}/Universal/Main.lua`))(Package)
end