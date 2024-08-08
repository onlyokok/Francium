local Visuals = {}

function Visuals:Construct(Package)

    local World = self.Tab:AddLeftGroupbox("world")

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
            if Toggles.FieldOfView.Value then
                workspace.CurrentCamera.FieldOfView = Options.FieldOfViewValue.Value
            else
                workspace.CurrentCamera.FieldOfView = 70
            end
        end
    end))
end

function Visuals:Setup(Package, Window)
    self.Tab = Window:AddTab("visuals")

    self:Construct(Package)
end

return Visuals