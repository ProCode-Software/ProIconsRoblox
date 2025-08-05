local Forge = require(script.Parent.Parent.Packages.Forge)
local Create = Forge.Create

function SearchBar()
    local isFocused = Forge.CreateState(false)
    local textBox = Forge.CreateElement('TextBox', {
        PlaceholderText = 'Search icons',
        Size = { 1, 0, 1, 0 },
        TextColor3 = Forge.GetStore('TextColor'),
        Text = Forge.Bind(Forge.GetStore('Query')),
        ClearTextOnFocus = false,
    }, { Create 'UIFlexItem' { FlexMode = 'Fill' } })
    textBox.Focused:Connect(function()
        isFocused:Set(true)
    end)
    textBox.FocusLost:Connect(function()
        isFocused:Set(false)
    end)

    return Forge.CreateElement('Frame', {
        Name = 'SearchBar',
        Size = { 1, 0, 0, 32 },
        BackgroundColor3 = Forge.GetStore('ButtonBackground'),
        BackgroundTransparency = 0,
    }, {
        Create 'ImageLabel' {
            Image = 'rbxassetid://92021908612273',
            ImageColor3 = Forge.GetStore('TextColor'),
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
            Color = Forge.GetStore('Accent'),
            Thickness = 1.5,
            Enabled = isFocused,
        },
        Create 'UICorner' { CornerRadius = { 0, 8 } },
        Create 'UIFlexItem' { FlexMode = 'Fill' },
    })
end

return SearchBar
