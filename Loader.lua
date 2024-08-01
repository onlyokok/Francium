local Stem = "https://raw.githubusercontent.com/onlyokok/Francium/main/"

local Games = `{Stem}/Games`
local Modules = `{Stem}/Modules`

local Package = {
    Title = "Francium",
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
    loadstring(Value)()(Package)
else
    loadstring(game:HttpGet(`{Games}/Universal/Main.lua`))()(Package)
end