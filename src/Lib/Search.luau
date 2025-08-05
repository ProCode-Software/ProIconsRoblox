local Framework = require(script.Parent.Parent.Packages.Framework)

function Matches(iconName: string, query: string): boolean
    local rawName = iconName
    iconName = iconName:lower()
    query = query:lower()

    local iconData = Framework.GetStore('IconData').Value
    local categories = Framework.GetStore('Category').Value
    -- Framework.GetStore('IconData').Value[props.Name].category == cat

    local desc = iconData[rawName].description:lower()
    local tries = {
        iconName,
        iconName:gsub(' ', ''),
        iconName:gsub(' ', '-'),
        iconName:gsub(' ', '_'),
        iconName:gsub('-', ' '),
        desc:gsub(' ', ''),
        desc:gsub(' ', '-'),
        desc:gsub(' ', '_'),
        desc:gsub('-', ' '),
        nil,
    }
    local match = 0
    for _, try: string in tries do
        if query and query ~= '' then match = try:find(query) end
    end
    local catMatch = 0
    if categories and #categories > 0 then
        catMatch = table.find(categories, iconData[rawName].category)
    end
    return (match ~= nil and catMatch ~= nil)
end

return Matches
