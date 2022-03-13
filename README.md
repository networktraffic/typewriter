# information
a) to use this in studio, you could create a `ModuleScript` and put the `src.lua` contents or just make it a function within your own script

b) if you want to use this for exploit environment development, just simply make an http request to the raw `src.lua` contents file or make a function within the script and call it from there

```lua
typeWrite( <string> text, <number> time_alive, <number> type_speed )
```

# exploit environment usage
```lua
local typeWrite = loadstring( game:HttpGetAsync( 'https://raw.githubusercontent.com/networktraffic/typewriter/main/src.lua' ) )( )
typeWrite( 'hello world', 3, 0.035 )
```
