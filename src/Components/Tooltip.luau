local Framework = require(script.Parent.Parent.Packages.Framework)
local Create = Framework.Create

function Tooltip(props: { Label: string })
    local tooltip: TextLabel = Framework.CreateElement('TextLabel', {
        Text = props.Label,
        Visible = false,
        Name = 'Tooltip',
        ZIndex = 5,
        BackgroundColor3 = Framework.GetStore('Shadow'),
        Size = 0,
        AutomaticSize = 'XY',
        TextColor3 = Framework.GetStore('BackgroundColor'),
        Font = Enum.Font.BuilderSans,
        AnchorPoint = { 0.5, 0 },
        Position = { 0.5, 0, 1, 10 },
        RichText = true,
    }, {
        Create 'UICorner' { CornerRadius = { 0, 8 } },
        Create 'UIPadding' {
            PaddingBottom = { 0, 5 },
            PaddingLeft = { 0, 8 },
            PaddingRight = { 0, 8 },
            PaddingTop = { 0, 5 },
        },
        Create 'UIStroke' {
            ApplyStrokeMode = 'Border',
            Color = Framework.GetStore('Shadow'),
            Thickness = 2,
            Transparency = 0.9,
        },
    })
    tooltip.AncestryChanged:Connect(function()
        if tooltip.Parent ~= nil then
            (tooltip :: TextLabel).Parent
                :GetPropertyChangedSignal('GuiState')
                :Connect(function()
                    if tooltip.Parent.GuiState == Enum.GuiState.Hover then
                        task.wait(1)
                    end
                    tooltip.Visible = (tooltip.Parent :: GuiObject).GuiState
                        == Enum.GuiState.Hover
                end)
        end
    end)
    return tooltip
end
return Tooltip
