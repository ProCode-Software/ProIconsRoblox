local HttpService = game:GetService('HttpService')
local Forge = require(script.Parent.Parent.Packages.Forge)

local PROICONS_URL =
    'https://raw.githubusercontent.com/ProCode-Software/proicons/main/icons/roblox.json'
local ICON_DATA_URL =
    'https://raw.githubusercontent.com/ProCode-Software/proicons/main/icons/icons.json'

local success, icons = pcall(function()
    return HttpService:JSONDecode(HttpService:GetAsync(PROICONS_URL)).assetPaths
end)

local success2, iconData = pcall(function()
    return HttpService:JSONDecode(HttpService:GetAsync(ICON_DATA_URL))
end)

if not (success or success2) then error('Unable to fetch icons') end

local categoriesSet = {}
local categories: { string } = {}
for _, data in pairs(iconData) do
    categoriesSet[data.category] = true
end
for category in pairs(categoriesSet) do
    table.insert(categories, category)
end
table.sort(categories)

Forge.SetStore('IconData', iconData)
Forge.SetStore('Categories', categories)
Forge.SetStore('Icons', icons)
