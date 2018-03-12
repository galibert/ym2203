#!/people/galibert/soft/dietools/mschem/mschem

setup("../ym2203.map", "../ym2203.txt", "../ym2203-pins.txt", "../ym2203-pads.txt", 2)
text("../ym2203-schem.txt")

dofile("functions.lua")
dofile("config.lua")
dofile("osc.lua")
dofile("osctrl.lua")

--[=[
n = nodes_rect()
print(make_match(n))

nl = match(n, [[
]])

move(nl, 0, 0, [[
]])

route(nl, 0, 0, [[
]])

rename(nl)
]=]--
