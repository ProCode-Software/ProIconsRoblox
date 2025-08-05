local Framework = require(script.Packages.Framework)

local toolbar = plugin:CreateToolbar('ProIcons')
local button = toolbar:CreateButton('ProIcons', 'Launch ProIcons icon picker', '')
local App = require(script.App)

local widgetInfo = DockWidgetPluginGuiInfo.new(
    Enum.InitialDockState.Left,
    false,
    false,
    300,
    300,
    300,
    200
)
local widget = plugin:CreateDockWidgetPluginGui('ProIcons', widgetInfo)
widget.Name = 'ProIcons'
widget.Title = 'ProIcons'

button.Click:Connect(function()
    if plugin:IsActivated() then
        plugin:Deactivate()
        button:SetActive(false)
        widget.Enabled = false
    else
        button:SetActive(true)
        plugin:Activate(true)
        widget.Enabled = true
    end
end)

-- UI --
Framework.CreateElement(App, nil, nil, widget)
