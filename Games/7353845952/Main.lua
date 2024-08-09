return function(Package)
    local Stem = `https://raw.githubusercontent.com/onlyokok/Francium/main/Games/{game.PlaceId}`
    local Leaf = `{Stem}/Tabs`

    local Window = Package.Interface.Linoria:CreateWindow({
        ["Title"] = Package.Title,
        ["Size"] = UDim2.fromOffset(550, 600),
        ["Center"] = true,
        ["AutoShow"] = true,
        ["TabPadding"] = 8,
        ["MenuFadeTime"] = 0.1
    })

    local Main = loadstring(game:HttpGet(`{Leaf}/Main.lua`))()
    Main:Setup(Package, Window)

    local Visuals = loadstring(game:HttpGet(`{Leaf}/Visuals.lua`))()
    Visuals:Setup(Package, Window)

    local Settings = loadstring(game:HttpGet(`{Leaf}/Settings.lua`))()
    Settings:Setup(Package, Window)
end