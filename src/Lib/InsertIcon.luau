local ChangeHistoryService = game:GetService('ChangeHistoryService')
local Selection = game:GetService('Selection')
local Icon = {}

function Icon:Insert(name: string, imageId: string)
    imageId = `rbxassetid://{imageId}`
    local sel = Selection:Get()
    local rec = ChangeHistoryService:TryBeginRecording(`Insert {name} icon`)
    if not rec then return end
    for _, item in sel do
        if item:IsA('Decal') or item:IsA('Texture') then
            item.Texture = imageId
        elseif item:IsA('ImageButton') or item:IsA('ImageLabel') then
            item.Image = imageId
        elseif item:IsA('GuiBase') then
            local img = Instance.new('ImageLabel')
            img.Name = name
            img.Image = imageId
            img:AddTag('ProIcon')
            img.Parent = item
            img.Size = UDim2.fromOffset(100, 100)
            Selection:Set({ img })
        elseif
            item:FindFirstChildWhichIsA('Decal')
            or item:FindFirstChildWhichIsA('Texture')
        then
            (item:FindFirstChildWhichIsA('Decal') or item:FindFirstChildWhichIsA(
                'Texture'
            )).Texture =
                imageId
        else
            local decal = Instance.new('Decal')
            decal.Name = name
            decal:AddTag('ProIcon')
            decal.Texture = imageId
            decal.Parent = item
            Selection:Set({ decal })
        end
    end
    ChangeHistoryService:FinishRecording(rec, 'Commit')
end

return Icon
