local Framework = require(script.Parent.Parent.Packages.Framework)
local Tooltip = require(script.Parent.Tooltip)
local Create = Framework.Create
local Mode = Framework.Mode

type Props = { Icon: number | string, Tooltip: string?, Activated: (...any) -> () }

function IconButton(props: Props): Instance
    return Framework.CreateElement('ImageButton', {
        Name = 'IconButton',
        ImageTransparency = 1,
        BackgroundTransparency = 0,
        BackgroundColor3 = Framework.GetStore('ButtonBackground'),
        AutoButtonColor = false,
        Size = { 0, 32, 0, 32 },
        Activated = props.Activated,
        [Mode 'Hover'] = {
            BackgroundColor3 = Framework.GetStore('HoverBackground'),
        },
        [Mode 'Active'] = {
            BackgroundColor3 = Framework.GetStore('ButtonActive'),
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
            ImageColor3 = Framework.GetStore('TextColor'),
            Active = false,
        },
        Create 'UICorner' { CornerRadius = { 0, 8 } },
    })
end

return IconButton
