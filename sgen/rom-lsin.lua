rom_lsin = { vline = {}, output = {} }

local n = nodes_rect(3525, 3205, 3875, 3165)

local power = {}
local ph = {}
local pha = {}
local ilines = {}

for i=1,#n do
   local t = n[i]
   if(t:type() == "w") then
      power[t:t1()] = t
   else
      local x, y = t:pos()
      ph[x] = t
      pha[#pha+1] = x
   end
end

table.sort(pha)

for i=1,#pha do
   local t = ph[pha[i]]
   local vline = t:t1()
   local vcc_net = t:t2()
   if(power[vline]) then
      local tt = vline
      vline = vcc_net
      vcc_net = tt
   end
   local idx
   local il
   if i < 9 then
      idx = i
   elseif i < 10 then
      il = 1
   elseif i < 11 then
      idx = i - 1
   elseif i < 12 then
      il = 2
   elseif i < 19 then
      idx = i - 2
   elseif i < 20 then
      il = 5
   elseif i < 26 then
      idx = i - 3
   elseif i < 27 then
      il = 3
   elseif i < 37 then
      idx = i - 4
   elseif i < 38 then
      il = 4
   elseif i < 42 then
      idx = i - 5
   else
      il = i - 41 + 5
   end

   if idx then
      rom_lsin.vline[idx] = vline
      t:move(3530 + 9*(idx-1), 3200, "w", vline)
      power[vcc_net]:move(3531 + 9*(idx-1), 3204)
   else
      ilines[il] = vline
      t:move(3510, 3190 - 26*(il-1), "e", vline)
      power[vcc_net]:move(3509, 3194 - 26*(il-1))
   end
end

local vlinei = build_hash(rom_lsin.vline)
local ilinesi = build_hash(ilines)
local linesi = build_hash(osc.pline)

n = nodes_rect(3530, 3165, 3870, 3070)
power = {}
for i=1,#n do
   local t = n[i]
   if(t:type() == "w") then
      power[t:t1()] = t
   end
end

for i=1,#n do
   local t = n[i]
   if(t:type() == "t") then
      local vline = t:t1()
      local gnd_net = t:t2()
      if(power[vline]) then
	 local tt = vline
	 vline = gnd_net
	 gnd_net = tt
      end

      local x = vlinei[vline]
      if x then
	 local y = linesi[t:gate()]
	 if y then
	    y = 2*y
	 else
	    y = ilinesi[t:gate()]*2 - 1
	 end
	 if y >= 11 then
	    y = y - 10
	 end
	 t:move(3534 + 9*(x-1), 3184 - 13*(y-1), "e", gnd_net)
	 power[gnd_net]:move(3533 + 9*(x-1), 3180 - 13*(y-1))
	 vline:route(3531 + 9*(x-1), 3188 - 13*(y-1))
	 t:gate():route(3538 + 9*(x-1), 3190 - 13*(y-1))
      else
	 local y = linesi[t:gate()]
	 t:move(3504, 3190 - 26*(y-1), "w", gnd_net)
	 power[gnd_net]:move(3505, 3186 - 26*(y-1))
	 vline:route(3507, 3186 - 26*(y-1), 3507, 3194 - 26*(y-1))
	 t:gate():route(3500, 3177 - 26*(y-1), 3486 + 2*(y-1), 3177 - 26*(y-1), 3486 + 2*(y-1), 3141 - 60*(y-1))
	 if y >= 6 then
	    t:gate():route(3518 + 4*(y-6), 3177 - 26*(y-1), 3518 + 4*(y-6), 3214 - 4*(y-6), 3830, 3214 - 4*(y-6), 3864 - 4*(y-6), 3214 - 4*(y-6), 3864 - 4*(y-6), 3177 - 26*(y-6))
	    vline:route(3516 + 4*(y-6), 3190 - 26*(y-1), 3516 + 4*(y-6), 3216 - 4*(y-6), 3840, 3216 - 4*(y-6), 3866 - 4*(y-6), 3216 - 4*(y-6), 3866 - 4*(y-6), 3190 - 26*(y-6))
	 end
      end
   end
end

local pn = nodes_rect(3870, 3200, 3920, 2670)
power = {}
local xhl = {}

for i=1,#pn do
   local t = pn[i]
   if(t:type() == "w") then
      power[t:t1()] = t
   else
      xhl[t:gate()] = true
   end
end


local nx = nodes_rect(3830, 3060, 3870, 2690)
ph = {}
pha = {}

for i=1,#nx do
   local t = nx[i]
   local x, y = t:pos()
   ph[y] = t
   pha[#pha+1] = y
end

table.sort(pha)

local hlinei = {}

for i=1,#pha do
   local t = ph[pha[i]]
   local nn = t:t1()
   if xhl[nn] then
      nn = t:t2()
   end
   hlinei[nn] = #pha - i + 1
end

n = nodes_rect(3525, 3060, 3830, 2690)

for i=1,#n do
   local t = n[i]
   if(t:type() == "w") then
      power[t:t1()] = t
   end
end

for i=1,#n do
   local t = n[i]
   if(t:type() == "t") then
      local hline = t:t1()
      local gnd_net = t:t2()
      if(power[hline]) then
	 local tt = hline
	 hline = gnd_net
	 gnd_net = tt
      end

      local x = vlinei[t:gate()]
      local y = hlinei[hline]

      t:move(3535 + 9*(x-1), 3055 - 11*(y-1), "w", gnd_net)
      power[gnd_net]:move(3536 + 9*(x-1), 3051 - 11*(y-1))
   end
end

local hlp = {}

for i=1,#pha do
   local t = ph[pha[i]]
   local n1 = t:t1()
   local n2 = t:t2()
   if xhl[n1] then
      local nn = n1
      n1 = n2
      n2 = nn
   end
   hlp[n2] = i
   rom_lsin.output[i] = n2
   n2:set_name("rom_lsin_out." .. i)
   local x = vlinei[t:gate()]
   t:move(3823 + 9*(x-33), 3055 - 11*(#pha-i), "w", n2)
end

for i=1,#pn do
   local t = pn[i]
   if(t:type() == "t") then
      local hline = t:t1()
      local vcc_net = t:t2()
      if(power[hline]) then
	 local tt = hline
	 hline = vcc_net
	 vcc_net = tt
      end
      t:move(3860, 3055 - 11*(#pha-hlp[hline]), "e", hline)
      power[vcc_net]:move(3859, 3059 - 11*(#pha-hlp[hline]))
   end
end
