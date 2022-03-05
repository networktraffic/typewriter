local function create( class, parent, properties )
	local object = Instance.new( class, parent )
	
	for index, value in next, properties do
		object[ index ] = value
	end
	
	return object
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

local layout = create( 'UIListLayout', container, {
    Name = math.random( ),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Bottom,
    Padding = UDim.new( 0, 5 )
} )

local padding = create( 'UIPadding', container, {
    Name = math.random( ),
    PaddingBottom = UDim.new( 0.25, 0 ),
    PaddingLeft = UDim.new( 0.25, 0 ),
    PaddingRight = UDim.new( 0.25, 0 ),
    PaddingTop = UDim.new( 0.25, 0 )

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

local render_stepped = game:GetService( 'RunService' ).RenderStepped

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

local test = function( text, time_alive, type_speed )
    table.insert( job_queue, { text, time_alive, type_speed } )
end

test( 'hhello', 2.50, 0.035 )
