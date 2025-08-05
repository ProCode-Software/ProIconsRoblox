local Framework = require(script.Parent.Parent.Packages.Framework)
local ThemeColors = require(script.Parent.ThemeColors)

function syncColors()
    local theme: StudioTheme = settings().Studio.Theme
    local themeName = theme:GetFullName()
    Framework.SetStore(
        'BackgroundColor',
        theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
    )
    Framework.SetStore(
        'TextColor',
        theme:GetColor(Enum.StudioStyleGuideColor.MainText)
    )
    Framework.SetStore(
        'ButtonColor',
        theme:GetColor(Enum.StudioStyleGuideColor.MainButton)
    )
    Framework.SetStore('Theme', themeName)

    for key: string in pairs(ThemeColors.Light) do
        Framework.SetStore(key, ThemeColors[themeName][key])
    end
end

syncColors()
settings().Studio.ThemeChanged:Connect(syncColors)
