rom_exp = { vline = {}, output = {} }

local n = nodes_rect(4230, 3205, 4590, 3165)

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
      rom_exp.vline[idx] = vline
      t:move(4240 + 9*(idx-1), 3200, "w", vline)
      power[vcc_net]:move(4241 + 9*(idx-1), 3204)
   else
      ilines[il] = vline
      t:move(4220, 3190 - 26*(il-1), "e", vline)
      power[vcc_net]:move(4219, 3194 - 26*(il-1))
   end
end

local vlinei = build_hash(rom_exp.vline)
local ilinesi = build_hash(ilines)
local linesi = build_hash(osc.total_att)

n = nodes_rect(4230, 3165, 4590, 3070)
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
	 t:move(4244 + 9*(x-1), 3184 - 13*(y-1), "e", gnd_net)
	 power[gnd_net]:move(4243 + 9*(x-1), 3180 - 13*(y-1))
	 vline:route(4241 + 9*(x-1), 3188 - 13*(y-1))
	 t:gate():route(4248 + 9*(x-1), 3190 - 13*(y-1))
      else
	 local y = linesi[t:gate()]
	 t:move(4214, 3190 - 26*(y-1), "w", gnd_net)
	 power[gnd_net]:move(4215, 3186 - 26*(y-1))
	 vline:route(4217, 3186 - 26*(y-1), 4217, 3194 - 26*(y-1))
	 t:gate():route(4210, 3177 - 26*(y-1), 4196 + 2*(y-1), 3177 - 26*(y-1), 4196 + 2*(y-1), 3149 - 60*(y-1))
	 if y >= 6 then
	    t:gate():route(4228 + 4*(y-6), 3177 - 26*(y-1), 4228 + 4*(y-6), 3214 - 4*(y-6), 4540, 3214 - 4*(y-6), 4574 - 4*(y-6), 3214 - 4*(y-6), 4574 - 4*(y-6), 3177 - 26*(y-6))
	    vline:route(4226 + 4*(y-6), 3190 - 26*(y-1), 4226 + 4*(y-6), 3216 - 4*(y-6), 4550, 3216 - 4*(y-6), 4576 - 4*(y-6), 3216 - 4*(y-6), 4576 - 4*(y-6), 3190 - 26*(y-6))
	 end
      end
   end
end

local pn = nodes_rect(4580, 3070, 4600, 2840)
pn = merge(pn, nodes_rect(4530, 2680, 4590, 2630))

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


local nx = nodes_rect(4537, 3060, 4580, 2680)
local xpower = {}
ph = {}
pha = {}

for i=1,#nx do
   local t = nx[i]
   if(t:type() == "w") then
      xpower[t:t1()] = t
   end
end

for i=1,#nx do
   local t = nx[i]
   if(t:type() == "t" and not xpower[t:t1()] and not xpower[t:t2()]) then
      local x, y = t:pos()
      ph[y] = t
      pha[#pha+1] = y
      tid = tostring(t):sub(1,5)
   end
end

table.sort(pha)

local yy = pha[25]
pha[25] = pha[26]
pha[26] = yy
local xhly = {}
local hlinei = {}

for i=1,#pha do
   local t = ph[pha[i]]
   local nn = t:t1()
   local on = t:t2()
   if xhl[nn] then
      nn = t:t2()
      on = t:t1()
   end
   hlinei[nn] = #pha - i + 1
   if not xhly[on] then
      xhly[on] = #pha - i + 1
   end
end

n = nodes_rect(4230, 3060, 4537, 2690)

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

      t:move(4245 + 9*(x-1), 3055 - 11*(y-1), "w", gnd_net)
      power[gnd_net]:move(4246 + 9*(x-1), 3051 - 11*(y-1))
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
   rom_exp.output[i] = n2
   n2:set_name("rom_exp_out." .. i)
   local x = vlinei[t:gate()]
   t:move(4533 + 9*(x-33), 3055 - 11*(#pha-i), "w", n2)
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
      t:move(4570, 3055 - 11*(#pha-hlp[hline]), "e", hline)
      power[vcc_net]:move(4569, 3059 - 11*(#pha-hlp[hline]))
   end
end

for i=1,#nx do
   local t = nx[i]
   if(t:type() == "t" and (xpower[t:t1()] or xpower[t:t2()])) then
      local hl = t:t1()
      local pw = t:t2()
      if xpower[hl] then
	 hl = t:t2()
	 pw = t:t1()
      end
      local x = vlinei[t:gate()]
      local y = xhly[hl]
      t:move(4245 + 9*(x-1), 3044 - 11*(y-1), "w", pw)
      xpower[pw]:move(4246 + 9*(x-1), 3040 - 11*(y-1))
      hl:route(4246 + 9*(x-1), 3051 - 11*(y-1))      
   end
end

rom_exp.output[45]:route(4600, 3055, 4600, 2372)
rom_exp.output[41]:route(4602, 3011, 4602, 2397)
rom_exp.output[37]:route(4604, 2967, 4604, 2327)
rom_exp.output[34]:route(4606, 2934, 4606, 2302)
rom_exp.output[30]:route(4608, 2890, 4608, 2232)
rom_exp.output[26]:route(4610, 2846, 4610, 2257)
rom_exp.output[24]:route(4612, 2824, 4612, 2162)
rom_exp.output[20]:route(4614, 2780, 4614, 2092)
rom_exp.output[16]:route(4616, 2736, 4616, 2022)
rom_exp.output[12]:route(4618, 2692, 4618, 1952)
rom_exp.output[ 8]:route(4620, 2648, 4620, 1882)
rom_exp.output[ 4]:route(4622, 2604, 4622, 1812)
rom_exp.output[ 1]:route(4624, 2571, 4624, 1742)
