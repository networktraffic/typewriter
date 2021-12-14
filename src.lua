local CoreGui = game:GetService("CoreGui")

local TypeWriter = Instance.new("ScreenGui")
local Container = Instance.new("Frame")
local ListLayout = Instance.new("UIListLayout")
local Padding = Instance.new("UIPadding")
local Msg = Instance.new("TextLabel")

TypeWriter.Name = "TypeWriter"
TypeWriter.Parent = CoreGui
TypeWriter.ResetOnSpawn = false

Container.Name = "Container"
Container.Parent = TypeWriter
Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 1.000
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.Size = UDim2.new(1, 0, 1, 0)

ListLayout.Name = "ListLayout"
ListLayout.Parent = Container
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
ListLayout.Padding = UDim.new(0, 5)

Padding.Name = "Padding"
Padding.Parent = Container
Padding.PaddingBottom = UDim.new(0.25, 0)
Padding.PaddingLeft = UDim.new(0.25, 0)
Padding.PaddingRight = UDim.new(0.25, 0)
Padding.PaddingTop = UDim.new(0.25, 0)

Msg.Name = "Msg"
Msg.Parent = Container
Msg.AnchorPoint = Vector2.new(0.5, 0.5)
Msg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Msg.BackgroundTransparency = 1.000
Msg.BorderColor3 = Color3.fromRGB(0, 0, 0)
Msg.BorderSizePixel = 0
Msg.Position = UDim2.new(0.5, 0, 0.5, 0)
Msg.Size = UDim2.new(1, 0, 0, Msg.TextBounds.Y)
Msg.Font = Enum.Font.Gotham
Msg.TextColor3 = Color3.fromRGB(255, 255, 255)
Msg.TextSize = 20.000
Msg.TextStrokeTransparency = 0.500

return function(Text, Expiration)
	Msg.Text = Text 
	
	local Idx = 0
	local DisplayText = Text
	
	DisplayText = string.gsub(DisplayText, "<br%s*/>", "\n")
	DisplayText = string.gsub(DisplayText, "<[^<>]->", "")
	
	for _ in utf8.graphemes(DisplayText) do
		Idx += 1
		Msg.MaxVisibleGraphemes = Idx
		wait(0.005)
	end
	
	task.wait(Expiration)
	
	for _ in utf8.graphemes(DisplayText) do
		Idx -= 1
		Msg.MaxVisibleGraphemes = Idx
		wait(0.005)
	end
	
	Msg:Destroy()
end
