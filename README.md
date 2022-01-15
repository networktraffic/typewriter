# notes
a) in order to use this in studio, you can create a modulescript and put the `src.lua` for the code or just make it a function within the script

b) if you want to use this for exploit script development, just simply make a httpget request to the raw `src.lua` file or make a function within the script and call it from there

# basic exploit usage
```lua
local function TypeWrite(Text, Expiration)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/networktraffic/typewriter/main/src.lua"))()(Text, Expiration)
end

TypeWrite("Hello World!", 3)
```
