local Framework = require(script.Parent.Parent.Packages.Framework)
local InsertIcon = require(script.Parent.Parent.Lib.InsertIcon)
local Tooltip = require(script.Parent.Tooltip)
local Mode = Framework.Mode
local Create = Framework.Create

function IconItem(props)
    return Framework.CreateElement('ImageButton', {
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
            BackgroundColor3 = Framework.GetStore('HoverBackground'),
        },
        [Mode 'Active'] = {
            BackgroundTransparency = 0,
            BackgroundColor3 = Framework.GetStore('ButtonActive'),
        },
    }, {
        Create(Tooltip) {
            Label = Framework.Requires(
                Framework.GetStore('IconData'),
                function(data)
                    local desc: string = data[props.Name].description
                    return string.format(
                        '<b>%s</b>%s%s',
                        props.Name,
                        (desc and desc ~= '') and '<br/>' or '',
                        desc:sub(1, 30) .. (#desc > 30 and '...' or '')
                    )
                end
            ),
        },
        Create 'ImageLabel' {
            Size = 24,
            AnchorPoint = { 0.5, 0.5 },
            Position = 0.5,
            Image = `rbxassetid://{props.ImageId}`,
            ImageColor3 = Framework.GetStore('TextColor'),
        },
        Create 'UIStroke' { Color = Framework.GetStore('ButtonBackground') },
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
