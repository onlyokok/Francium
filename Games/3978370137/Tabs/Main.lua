local Main = {}

function Main:Construct(Package)

end

function Main:Setup(Package, Window)
    self.Tab = Window:AddTab("First Sea")

    self:Construct(Package)
end

return Main