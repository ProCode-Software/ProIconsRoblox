local Forge = require(script.Parent.Parent.Packages.Forge)
local Mode = Forge.Mode
local Create = Forge.Create

function CategoryChip(props)
    local name = props.Name
    local isIncluded = Forge.Derived(
        Forge.GetStore('Category'),
        function(c: { string })
            return table.find(c or {}, name) ~= nil
        end
    )
    return Forge.CreateElement('TextButton', {
        BackgroundColor3 = Forge.GetStore('ButtonBackground'),
        TextColor3 = Forge.GetStore('TextColor2'),
        Text = name,
        AutomaticSize = 'XY',
        Size = 0,
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        Activated = function()
            local currCats = Forge.GetStore('Category').Value or {}
            local inArray = table.find(currCats, name)
            if inArray then
                table.remove(currCats, inArray)
            else
                table.insert(currCats, name)
            end
            Forge.SetStore('Category', currCats)
        end,
        [Mode 'Hover'] = {
            BackgroundColor3 = Forge.GetStore('HoverBackground'),
        },
        [Mode 'Active'] = {
            BackgroundColor3 = Forge.GetStore('ButtonActive'),
        },
    }, {
        Create 'UIStroke' {
            ApplyStrokeMode = 'Border',
            Color = Forge.GetStore('Accent'),
            Thickness = 1,
            Enabled = isIncluded,
        },
        Create 'UICorner' {
            CornerRadius = { 0, 8 },
        },
        Create 'UIPadding' {
            PaddingBottom = { 0, 5 },
            PaddingLeft = { 0, 8 },
            PaddingRight = { 0, 8 },
            PaddingTop = { 0, 5 },
        },
    })
end

function CategorySelection()
    local element = Forge.CreateElement(
        'ScrollingFrame',
        {
            ScrollingDirection = 'X',
            Size = { 1, 0, 0, 0 },
            AutomaticSize = 'Y',
            Name = 'Categories',
            ScrollBarThickness = 0,
            ClipsDescendants = false,
        },
        Create 'UIListLayout' {
            FillDirection = 'Horizontal',
            Padding = { 0, 5 },
        }
    )
    while not Forge.GetStore('Icons').Value do
        task.wait(0.3)
    end
    for _, category in Forge.GetStore('Categories').Value do
        Create(CategoryChip) { Name = category, Parent = element }
    end
    return element
end

return CategorySelection
