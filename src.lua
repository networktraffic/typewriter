local job_queue = { }
local conn = nil
local render_stepped = game:GetService( 'RunService' ).RenderStepped

local function create( class, parent, props )
	local obj = Instance.new( class, parent )
	
	for idx, prop in pairs( props ) do
		obj[ idx ] = prop
	end
	
	return obj
end

local container = create( 'Frame', create('ScreenGui', gethui and gethui( ) or game:GetService( 'Players' ).LocalPlayer:WaitForChild( 'PlayerGui' ), {
    Name = math.random( ),
    ResetOnSpawn = false
} ), {
    Name = math.random( ),
    AnchorPoint = Vector2.new( 0.5, 0.5 ),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new( 0.5, 0, 0.5, 0 ),
    Size = UDim2.new( 1, 0, 1, 0 )
} )

local text_obj = create( 'TextLabel', container, {
    Name = math.random( ),
    AnchorPoint = Vector2.new( 0.5, 0.5 ),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new( 0.5, 0, 0.5, 0 ),
    Size = UDim2.new( 1, 0, 0, 20 ),
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.new( 1, 1, 1 ),
    TextSize = 20,
    TextStrokeTransparency = 0.5
} )

create( 'UIListLayout', container, {
    Name = math.random( ),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    Padding = UDim.new( 0, 5 )
} )

create( 'UIPadding', container, {
    Name = math.random( ),
    PaddingBottom = UDim.new( 0.25, 0 ),
    PaddingLeft = UDim.new( 0.25, 0 ),
    PaddingRight = UDim.new( 0.25, 0 ),
    PaddingTop = UDim.new( 0.25, 0 )

} )

do
    local function on_render_stepped( )
        local idx = 0
        local curr_job = job_queue[ 1 ]

        if curr_job then
            conn:Disconnect( )

            local text = curr_job[ 1 ]
            local time_alive = curr_job[ 2 ]
            local type_speed = curr_job[ 3 ]

            if text and time_alive and type_speed then
                text_obj.Text = text
                text = string.gsub( text, '<br%s*/>', '\n' )
                text = string.gsub( text, '<[^<>]->', '' )

                for _ in utf8.graphemes( text ) do
                    idx += 1
                    text_obj.MaxVisibleGraphemes = idx
                    task.wait( type_speed )
                end

                task.delay( time_alive, function( )
                    for _ in utf8.graphemes( text ) do
                        idx -= 1
                        text_obj.MaxVisibleGraphemes = idx
                        task.wait( type_speed )
                    end
                
                    table.remove( job_queue, 1 )
                    conn = render_stepped:Connect( on_render_stepped )
                end )
            end
        end
    end

    conn = render_stepped:Connect( on_render_stepped )
end

return function( ... )
    table.insert( job_queue, { ... } )
end
