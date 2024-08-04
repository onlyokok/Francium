local Main = {}

function Main:Construct(Package)
    local function CreateMovementSection(Side)
        local Section = nil

        if Side == "Left" then
            Section = self.Tab:AddLeftGroupbox("Movement")
        elseif Side == "Right" then
            Section = self.Tab:AddRightGroupbox("Movement")
        end

        Section:AddToggle("Fly", {
            Text = "Fly",
            Default = false,
        }):AddKeyPicker("FlyKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Fly",
            NoUI = false,
        })

        Section:AddSlider("FlySpeed", {
            Text = "Fly Speed",
            Default = 50,
            Min = 25,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })

        Section:AddSlider("FallSpeed", {
            Text = "Fall Speed",
            Default = 25,
            Min = 25,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })

        Section:AddToggle("WalkSpeed", {
            Text = "Walk Speed",
            Default = false,
        }):AddKeyPicker('WalkSpeedKeyPicker', {
            Default = 'None',
            SyncToggleState = true,
            Mode = 'Toggle',
            Text = 'Walk Speed',
            NoUI = false,
        })

        Section:AddSlider('WalkSpeedValue', {
            Text = 'Walk Speed Value',
            Default = 25,
            Min = 5,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })

        Section:AddToggle("JumpPower", {
            Text = "Jump Power",
            Default = false,
        }):AddKeyPicker("JumpPowerKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Jump Power",
            NoUI = false,
        })

        Section:AddSlider("JumpPowerValue", {
            Text = "Jump Power Value",
            Default = 50,
            Min = 50,
            Max = 200,
            Rounding = 0,
            Compact = false,
        })

        Section:AddDropdown("JumpPowerMethod", {
            Values = {"Velocity", "Humanoid"},
            Default = 1,
            Multi = false,
            Text = "Jump Power Method",
        })

        Section:AddToggle("SafeMode", {
            Text = "Safe Mode",
            Tooltip = "Disables any active movement options",
            Default = false,
        }):AddKeyPicker("SafeModeKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Safe Mode",
            NoUI = false,
        })

        Package.Interface.Linoria:GiveTask(task.spawn(function()
            while task.wait() do
                if Toggles.Fly.Value then
                    if not Toggles.SafeMode.Value then
                        pcall(function()
                            local Velocity = Vector3.new(0, -Options.FallSpeed.Value / 10 , 0)
        
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
        
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Velocity
                            end
                        end)
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
                        if not Toggles.SafeMode.Value then
                            pcall(function()
                                if Options.JumpPowerMethod.Value == "Velocity" then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, Options.JumpPowerValue.Value, 0)
                                elseif Options.JumpPowerMethod.Value == "Humanoid" then
                                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                end
                            end)
                        end
                    end
                end
            end
        end))

        Section:AddLabel("Teleport To Ground"):AddKeyPicker("TeleportToGroundKeyPicker", {
            Default = "None",
            SyncToggleState = true,
            Mode = "Toggle",
            Text = "Teleport To Ground",
            NoUI = false,
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

    local Movement = CreateMovementSection("Left")
end

function Main:Setup(Package, Window)
    self.Tab = Window:AddTab("First Sea")

    self:Construct(Package)
end

return Main