# Notes
A) To use this in studio, you can create a `ModuleScript` and put the `src.lua` contents or just make it a function within your own script

B) If you want to use this for exploit script development, just simply make a `HttpGet` request to the `src.lua` contents file or make a function within the script and call it from there

```lua
TypeWrite(<string> Text, <number> TimeAlive, <number> TypeSpeed)
```

# Basic Exploit Usage
```lua
local TypeWrite = loadstring(game:HttpGet("https://raw.githubusercontent.com/networktraffic/typewriter/main/src.lua"))()
TypeWrite("Hello World!", 3, 0.035)
```
