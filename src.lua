local handler_interface = Instance.new('ScreenGui', gethui and gethui( ) or game:GetService( 'Players' ).LocalPlayer:WaitForChild( 'PlayerGui' ))
local container = Instance.new( 'Frame', handler_interface )
local layout = Instance.new( 'UIListLayout', container )
local padding = Instance.new( 'UIPadding', container )
local text_obj = Instance.new( 'TextLabel', container )
local render_stepped = game:GetService( 'RunService' ).RenderStepped

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

text_obj.Name = math.random( )
text_obj.AnchorPoint = Vector2.new( 0.5, 0.5 )
text_obj.BackgroundTransparency = 1
text_obj.BorderSizePixel = 0
text_obj.Position = UDim2.new( 0.5, 0, 0.5, 0 )
text_obj.Size = UDim2.new( 1, 0, 0, text_obj.TextBounds.Y )
text_obj.Font = Enum.Font.Gotham
text_obj.TextColor3 = Color3.new( 1, 1, 1 )
text_obj.TextSize = 20
text_obj.TextStrokeTransparency = 0.5

local job_queue, conn = { }, nil
do
    local function on_render_stepped( )
        local idx = 0
        local current_job = job_queue[ 1 ]

        if current_job then
            conn:Disconnect( )

            local text = current_job[ 1 ]
            local time_alive = current_job[ 2 ]
            local type_speed = current_job[ 3 ]

            if text and time_alive and type_speed then
                text_obj.Text = text
                text = string.gsub( text, '<br%s*/>', '\n' )
                text = string.gsub( text, '<[^<>]->', '' )

                for _ in utf8.graphemes( text ) do
                    idx += 1
                    text_obj.MaxVisibleGraphemes = idx
                    task.wait( type_speed )
                end

                task.wait( time_alive )

                for _ in utf8.graphemes( text ) do
                    idx -= 1
                    text_obj.MaxVisibleGraphemes = idx
                    task.wait( type_speed )
                end
                
                table.remove( job_queue, 1 )
                conn = render_stepped:Connect( on_render_stepped )
            end
        end
    end

    conn = render_stepped:Connect( on_render_stepped )
end

return function( text, time_alive, type_speed )
    table.insert( job_queue, { text, time_alive, type_speed } )
end
