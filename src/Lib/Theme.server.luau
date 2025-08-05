local Forge = require(script.Parent.Parent.Packages.Forge)
local ThemeColors = require(script.Parent.ThemeColors)

function syncColors()
    local theme: StudioTheme = settings().Studio.Theme
    local themeName = theme:GetFullName()
    Forge.SetStore(
        'BackgroundColor',
        theme:GetColor(Enum.StudioStyleGuideColor.MainBackground)
    )
    Forge.SetStore('TextColor', theme:GetColor(Enum.StudioStyleGuideColor.MainText))
    Forge.SetStore(
        'ButtonColor',
        theme:GetColor(Enum.StudioStyleGuideColor.MainButton)
    )
    Forge.SetStore('Theme', themeName)

    for key: string in pairs(ThemeColors.Light) do
        Forge.SetStore(key, ThemeColors[themeName][key])
    end
end

syncColors()
settings().Studio.ThemeChanged:Connect(syncColors)
