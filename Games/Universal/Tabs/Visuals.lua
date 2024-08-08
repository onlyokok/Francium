local Visuals = {}

function Visuals:Construct(Package)

end

function Visuals:Setup(Package, Window)
    self.Tab = Window:AddTab("Visuals")

    self:Construct(Package)
end