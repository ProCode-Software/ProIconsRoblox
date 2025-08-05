local Framework = require(script.Parent.Parent.Packages.Framework)
local Create = Framework.Create

function SearchBar()
    local isFocused = Framework.CreateState(false)
    local textBox = Framework.CreateElement('TextBox', {
        PlaceholderText = 'Search icons',
        Size = { 1, 0, 1, 0 },
        TextColor3 = Framework.GetStore('TextColor'),
        Text = Framework.Bind(Framework.GetStore('Query')),
        ClearTextOnFocus = false,
    }, { Create 'UIFlexItem' { FlexMode = 'Fill' } })
    textBox.Focused:Connect(function()
        isFocused:Set(true)
    end)
    textBox.FocusLost:Connect(function()
        isFocused:Set(false)
    end)

    return Framework.CreateElement('Frame', {
        Name = 'SearchBar',
        Size = { 1, 0, 0, 32 },
        BackgroundColor3 = Framework.GetStore('ButtonBackground'),
        BackgroundTransparency = 0,
    }, {
        Create 'ImageLabel' {
            Image = 'rbxassetid://92021908612273',
            ImageColor3 = Framework.GetStore('TextColor'),
            Size = { 0, 20, 0, 20 },
        },
        textBox,
        Create 'UIListLayout' {
            FillDirection = 'Horizontal',
            VerticalAlignment = 'Center',
            Padding = { 0, 5 },
        },
        Create 'UIPadding' {
            PaddingBottom = { 0, 8 },
            PaddingLeft = { 0, 5 },
            PaddingRight = { 0, 5 },
            PaddingTop = { 0, 8 },
        },
        Create 'UIStroke' {
            ApplyStrokeMode = 'Border',
            Color = Framework.GetStore('Accent'),
            Thickness = 1.5,
            Enabled = isFocused,
        },
        Create 'UICorner' { CornerRadius = { 0, 8 } },
        Create 'UIFlexItem' { FlexMode = 'Fill' },
    })
end

return SearchBar
