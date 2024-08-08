local Main = {}

function Main:Construct(Package)
    local function MakeSection(Title, Side)
        if Side:lower() == "left" then
            return self.Tab:AddLeftGroupbox(Title)
        elseif Side:lower() == "right" then
            return self.Tab:AddRightGroupbox(Title)
        end
    end

    local Movement = MakeSection("movement", "Left")

    Movement:AddToggle("Fly", {
        Text = "fly",
        Default = false,
    }):AddKeyPicker("FlyKeyPicker", {
        Default = "None",
        SyncToggleState = true,
        Mode = "Toggle",
        Text = "fly",
        NoUI = false,
    })

    Movement:AddSlider("FlySpeed", {
        Text = "fly speed",
        Default = 50,
        Min = 25,
        Max = 200,
        Rounding = 0,
        Compact = false,
    })

    Movement:AddSlider("FallSpeed", {
        Text = "fall speed",
        Default = 25,
        Min = 25,
        Max = 200,
        Rounding = 0,
        Compact = false,
    })

    Movement:AddDivider()

    Movement:AddToggle("WalkSpeed", {
        Text = "walk speed",
        Default = false,
    }):AddKeyPicker('WalkSpeedKeyPicker', {
        Default = 'None',
        SyncToggleState = true,
        Mode = 'Toggle',
        Text = 'walk speed',
        NoUI = false,
    })

    Movement:AddSlider('WalkSpeedValue', {
        Text = 'value',
        Default = 25,
        Min = 5,
        Max = 200,
        Rounding = 0,
        Compact = false,
    })

    Movement:AddDivider()

    Movement:AddToggle("JumpPower", {
        Text = "jump power",
        Default = false,
    }):AddKeyPicker("JumpPowerKeyPicker", {
        Default = "None",
        SyncToggleState = true,
        Mode = "Toggle",
        Text = "jump power",
        NoUI = false,
    })

    Movement:AddSlider("JumpPowerValue", {
        Text = "value",
        Default = 50,
        Min = 50,
        Max = 200,
        Rounding = 0,
        Compact = false,
    })

    Movement:AddDropdown("JumpPowerMethod", {
        Values = {"velocity", "humanoid"},
        Default = 1,
        Multi = false,
        Text = "method",
    })

    Movement:AddDivider()

    Movement:AddToggle("SafeMode", {
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

    Movement:AddLabel("teleport to ground"):AddKeyPicker("TeleportToGroundKeyPicker", {
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

    local Aimbot = MakeSection("aimbot", "Right")

    Aimbot:AddToggle("Aimbot", {
        Text = "aimbot",
        Default = false,
    })
    
    Toggles.Aimbot:AddKeyPicker("AimbotKeyPicker", {
        Default = "None",
        SyncToggleState = true,
        Mode = "Toggle",
        Text = "aimbot",
        NoUI = false,
    })

    Toggles.Aimbot:AddColorPicker("AimbotColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
    })

    Aimbot:AddDropdown("AimbotBodyPart", {
        Values = {"head", "humanoidrootpart"},
        Default = 1,
        Multi = false,
        Text = "body part",
    })

    Aimbot:AddDivider()

    Aimbot:AddToggle("AimbotSmoothing", {
        Text = "smoothing",
        Default = false,
    })

    Aimbot:AddSlider("AimbotSmoothingValue", {
        Text = "value",
        Default = 1,
        Min = 1,
        Max = 10,
        Rounding = 0,
        Compact = false,
    })

    Aimbot:AddDivider()

    Aimbot:AddToggle("AimbotShowFov", {
        Text = "show fov",
        Default = false,
    })

    Aimbot:AddToggle("AimbotSnapLine", {
        Text = "snap line",
        Default = false,
    }):AddColorPicker("AimbotSnapLineColorPicker", {
        Default = Color3.fromRGB(255, 255, 255),
        Title = "color",
    })

    Aimbot:AddSlider("AimbotFovSize", {
        Text = "fov size",
        Default = 50,
        Min = 50,
        Max = 1000,
        Rounding = 0,
        Compact = false,
    })

    local Fov = Drawing.new("Circle")
    Fov.Filled = false
    Fov.Thickness = 1
    Fov.Radius = Options.AimbotFovSize.Value
    Fov.NumSides = 64
    Fov.Color = Options.AimbotColorPicker.Value

    local Line = Drawing.new("Line")
    Line.Thickness = 1
    Line.Color = Options.AimbotSnapLineColorPicker.Value

    local function GetAimbotTarget()
        local ClosestPlayer = nil
        local ClosestDistance = math.huge
        
        for _,Player in next, game.Players:GetPlayers() do
            if Player ~= game.Players.LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Humanoid").Health > 0 then
                local CurrentCamera = workspace.CurrentCamera
                local MouseLocation = game:GetService("UserInputService"):GetMouseLocation()

                local Vector, _ = CurrentCamera:WorldToViewportPoint(Player.Character:GetPivot().Position)
                local Magnitude = (Vector2.new(MouseLocation.X, MouseLocation.Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude

                if Magnitude < ClosestDistance and Magnitude <= Options.AimbotFovSize.Value then
                    ClosestPlayer = Player
                    ClosestDistance = Magnitude
                end
            end
        end

        return ClosestPlayer
    end

    local BodyParts = {
        ["head"] = "Head",
        ["humanoidrootpart"] = "HumanoidRootPart"
    }

    Package.Interface.Linoria:GiveTask(task.spawn(function()
        while task.wait() do
            if Toggles.Aimbot.Value then
                local Target = GetAimbotTarget()
                local MouseLocation = game:GetService("UserInputService"):GetMouseLocation()

                if Target and Target.Character then
                    local BodyPart = Target.Character:FindFirstChild(BodyParts[Options.AimbotBodyPart.Value])

                    if BodyPart then
                        if Toggles.AimbotSmoothing.Value then
                            game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(Options.AimbotSmoothingValue.Value / 20), {CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, BodyPart.Position)}):Play()
                        else
                            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, BodyPart.Position)
                        end

                        if Toggles.AimbotSnapLine.Value then
                            local Vector, _ = workspace.CurrentCamera:WorldToViewportPoint(BodyPart.Position)

                            Line.Visible = true
                            Line.From = Vector2.new(MouseLocation.X, MouseLocation.Y)
                            Line.To = Vector2.new(Vector.X, Vector.Y)
                        end
                    end
                else
                    Line.Visible = false
                end

                if Toggles.AimbotShowFov.Value then
                    Fov.Visible = true
                    Fov.Radius = Options.AimbotFovSize.Value
                    Fov.Color = Options.AimbotColorPicker.Value
                    Fov.Position = Vector2.new(MouseLocation.X, MouseLocation.Y)
                else
                    Fov.Visible = false
                    Line.Visible = false
                end
            else
                Fov.Visible = false
                Line.Visible = false
            end
        end
    end))
end

function Main:Setup(Package, Window)
    self.Tab = Window:AddTab("universal")

    self:Construct(Package)
end

return Main