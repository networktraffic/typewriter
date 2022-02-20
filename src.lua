local render_stepped = game:GetService( 'RunService' ).RenderStepped
local handler_interface = Instance.new('ScreenGui', gethui and gethui( ) or game:GetService( 'Players' ).LocalPlayer:WaitForChild( 'PlayerGui' ))
local container = Instance.new( 'Frame', handler_interface )
local layout = Instance.new( 'UIListLayout', container )
local padding = Instance.new( 'UIPadding', container )
local text_object = Instance.new( 'TextLabel', container )

handler_interface.Name = math.random( )
handler_interface.ResetOnSpawn = false

container.Name = math.random( )
container.AnchorPoint = Vector2.new( 0.5, 0.5 )
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.Position = UDim2.new( 0.5, 0, 0.5, 0 )
container.Size = UDim2.new( 1, 0, 1, 0 )

layout.Name = math.random( )
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
layout.Padding = UDim.new( 0, 5 )

padding.Name = math.random( )
padding.PaddingBottom = UDim.new( 0.25, 0 )
padding.PaddingLeft = UDim.new( 0.25, 0 )
padding.PaddingRight = UDim.new( 0.25, 0 )
padding.PaddingTop = UDim.new( 0.25, 0 )

text_object.Name = math.random( )
text_object.AnchorPoint = Vector2.new( 0.5, 0.5 )
text_object.BackgroundTransparency = 1
text_object.BorderSizePixel = 0
text_object.Position = UDim2.new( 0.5, 0, 0.5, 0 )
text_object.Size = UDim2.new( 1, 0, 0, text_object.TextBounds.Y )
text_object.Font = Enum.Font.Gotham
text_object.TextColor3 = Color3.new( 1, 1, 1 )
text_object.TextSize = 20
text_object.TextStrokeTransparency = 0.5

local job_queue, connection = { }, nil
do
    local function on_render_stepped( )
        local index = 0
        local current_job = job_queue[ 1 ]

        if current_job then
            connection:Disconnect( )

            local text = current_job[ 1 ]
            local time_alive = current_job[ 2 ]
            local type_speed = current_job[ 3 ]

            if text and time_alive and type_speed then
                text_object.Text = text
                text = string.gsub( text, '<br%s*/>', '\n' )
                text = string.gsub( text, '<[^<>]->', '' )

                for _ in utf8.graphemes( text ) do
                    index += 1
                    text_object.MaxVisibleGraphemes = index
                    task.wait( type_speed )
                end

                warn(tostring(index))
                task.wait( time_alive )

                for _ in utf8.graphemes( text ) do
                    index -= 1
                    text_object.MaxVisibleGraphemes = index
                    task.wait( type_speed )
                end

                print(tostring(index))
                index = 0
                text_object.Text = ''

                table.remove( job_queue, 1 )
                render_stepped:Connect( on_render_stepped )
            end
        end
    end

    connection = render_stepped:Connect( on_render_stepped )
end

return function( text, time_alive, type_speed )
    table.insert( job_queue, { text, time_alive, type_speed } )
end
