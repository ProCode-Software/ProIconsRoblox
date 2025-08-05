local Forge = require(script.Parent.Parent.Packages.Forge)
local Tooltip = require(script.Parent.Tooltip)
local Create = Forge.Create
local Mode = Forge.Mode

type Props = { Icon: number | string, Tooltip: string?, Activated: (...any) -> () }

function IconButton(props: Props): Instance
    return Forge.CreateElement('ImageButton', {
        Name = 'IconButton',
        ImageTransparency = 1,
        BackgroundTransparency = 0,
        BackgroundColor3 = Forge.GetStore('ButtonBackground'),
        AutoButtonColor = false,
        Size = { 0, 32, 0, 32 },
        Activated = props.Activated,
        [Mode 'Hover'] = {
            BackgroundColor3 = Forge.GetStore('HoverBackground'),
        },
        [Mode 'Active'] = {
            BackgroundColor3 = Forge.GetStore('ButtonActive'),
        },
    }, {
        (props.Tooltip and props.Tooltip ~= '') and {
            Create(Tooltip) { Label = props.Tooltip },
        } or nil,
        Create 'ImageLabel' {
            Size = { 0, 20, 0, 20 },
            Image = `rbxassetid://{props.Icon}`,
            AnchorPoint = { 0.5, 0.5 },
            Position = { 0.5, 0, 0.5, 0 },
            ImageColor3 = Forge.GetStore('TextColor'),
            Active = false,
        },
        Create 'UICorner' { CornerRadius = { 0, 8 } },
    })
end

return IconButton
