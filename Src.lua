local HandlerUI = Instance.new("ScreenGui", game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
local Container = Instance.new("Frame", HandlerUI)
local Layout = Instance.new("UIListLayout", Container)
local Padding = Instance.new("UIPadding", Container)
local TextObject = Instance.new("TextLabel", Container)

HandlerUI.Name = tostring(math.random())
HandlerUI.ResetOnSpawn = false

Container.Name = tostring(math.random())
Container.AnchorPoint = Vector2.new(0.5, 0.5)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.Size = UDim2.new(1, 0, 1, 0)

Layout.Name = tostring(math.random())
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
Layout.Padding = UDim.new(0, 5)

Padding.Name = tostring(math.random())
Padding.PaddingBottom = UDim.new(0.25, 0)
Padding.PaddingLeft = UDim.new(0.25, 0)
Padding.PaddingRight = UDim.new(0.25, 0)
Padding.PaddingTop = UDim.new(0.25, 0)

TextObject.Name = tostring(math.random())
TextObject.AnchorPoint = Vector2.new(0.5, 0.5)
TextObject.BackgroundTransparency = 1
TextObject.BorderSizePixel = 0
TextObject.Position = UDim2.new(0.5, 0, 0.5, 0)
TextObject.Size = UDim2.new(1, 0, 0, TextObject.TextBounds.Y)
TextObject.Font = Enum.Font.Gotham
TextObject.TextColor3 = Color3.fromRGB(255, 255, 255)
TextObject.TextSize = 20
TextObject.TextStrokeTransparency = 0.5

local JobQueue, Connection = {}, nil do
    local function OnRenderStepped()
        local Index = 0
        local CurrentJob = JobQueue[1]

        if CurrentJob then
            Connection:Disconnect()
            local Text = CurrentJob[1]
            local TimeAlive = CurrentJob[2]
            local TypeSpeed = CurrentJob[3]

            if Text and TimeAlive and TypeSpeed then
                TextObject.Text = Text
                Text = string.gsub(Text, "<br%s*/>", "\n")
	    	Text = string.gsub(Text, "<[^<>]->", "")

                for _ in utf8.graphemes(Text) do
                    Index += 1
                    TextObject.MaxVisibleGraphemes = Index
                    task.wait(TypeSpeed)
                end

                task.wait(TimeAlive)

                for _ in utf8.graphemes(Text) do
                    Index -= 1
                    TextObject.MaxVisibleGraphemes = Index
                    task.wait(TypeSpeed)
                end

                TextObject.Text = ""
                table.remove(JobQueue, 1)
                Connection = game:GetService("RunService").RenderStepped:Connect(OnRenderStepped)
            end
        end
    end
    
    Connection = game:GetService("RunService").RenderStepped:Connect(OnRenderStepped)
end

return function(Text, TimeAlive, TypeSpeed)
    table.insert(JobQueue, {Text, TimeAlive, TypeSpeed})
end
