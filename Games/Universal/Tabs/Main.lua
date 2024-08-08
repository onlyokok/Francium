local Main = {}

function Main:Construct(Package)
    local function MakeSection(Title, Side)
        if Side:lower() == "left" then
            return self.Tab:AddLeftGroupbox(Title)
        elseif Side:lower() == "right" then
            return self.Tab:AddRightGroupbox(Title)
        end
    end

    local function MakeMovementSection(Side)
        local Section = MakeSection("Movement", Side)

        Section:AddToggle("Fly", {
            Text = "fly",
            Default = false,
        }):AddKeyPicker("FlyKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "fly",
            NoUI = false,
        })
    
        Section:AddSlider("FlySpeed", {
            Text = "fly speed",
            Default = 50,
            Min = 25,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })
    
        Section:AddSlider("FallSpeed", {
            Text = "fall speed",
            Default = 25,
            Min = 25,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })
    
        Section:AddDivider()
    
        Section:AddToggle("WalkSpeed", {
            Text = "walk speed",
            Default = false,
        }):AddKeyPicker('WalkSpeedKeyPicker', {
            Default = 'None',
            SyncToggleState = true,
            Mode = 'Toggle',
            Text = 'walk speed',
            NoUI = false,
        })
    
        Section:AddSlider('WalkSpeedValue', {
            Text = 'value',
            Default = 25,
            Min = 5,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })
    
        Section:AddDivider()
    
        Section:AddToggle("JumpPower", {
            Text = "jump power",
            Default = false,
        }):AddKeyPicker("JumpPowerKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "jump power",
            NoUI = false,
        })
    
        Section:AddSlider("JumpPowerValue", {
            Text = "value",
            Default = 50,
            Min = 50,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })
    
        Section:AddDropdown("JumpPowerMethod", {
            Values = {"velocity", "humanoid"},
            Default = 1,
            Multi = false,
            Text = "method",
        })
    
        Section:AddDivider()
    
        Section:AddToggle("SafeMode", {
            Text = "safe mode",
            Default = false,
        }):AddKeyPicker("SafeModeKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "safe mode",
            NoUI = false,
        })
    
        Package.Interface.Linoria:GiveTask(task.spawn(function()
            while task.wait() do
                if Toggles.Fly.Value then
                    if not Toggles.SafeMode.Value then
                        if game.Players.LocalPlayer.Character then
                            local HumanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local Velocity = Vector3.new(0, -Options.FallSpeed.Value / 10 , 0)
            
                            if HumanoidRootPart then
                                if not game:GetService("UserInputService"):GetFocusedTextBox() then
                                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                                        Velocity += (workspace.CurrentCamera.CFrame.LookVector * Options.FlySpeed.Value)
                                    end
                            
                                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                                        Velocity += (workspace.CurrentCamera.CFrame.LookVector * -Options.FlySpeed.Value)
                                    end
                            
                                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                                        Velocity += (workspace.CurrentCamera.CFrame.RightVector * -Options.FlySpeed.Value)
                                    end
                            
                                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                                        Velocity += (workspace.CurrentCamera.CFrame.RightVector * Options.FlySpeed.Value)
                                    end
        
                                    HumanoidRootPart.Velocity = Velocity
                                end
                            end
                        end
                    end
                end
            end
        end))
    
        Package.Interface.Linoria:GiveTask(task.spawn(function()
            while task.wait() do
                if Toggles.WalkSpeed.Value then
                    if not Toggles.SafeMode.Value and not Toggles.Fly.Value then
                        pcall(function()
                            game.Players.LocalPlayer.Character:PivotTo(game.Players.LocalPlayer.Character:GetPivot() + (game.Players.LocalPlayer.Character.Humanoid.MoveDirection * (Options.WalkSpeedValue.Value / 100)))
                        end)
                    end
                end
            end
        end))
    
        Package.Interface.Linoria:GiveSignal(game:GetService("UserInputService").InputBegan:Connect(function(Input, GameProcessed)
            if not GameProcessed then
                if Input.KeyCode == Enum.KeyCode.Space then
                    if Toggles.JumpPower.Value then
                        if not Toggles.SafeMode.Value and not Toggles.Fly.Value then
                            local HumanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    
                            if Options.JumpPowerMethod.Value == "velocity" and HumanoidRootPart then
                                HumanoidRootPart.Velocity = Vector3.new(0, Options.JumpPowerValue.Value, 0)
                            elseif Options.JumpPowerMethod.Value == "humanoid" and Humanoid then
                                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end
                end
            end
        end))
    
        Section:AddLabel("Teleport To Ground"):AddKeyPicker("TeleportToGroundKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "teleport to ground",
            NoUI = true,
            Callback = function()
                local Origin = game.Players.LocalPlayer.Character:GetPivot().Position
                local Direction = Vector3.new(0, -9e9, 0)
    
                local Params = RaycastParams.new()
                Params.FilterType = Enum.RaycastFilterType.Exclude
                Params.FilterDescendantsInstances = game.Players.LocalPlayer.Character:GetDescendants()
    
                local Result = workspace:Raycast(Origin, Direction, Params)
                game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Result.Position))
            end
        })

        return Section
    end

    MakeMovementSection("Left")
end

function Main:Setup(Package, Window)
    self.Tab = Window:AddTab("universal")

    self:Construct(Package)
end

return Main