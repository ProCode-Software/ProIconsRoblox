--!strict
local Framework = require(script.Parent.Parent.Packages.Framework)
local IconItem = require(script.Parent.IconItem)
local Matches = require(script.Parent.Parent.Lib.Search)
local Create = Framework.Create

function IconsGrid()
    local element = Framework.CreateElement('ScrollingFrame', {
        Name = 'Icons',
        Size = { 1, 1 },
        ScrollBarThickness = 8,
        ScrollBarImageColor3 = Framework.GetStore('ButtonBackground'),
        ClipDescendants = false,
    }, {
        Create 'UIGridLayout' {
            FillDirection = 'Horizontal',
            CellSize = 48,
            SortOrder = 'Name',
            CellPadding = 8,
        },
        Create 'UIPadding' {
            PaddingBottom = { 0, 1 },
            PaddingLeft = { 0, 1 },
            PaddingRight = { 0, 1 },
            PaddingTop = { 0, 1 },
        },
        Create 'UIFlexItem' { FlexMode = 'Fill' },
    }) :: ScrollingFrame
    while not Framework.GetStore('Icons').Value do
        task.wait(0.3)
    end
    for name, id in pairs(Framework.GetStore('Icons').Value) do
        Create(IconItem) { Name = name, ImageId = id, Parent = element }
    end
    local nr = Framework.CreateElement(NoResults) :: TextLabel
    element.AncestryChanged:Connect(function()
        nr.Parent = element.Parent
        nr.LayoutOrder = element.LayoutOrder
    end)
    Framework.GetStore('Category'):Subscribe(function(cs: { string })
        for _, item: ImageButton in element:GetChildren() do
            if item:IsA('ImageButton') then
                local match = Matches(
                    item.Name,
                    (Framework.GetStore('Query').Value :: string?) or ''
                )
                item.Visible = match
            end
        end
    end)
    Framework.GetStore('Query'):Subscribe(function(query: string)
        local hasResults = false
        for _, item: ImageButton in element:GetChildren() do
            if item:IsA('ImageButton') then
                local match = Matches(item.Name, query)
                item.Visible = match
                if match then hasResults = true end
            end
        end
        element.Visible = hasResults
        nr.Visible = not hasResults
    end)

    return element
end

function NoResults()
    return Create 'TextLabel' {
        Visible = false,
        AutomaticSize = 'Y',
        TextColor3 = Framework.GetStore('TextColor2'),
        Size = 1,
        TextSize = 18,
        TextWrapped = true,
        Name = 'NoResults',
        TextXAlignment = 'Center',
        RichText = true,
        Text = Framework.Derived(Framework.GetStore('Query'), function(q)
            return `No results for <b>'{q}'</b>`
        end),
        Children = Create 'UIFlexItem' { FlexMode = 'Fill' },
    }
end

return IconsGrid
