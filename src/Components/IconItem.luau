local Forge = require(script.Parent.Parent.Packages.Forge)
local InsertIcon = require(script.Parent.Parent.Lib.InsertIcon)
local Tooltip = require(script.Parent.Tooltip)
local Mode = Forge.Mode
local Create = Forge.Create

function IconItem(props)
    return Forge.CreateElement('ImageButton', {
        Name = props.Name,
        Size = { 1, 1 },
        ImageTransparency = 1,
        AutoButtonColor = false,
        Activated = function()
            print(`Insert {props.Name}`)
            InsertIcon:Insert(props.Name, props.ImageId)
        end,
        [Mode 'Hover'] = {
            BackgroundTransparency = 0,
            BackgroundColor3 = Forge.GetStore('HoverBackground'),
        },
        [Mode 'Active'] = {
            BackgroundTransparency = 0,
            BackgroundColor3 = Forge.GetStore('ButtonActive'),
        },
    }, {
        Create(Tooltip) {
            Label = Forge.Requires(Forge.GetStore('IconData'), function(data)
                local desc: string = data[props.Name].description
                return string.format(
                    '<b>%s</b>%s%s',
                    props.Name,
                    (desc and desc ~= '') and '<br/>' or '',
                    desc:sub(1, 30) .. (#desc > 30 and '...' or '')
                )
            end),
        },
        Create 'ImageLabel' {
            Size = 24,
            AnchorPoint = { 0.5, 0.5 },
            Position = 0.5,
            Image = `rbxassetid://{props.ImageId}`,
            ImageColor3 = Forge.GetStore('TextColor'),
        },
        Create 'UIStroke' { Color = Forge.GetStore('ButtonBackground') },
        Create 'UICorner' { CornerRadius = { 0, 8 } },
        Create 'UIAspectRatioConstraint' {},
        Create 'UIPadding' {
            PaddingBottom = { 0, 8 },
            PaddingLeft = { 0, 8 },
            PaddingRight = { 0, 8 },
            PaddingTop = { 0, 8 },
        },
    })
end

return IconItem
