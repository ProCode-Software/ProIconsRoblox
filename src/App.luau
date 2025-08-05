local Forge = require(script.Parent.Packages.Forge)
local Create = Forge.Create
local CategorySelection = require(script.Parent.Components.CategorySelection)
local Header = require(script.Parent.Components.Header)
local IconsGrid = require(script.Parent.Components.IconsGrid)

-- The icon picker interface
function App()
    return Forge.CreateElement('Frame', {
        Name = 'App',
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Forge.GetStore('BackgroundColor'),
        BackgroundTransparency = 0,
    }, {
        Create(Header) {},
        Create(CategorySelection) {},
        Create(IconsGrid) {},

        Create 'UIListLayout' {
            FillDirection = 'Vertical',
            Padding = { 0, 8 },
        },
        Create 'UIPadding' {
            PaddingBottom = { 0, 8 },
            PaddingLeft = { 0, 8 },
            PaddingRight = { 0, 8 },
            PaddingTop = { 0, 8 },
        },
    })
end

return App
