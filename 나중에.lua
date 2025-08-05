local function _0xF(__P)
    local _a=Player.Character
    local _b=_a and _a:FindFirstChildOfClass("Humanoid")
    local _c=_b and _b.RootPart
    local _d=__P.Character
    local _e=_d and _d:FindFirstChildOfClass("Humanoid")
    local _f=_e and _e.RootPart
    local _g=_d and _d:FindFirstChild("Head")
    local _h=_d and _d:FindFirstChildOfClass("Accessory")
    local _i=_h and _h:FindFirstChild("Handle")
    local __Old
    local __F=workspace.FallenPartsDestroyHeight
    if not(_a and _b and _c and _d and _e and _f)then return end
    if _c.Velocity.Magnitude<50 then __Old=_c.CFrame end
    if _e.Sit then return end
    workspace.CurrentCamera.CameraSubject=_g or _i or _e
    if not _d:FindFirstChildWhichIsA("BasePart")then return end
    local function _pos(B,P,A)
        _c.CFrame=CFrame.new(B.Position)*P*A
        _a:SetPrimaryPartCFrame(CFrame.new(B.Position)*P*A)
        _c.Velocity=Vector3.new(9e7,9e7*10,9e7)
        _c.RotVelocity=Vector3.new(9e8,9e8,9e8)
    end
    local function _spin(B)
        local T=tick()
        local ang=0
        repeat
            if _c and _e then
                if B.Velocity.Magnitude<50 then
                    ang=ang+100
                    _pos(B,CFrame.new(0,1.5,0)+_e.MoveDirection*B.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(ang),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,0)+_e.MoveDirection*B.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(ang),0,0))
                    task.wait()
                    _pos(B,CFrame.new(2.25,1.5,-2.25)+_e.MoveDirection*B.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(ang),0,0))
                    task.wait()
                    _pos(B,CFrame.new(-2.25,-1.5,2.25)+_e.MoveDirection*B.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(ang),0,0))
                    task.wait()
                else
                    _pos(B,CFrame.new(0,1.5,_e.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,-_e.WalkSpeed),CFrame.Angles(0,0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,1.5,_e.WalkSpeed),CFrame.Angles(math.rad(90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,1.5,_f.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,-_f.Velocity.Magnitude/1.25),CFrame.Angles(0,0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,1.5,_f.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))
                    task.wait()
                    _pos(B,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))
                    task.wait()
                end
            else break end
        until B.Velocity.Magnitude>500
          or B.Parent~=__P.Character
          or __P.Parent~=Players
          or not(__P.Character==_d)
          or _e.Sit
          or _b.Health<=0
          or tick()>T+2
    end
    workspace.FallenPartsDestroyHeight=0/0
    local bv=Instance.new("BodyVelocity")
    bv.Name="EpixVel"
    bv.Parent=_c
    bv.Velocity=Vector3.new(9e8,9e8,9e8)
    bv.MaxForce=Vector3.new(1/0,1/0,1/0)
    _b:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
    if _f and _g then
        if (_f.CFrame.p-_g.CFrame.p).Magnitude>5 then
            _spin(_g)
        else
            _spin(_f)
        end
    elseif _f and not _g then
        _spin(_f)
    elseif not _f and _g then
        _spin(_g)
    elseif not _f and not _g and _h and _i then
        _spin(_i)
    else return end
    bv:Destroy()
    _b:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
    workspace.CurrentCamera.CameraSubject=_b
    repeat
        _c.CFrame=__Old*CFrame.new(0,.5,0)
        _a:SetPrimaryPartCFrame(__Old*CFrame.new(0,.5,0))
        _b:ChangeState("GettingUp")
        for _,x in pairs(_a:GetChildren()) do
            if x:IsA("BasePart") then
                x.Velocity,x.RotVelocity=Vector3.new(),Vector3.new()
            end
        end
        task.wait()
    until (_c.Position-__Old.p).Magnitude<25
    workspace.FallenPartsDestroyHeight=__F
end
return _0xF
