local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ws = game:GetService("Workspace")

local WD = ws.FallenPartsDestroyHeight
local OX

local function JustFling(T)
    local C = Player.Character
    local H = C and C:FindFirstChildOfClass("Humanoid")
    local R = H and H.RootPart
    local TC = T.Character
    local TH = TC and TC:FindFirstChildOfClass("Humanoid")
    local TR = TH and TH.RootPart
    local THead = TC and TC:FindFirstChild("Head")
    local A = TC and TC:FindFirstChildOfClass("Accessory")
    local Handle = A and A:FindFirstChild("Handle")
    
    if not C or not H or not R or not TC or not TH or not TR then
        return
    end

    if R.Velocity.Magnitude < 50 then
        OX = R.CFrame
    end

    if TH.Sit then
        return
    end

    if THead then
        ws.CurrentCamera.CameraSubject = THead
    elseif not THead and Handle then
        ws.CurrentCamera.CameraSubject = Handle
    else
        ws.CurrentCamera.CameraSubject = TH
    end

    if not TC:FindFirstChildWhichIsA("BasePart") then
        return
    end

    local function FPos(BP, Pos, Ang)
        R.CFrame = CFrame.new(BP.Position) * Pos * Ang
        C:SetPrimaryPartCFrame(CFrame.new(BP.Position) * Pos * Ang)
        R.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
        R.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end

    local function SFBasePart(BP)
        local Time = tick()
        local Angle = 0
        repeat
            if R and TH then
                if BP.Velocity.Magnitude < 50 then
                    Angle = Angle + 100
                    FPos(BP, CFrame.new(0, 1.5, 0) + TH.MoveDirection * BP.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0) + TH.MoveDirection * BP.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(2.25, 1.5, -2.25) + TH.MoveDirection * BP.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(-2.25, -1.5, 2.25) + TH.MoveDirection * BP.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, 1.5, 0) + TH.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0) + TH.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                else
                    FPos(BP, CFrame.new(0, 1.5, TH.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, -TH.WalkSpeed), CFrame.Angles(0, 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, 1.5, TH.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, 1.5, TR.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, -TR.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, 1.5, TR.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                    task.wait()
                    FPos(BP, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                    task.wait()
                end
            else
                break
            end
        until BP.Velocity.Magnitude > 500 or BP.Parent ~= T.Character or T.Parent ~= Players or not T.Character == TC or TH.Sit or H.Health <= 0 or tick() > Time + 2
    end

    ws.FallenPartsDestroyHeight = 0/0
    
    local B = Instance.new("BodyVelocity")
    B.Name = "EpixVel"
    B.Parent = R
    B.Velocity = Vector3.new(9e8, 9e8, 9e8)
    B.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    
    H:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    if TR and THead then
        if (TR.CFrame.p - THead.CFrame.p).Magnitude > 5 then
            SFBasePart(THead)
        else
            SFBasePart(TR)
        end
    elseif TR and not THead then
        SFBasePart(TR)
    elseif not TR and THead then
        SFBasePart(THead)
    elseif not TR and not THead and A and Handle then
        SFBasePart(Handle)
    else
        return
    end

    B:Destroy()
    H:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    ws.CurrentCamera.CameraSubject = H

    repeat
        R.CFrame = OX * CFrame.new(0, .5, 0)
        C:SetPrimaryPartCFrame(OX * CFrame.new(0, .5, 0))
        H:ChangeState("GettingUp")
        table.foreach(C:GetChildren(), function(_, x)
            if x:IsA("BasePart") then
                x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
            end
        end)
        task.wait()
    until (R.Position - OX.p).Magnitude < 25

    ws.FallenPartsDestroyHeight = WD
end

return JustFling
