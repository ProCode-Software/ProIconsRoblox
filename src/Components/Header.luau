local Framework = require(script.Parent.Parent.Packages.Framework)
local IconButton = require(script.Parent.IconButton)
local SearchBar = require(script.Parent.SearchBar)
local Create = Framework.Create

function Header()
    return Framework.CreateElement('Frame', {
        Name = 'Header',
        Size = { 1, 0, 0, 0 },
        AutomaticSize = 'Y',
    }, {
        Create(SearchBar) {},
        Create(IconButton) {
            Tooltip = 'Toggle List/Grid View',
            Icon = '121218042712173',
            Activated = function()
                local slv = Framework.GetStore('ShowListView')
                slv:Set(not slv.Value)
            end,
        },

        Create 'UIListLayout' {
            FillDirection = 'Horizontal',
            VerticalAlignment = 'Center',
            Padding = { 0, 5 },
        },
    })
end

return Header
