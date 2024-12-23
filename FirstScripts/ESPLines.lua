local a = game:GetService("Players")
local b = game:GetService("RunService")
local c = a.LocalPlayer
local d = workspace.CurrentCamera
local e = {}
local f = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "LowerTorso"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}
local g = {
    BoxOutlineColor = Color3.new(0, 0, 0),
    BoxColor = Color3.new(1, 1, 1),
    NameColor = Color3.new(1, 1, 1),
    HealthOutlineColor = Color3.new(0, 0, 0),
    HealthHighColor = Color3.new(0, 1, 0),
    HealthLowColor = Color3.new(1, 0, 0),
    CharSize = Vector2.new(4, 6),
    Teamcheck = false,
    WallCheck = false,
    Enabled = false,
    ShowBox = false,
    BoxType = "2D",
    ShowName = false,
    ShowHealth = false,
    ShowDistance = false,
    ShowSkeletons = false,
    ShowTracer = false,
    TracerColor = Color3.new(1, 1, 1),
    TracerThickness = 2,
    SkeletonsColor = Color3.new(1, 1, 1),
    TracerPosition = "Bottom"
}
local function h(i, j)
    local k = Drawing.new(i)
    for l, m in pairs(j) do
        k[l] = m
    end
    return k
end
local function n(o)
    local p = {
        tracer = h("Line", {Thickness = g.TracerThickness, Color = g.TracerColor, Transparency = 0.5}),
        boxOutline = h("Square", {Color = g.BoxOutlineColor, Thickness = 3, Filled = false}),
        box = h("Square", {Color = g.BoxColor, Thickness = 1, Filled = false}),
        name = h("Text", {Color = g.NameColor, Outline = true, Center = true, Size = 13}),
        healthOutline = h("Line", {Thickness = 3, Color = g.HealthOutlineColor}),
        health = h("Line", {Thickness = 1}),
        distance = h("Text", {Color = Color3.new(1, 1, 1), Size = 12, Outline = true, Center = true}),
        boxLines = {}
    }
    e[o] = p
    e[o]["skeletonlines"] = {}
end
local function q(o)
    local r = o.Character
    if not r then
        return false
    end
    local s = r:FindFirstChild("HumanoidRootPart")
    if not s then
        return false
    end
    local t = Ray.new(d.CFrame.Position, (s.Position - d.CFrame.Position).Unit * (s.Position - d.CFrame.Position).Magnitude)
    local u, v = workspace:FindPartOnRayWithIgnoreList(t, {c.Character, r})
    return not (u and u:IsA("Part"))
end
local function w(o)
    local p = e[o]
    if not p then
        return
    end
    for x, k in pairs(p) do
        if typeof(k) == "Instance" and k.Remove then
            k:Remove()
        end
    end
    e[o] = nil
end
local function y()
    for o, p in pairs(e) do
        local r, z = o.Character, o.Team
        if r and (not g.Teamcheck or z and z ~= c.Team) then
            local s = r:FindFirstChild("HumanoidRootPart")
            local A = r:FindFirstChild("Head")
            local B = r:FindFirstChild("Humanoid")
            local C = g.WallCheck and q(o)
            local D = not C and g.Enabled
            if s and A and B and D then
                local F, E = d:WorldToViewportPoint(s.Position)
                if E then
                    local G = (d:WorldToViewportPoint(s.Position - Vector3.new(0, 3, 0)).Y - d:WorldToViewportPoint(s.Position + Vector3.new(0, 2.6, 0)).Y) / 2
                    local H = Vector2.new(math.floor(G * 1.8), math.floor(G * 1.9))
                    local I = Vector2.new(math.floor(F.X - G * 1.8 / 2), math.floor(F.Y - G * 1.6 / 2))
                    if g.ShowName then
                        p.name.Visible = true
                        p.name.Text = o.Name:lower()
                        p.name.Position = Vector2.new(H.X / 2 + I.X, I.Y - 16)
                        p.name.Color = g.NameColor
                    else
                        p.name.Visible = false
                    end
                    if g.ShowBox then
                        p.boxOutline.Size = H
                        p.boxOutline.Position = I
                        p.box.Size = H
                        p.box.Position = I
                        p.box.Color = g.BoxColor
                        p.box.Visible = true
                        p.boxOutline.Visible = true
                    else
                        p.box.Visible = false
                        p.boxOutline.Visible = false
                    end
                end
            end
        end
    end
end
b.RenderStepped:Connect(y)
