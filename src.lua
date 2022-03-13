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

local textObj = create( 'TextLabel', container, {
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

local renderStepped = game:GetService( 'RunService' ).RenderStepped

local jobQueue, conn = { }, nil
do
    local function onRenderStepped( )
        local idx = 0
        local currentJob = jobQueue[ 1 ]

        if currentJob then
            conn:Disconnect( )

            local text = currentJob[ 1 ]
            local timeAlive = currentJob[ 2 ]
            local typeSpeed = currentJob[ 3 ]

            if text and timeAlive and typeSpeed then
                textObj.Text = text
                text = string.gsub( text, '<br%s*/>', '\n' )
                text = string.gsub( text, '<[^<>]->', '' )

                for _ in utf8.graphemes( text ) do
                    idx += 1
                    textObj.MaxVisibleGraphemes = idx
                    task.wait( typeSpeed )
                end

                task.wait( timeAlive )

                for _ in utf8.graphemes( text ) do
                    idx -= 1
                    textObj.MaxVisibleGraphemes = idx
                    task.wait( typeSpeed )
                end
                
                table.remove( jobQueue, 1 )
                conn = renderStepped:Connect( onRenderStepped )
            end
        end
    end

    conn = renderStepped:Connect( onRenderStepped )
end

return function( text, timeAlive, typeSpeed )
    table.insert( jobQueue, { text, timeAlive, typeSpeed } )
end
