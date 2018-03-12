osc = { tphase = {}, pline = {}, lsin = {}, att = {}, att_preclamp = {}, total_att = {}, mod_shift = {}, mod = {}, pre_shift = {}, mid_control = {} }

local n = nodes_rect(3365, 3200, 3525, 2520)

local nc = nodes_rect(3365, 3200, 3375, 3185)
local nl = match(nc, [[
A=d(b, a, a)
B=vcc(b)
]])

move(nl, 0, 0, [[
A 3411 3200 ea,
B 3410 3204,
]])

local c = nl.a

for i=0,9 do
   local y = 3160 - 60 * i
   local nl = adder2cl(n, 3400, y, i ~= 9, { ic = c })
   local ymod, yin
   c = nl.oc

   local nl1 = match(n, [[
A=d(e, b, b)
B=t(b, a, i1)
C=t(mod, a, i2)
D=t(b, phase, f)
E=vcc(e)
F=gnd(f)
]], { i1=nl.i1, i2=nl.i2 })

   if i == 0 then
      osc.phi0 = nl1.a
      nl1.a:set_name("phi0")
   end

   if nl1 then
      move(nl1, 3380, y, [[
D -14 10 wf,
F -13  6,
A  -8 10 eb,
E  -9 14,
C   0  1 nmod,
B   0 11 nb,
]])
      route(nl1, 3380, y, [[
b -11 6 -11 14,
a 4 15 4 5,
]])
      ymod = y
      yin = y + 10
   else
      nl1 = match(n, [[
A=d(e, b, b)
B=t(b, a, i1)
C=t(mod, a, i2)
D=t(b, phase, f)
E=vcc(e)
F=gnd(f)
]], { i1=nl.i2, i2=nl.i1 })
      move(nl1, 3380, y, [[
D -14  0 wf,
F -13 -4,
A  -8  0 eb,
E  -9  4,
C   0 11 nmod,
B   0  1 nb,
]])
      route(nl1, 3380, y, [[
b -11 -4 -11 4,
a 4 15 4 5,
]])

      ymod = y + 10
      yin = y
   end

   osc.tphase[i] = nl.out
   nl.out:set_name("osc_tphase." .. i)
   nl1.mod:set_name("osc_mod_in." .. i)
   nl1.phase:set_name("osc_phase_in." .. i)

   nl1.mod:route(3320 - 2*i, ymod)
   osc.mod[i] = nl1.mod
end

for i=0,7 do
   local y = 3193 - 60 * i
   nl = match(n, [[
A=d(j, b, b)
B=d(h, d, d)
C=d(i, e, e)
D=t(b, g, k)
E=t(d, e, l)
F=t(m, a, e)
G=t(e, inp, n)
H=t(o, a, c)
I=t(d, f, g)
J=t(d, inp, c)
K=vcc(h)
L=vcc(i)
M=vcc(j)
N=gnd(k)
O=gnd(l)
P=gnd(m)
Q=gnd(n)
R=gnd(o)
S=gnd(p)
T=c(g, p)
]], { inp = osc.tphase[i] })

   if i == 0 then
      osc.phi1 = nl.f
      nl.f:set_name("phi1")
   end

   move(nl, 3438, y, [[
G  0   0 wn,
Q  1  -4,
F  4   0 em,
P  3  -4,
C  4   8 ee,
L  3  12,

E 14   0 wl,
O 15  -4,
H 18  -8 eo,
R 17 -12,
J 18   0 ec,
B 18   8 ed,
K 17  12,

I 28   7 sd,

T 34   7 np,
S 34   6,

D 38   8 wk,
N 39   4,
A 44   8 eb,
M 43  12,
]])

   route(nl, 3438, y, [[
e 10 8,
b 41 4 41 12,
a 24 -8 24 -15 8 -15,
inp 22 -17 -4 -17,
f 32 3,
]])

   nl.a:route(3438+24, y-30, 3438+24, y-60)
   osc.pline[i] = nl.b
   nl.b:set_name("osc_pline." .. i)
end

nl = match(n, [[
A=d(b, a, a)
B=t(a, inp, c)
C=vcc(b)
D=gnd(c)
]], { inp = osc.pline[0] })

if nl then
move(nl, 0, 0, [[
B 3491 3201 wc,
D 3492 3197,
A 3497 3201 ea,
C 3496 3205,
]])

route(nl, 0, 0, [[
a 3494 3197 3494 3205 3510 3201 3510 3220 3966 3220,
]])
end

n = nodes_rect(3450, 2590, 3470, 2540)
nl = match(n, [[
A=d(c, c, d)
B=t(e, b, c)
C=t(inp, a, b)
D=vcc(d)
E=gnd(e)
F=gnd(f)
H=c(b, f)
]], { inp = osc.tphase[9] })

move(nl, 0, 0, [[
C 3466 2652 sinp,
H 3472 2652 nf,
F 3472 2651,
B 3476 2653 we,
E 3477 2649,
A 3482 2653 ec,
D 3481 2657,
]])

route(nl, 0, 0, [[
a 3470 2648,
c 3479 2657 3479 2649,
]])

n = nodes_rect(3510, 2670, 3680, 2560)
nl = match(n, [[
N0=d(n18, n0, n0)
N1=d(n19, n1, n1)
N2=d(n20, n2, n2)
N3=d(n21, n3, n3)
N4=d(n22, n4, n4)
N5=d(n23, n5, n5)
N6=d(n24, n6, n6)
N7=d(n25, n7, n7)
N8=d(n26, n8, n8)
N9=d(n27, n9, n9)
N10=d(n28, n10, n10)
N11=d(n29, n13, n13)
N12=d(n30, n14, n14)
N13=d(n16, n16, n31)
N14=t(n32, n1, n0)
N15=t(n0, n13, n33)
N16=t(n0, n14, n34)
N17=t(n0, n16, n35)
N18=t(n1, n10, n36)
N19=t(n37, n3, n2)
N20=t(n2, n10, n38)
N21=t(n2, n14, n39)
N22=t(n2, n16, n40)
N23=t(n3, n13, n41)
N24=t(n42, n1, n4)
N25=t(n43, n3, n4)
N26=t(n4, n14, n44)
N27=t(n4, n16, n45)
N28=t(n46, n6, n5)
N29=t(n5, n10, n47)
N30=t(n5, n13, n48)
N31=t(n5, n16, n49)
N32=t(n6, n14, n50)
N33=t(n51, n1, n7)
N34=t(n52, n6, n7)
N35=t(n7, n13, n53)
N36=t(n7, n16, n54)
N37=t(n55, n3, n8)
N38=t(n56, n6, n8)
N39=t(n8, n10, n57)
N40=t(n8, n16, n58)
N41=t(n59, n1, n9)
N42=t(n60, n3, n9)
N43=t(n61, n6, n9)
N44=t(n9, n16, n62)
N45=t(n10, n11, n63)
N46=t(n13, n12, n64)
N47=t(n14, n15, n65)
N48=t(n16, n17, n66)
N49=vcc(n18)
N50=vcc(n19)
N51=vcc(n20)
N52=vcc(n21)
N53=vcc(n22)
N54=vcc(n23)
N55=vcc(n24)
N56=vcc(n25)
N57=vcc(n26)
N58=vcc(n27)
N59=vcc(n28)
N60=vcc(n29)
N61=vcc(n30)
N62=vcc(n31)
N63=gnd(n32)
N64=gnd(n33)
N65=gnd(n34)
N66=gnd(n35)
N67=gnd(n36)
N68=gnd(n37)
N69=gnd(n38)
N70=gnd(n39)
N71=gnd(n40)
N72=gnd(n41)
N73=gnd(n42)
N74=gnd(n43)
N75=gnd(n44)
N76=gnd(n45)
N77=gnd(n46)
N78=gnd(n47)
N79=gnd(n48)
N80=gnd(n49)
N81=gnd(n50)
N82=gnd(n51)
N83=gnd(n52)
N84=gnd(n53)
N85=gnd(n54)
N86=gnd(n55)
N87=gnd(n56)
N88=gnd(n57)
N89=gnd(n58)
N90=gnd(n59)
N91=gnd(n60)
N92=gnd(n61)
N93=gnd(n62)
N94=gnd(n63)
N95=gnd(n64)
N96=gnd(n65)
N97=gnd(n66)
G1=gnd(g1)
C1=c(n17, g1)
G4=gnd(g4)
C4=c(n11, g4)
N98=c(n67, n12)
N99=c(n68, n15)
N100=gnd(n67)
N101=gnd(n68)
]])

move(nl, 0, 0, [[
N1  3420 2469 wn1,
N50 3421 2473,
N18 3426 2469 en36,
N67 3425 2465,

N3  3420 2454 wn3,
N52 3421 2458,
N23 3426 2454 en41,
N72 3425 2450,

N6  3420 2439 wn6,
N55 3421 2443,
N32 3426 2439 en50,
N81 3425 2435,

N9  3354 2477 wn9,
N58 3355 2481,
N41 3352 2463 wn59,
N90 3353 2459,
N42 3352 2448 wn60,
N91 3353 2444,
N43 3352 2433 wn61,
N92 3353 2429,
N44 3352 2420 wn62,
N93 3353 2416,

N8  3363 2477 wn8,
N57 3364 2481,
N39 3361 2463 wn57,
N88 3362 2459,
N37 3361 2448 wn55,
N86 3362 2444,
N38 3361 2433 wn56,
N87 3362 2429,
N40 3361 2420 wn58,
N89 3362 2416,

N7  3372 2477 wn7,
N56 3373 2481,
N33 3370 2463 wn51,
N82 3371 2459,
N35 3370 2448 wn53,
N84 3371 2444,
N34 3370 2433 wn52,
N83 3371 2429,
N36 3370 2420 wn54,
N85 3371 2416,

N5  3381 2477 wn5,
N54 3382 2481,
N29 3379 2463 wn47,
N78 3380 2459,
N30 3379 2448 wn48,
N79 3380 2444,
N28 3379 2433 wn46,
N77 3380 2429,
N31 3379 2420 wn49,
N80 3380 2416,

N4  3390 2477 wn4,
N53 3391 2481,
N24 3388 2463 wn42,
N73 3389 2459,
N25 3388 2448 wn43,
N74 3389 2444,
N26 3388 2433 wn44,
N75 3389 2429,
N27 3388 2420 wn45,
N76 3389 2416,

N2  3399 2477 wn2,
N51 3400 2481,
N20 3397 2463 wn38,
N69 3398 2459,
N19 3397 2448 wn37,
N68 3398 2444,
N21 3397 2433 wn39,
N70 3398 2429,
N22 3397 2420 wn40,
N71 3398 2416,

N0  3408 2477 wn0,
N49 3409 2481,
N14 3406 2463 wn32,
N63 3407 2459,
N15 3406 2448 wn33,
N64 3407 2444,
N16 3406 2433 wn34,
N65 3407 2429,
N17 3406 2420 wn35,
N66 3407 2416,

N13 3340 2426 en16,
N62 3339 2430,
N48 3334 2426 wn66,
N97 3335 2422,
C1  3330 2425 ng1,
G1  3330 2424,

N12 3340 2441 en14,
N61 3339 2445,
N47 3334 2441 wn65,
N96 3335 2437,
N99 3330 2439 nn68,
N101 3330 2438,

N11 3340 2456 en13,
N60 3339 2460,
N46 3334 2456 wn64,
N95 3335 2452,
N98 3330 2455 nn67,
N100 3330 2454,

N10 3340 2471 en10,
N59 3339 2475,
N45 3334 2471 wn63,
N94 3335 2467,
C4  3330 2470 ng4,
G4  3330 2469,
]])

route(nl, 0, 0, [[
n10           3357 2471           3375 2471           3393 2471,
n1  3348 2469           3366 2469           3384 2469           3402 2469,
n13                     3366 2456 3375 2456                     3402 2456,
n3  3348 2454 3357 2454                     3384 2454 3393 2454,
n14                                         3384 2441 3393 2441 3402 2441,
n6  3348 2439 3357 2439 3366 2439 3375 2439,
n16 3348 2426 3357 2426 3366 2426 3375 2426 3384 2426 3393 2426 3402 2426,
n9  3355 2424 3355 2437 3355 2452 3355 2467,
n8  3364 2424 3364 2437 3364 2452 3364 2467,
n7  3373 2424 3373 2437 3373 2452 3373 2467,
n5  3382 2424 3382 2437 3382 2452 3382 2467,
n4  3391 2424 3391 2437 3391 2452 3391 2467,
n2  3400 2424 3400 2437 3400 2452 3400 2467,
n0  3409 2424 3409 2437 3409 2452 3409 2467,

n16                               3337 2422 3337 2430,
n6  3423 2435 3423 2443,
n14 3416 2441 3416 2446 3430 2446 3337 2437 3337 2445,
n3  3423 2450 3423 2458,
n13 3416 2456 3416 2461 3430 2461 3337 2452 3337 2460,
n1  3423 2465 3423 2473,
n10 3416 2471 3416 2476 3430 2476 3337 2467 3337 2475,

n16 3342 2400 3348 2400,
]])

osc.mod_shift[0] = nl.n16
osc.mod_shift[7] = nl.n0
osc.mod_shift[6] = nl.n2
osc.mod_shift[5] = nl.n4
osc.mod_shift[4] = nl.n5
osc.mod_shift[3] = nl.n7
osc.mod_shift[2] = nl.n8
osc.mod_shift[1] = nl.n9

n = nodes_rect(3710, 2680, 3830, 2490)
nl = match(n, [[
N0=d(n9, n9, n23)
N1=d(n10, n10, n24)
N2=d(n11, n11, n25)
N3=d(n12, n12, n26)
N4=d(n27, n13, n13)
N5=d(n28, n14, n14)
N6=d(n29, n15, n15)
N7=d(n30, n16, n16)
N8=d(n31, n17, n17)
N9=t(n32, n7, n9)
N10=t(n33, n8, n10)
N11=t(n34, n9, n11)
N12=t(n35, n10, n12)
N13=t(n13, n18, n36)
N14=t(n14, n19, n37)
N15=t(n15, n20, n38)
N16=t(n16, n21, n39)
N17=t(n17, n22, n40)
N18=t(n7, n0, n2)
N19=t(n2, n0, n22)
N20=t(n3, n0, n21)
N21=t(n4, n0, n20)
N22=t(n5, n0, n19)
N23=t(n6, n0, n18)
N24=t(n8, n0, n1)
N25=vcc(n23)
N26=vcc(n24)
N27=vcc(n25)
N28=vcc(n26)
N29=vcc(n27)
N30=vcc(n28)
N31=vcc(n29)
N32=vcc(n30)
N33=vcc(n31)
N34=gnd(n32)
N35=gnd(n33)
N36=gnd(n34)
N37=gnd(n35)
N38=gnd(n36)
N39=gnd(n37)
N40=gnd(n38)
N41=gnd(n39)
N42=gnd(n40)
G1=gnd(g1)
C1=c(n18, g1)
G2=gnd(g2)
C2=c(n19, g2)
G3=gnd(g3)
C3=c(n20, g3)
G4=gnd(g4)
C4=c(n21, g4)
G5=gnd(g5)
C5=c(n22, g5)
G6=gnd(g6)
C6=c(n7, g6)
G7=gnd(g7)
C7=c(n8, g7)
]])

move(nl, 0, 0, [[
N4  3629 2500 en13,
N29 3628 2504,
N13 3623 2500 wn36,
N38 3624 2496,
N23 3615 2501 nn6,
C1  3619 2499 ng1,
G1  3619 2498,

N5  3629 2485 en14,
N30 3628 2489,
N14 3623 2485 wn37,
N39 3624 2481,
N22 3615 2486 nn5,
C2  3619 2484 ng2,
G2  3619 2483,

N6  3629 2470 en15,
N31 3628 2474,
N15 3623 2470 wn38,
N40 3624 2466,
N21 3615 2471 nn4,
C3  3619 2469 ng3,
G3  3619 2468,

N7  3629 2455 en16,
N32 3628 2459,
N16 3623 2455 wn39,
N41 3624 2451,
N20 3615 2456 nn3,
C4  3619 2454 ng4,
G4  3619 2453,

N8  3629 2440 en17,
N33 3628 2444,
N17 3623 2440 wn40,
N42 3624 2436,
N19 3615 2441 nn2,
C5  3619 2439 ng5,
G5  3619 2438,

N2  3771 2450 en11,
N27 3770 2454,
N11 3769 2442 wn34,
N36 3770 2438,
N0  3759 2450 en9,
N25 3758 2454,
N9  3757 2442 wn32,
N34 3758 2438,
C6  3753 2441 ng6,
G6  3753 2440,
N18 3749 2443 nn2,

N3  3871 2450 en12,
N28 3870 2454,
N12 3869 2442 wn35,
N37 3870 2438,
N1  3859 2450 en10,
N26 3858 2454,
N10 3857 2442 wn33,
N35 3858 2438,
C7  3853 2441 ng7,
G7  3853 2440,
N24 3849 2443 nn1,
]])

route(nl, 0, 0, [[
n13 3626 2496 3626 2504 3640 2500,
n14 3626 2481 3626 2489 3648 2485,
n15 3626 2466 3626 2474 3656 2470,
n16 3626 2451 3626 2459 3664 2455,
n17 3626 2436 3626 2444 3672 2440,
n0  3611 2505 3611 2490 3611 2475 3611 2460 3611 2445,
n9  3765 2450 3765 2434 3791 2434,
n11 3789 2450,
n10 3865 2450 3865 2434 3891 2434,
n12 3889 2450,
]])

osc.mid_control[0] = nl.n13
osc.mid_control[1] = nl.n14
osc.mid_control[2] = nl.n15
osc.mid_control[3] = nl.n16
osc.mid_control[4] = nl.n17

dofile("rom-lsin.lua")

local function link1(id, bit, y, delta)
   local node = rom_lsin.output[id]
   local x = (delta and 3890 or 3920) + 2*bit
   node:route(x, 3055 - 11*(46 - id), x, y)
end

n = nodes_rect(3940, 3200, 4040, 2445)

local outline = {
   42, 46, 38, 35, 27, 31, 25, 24, 16, 20, 15, 14, 8, 11, 7, 6
}

for i=0,7 do
   local y = 3160 - 60 * i

   nl = match(n, [[
A=d(e, e, g)
B=d(f, f, h)
C=t(i, b, e)
D=t(j, i2, e)
E=t(k, i1, f)
F=t(c, a, e)
G=t(f, a, d)
H=vcc(g)
I=vcc(h)
J=gnd(i)
K=gnd(j)
L=gnd(k)
]], { i1 = rom_lsin.output[outline[i*2+2]], i2 = rom_lsin.output[outline[i*2+1]] })

   move(nl, 3980, y, [[
E -26 10 wk,
L -25  6,
B -20 10 ef,
I -21 14,

D -17 -8 wj,
K -16 -12,
C -10  -8 wi,
J  -9 -12,
A  -8   0 ee,
H  -9   4,

F   0   1 ne,
G   0  11 nf,
]])

   route(nl, 3980, y, [[
a 4 15 4 5,
f -23 6 -23 14,
]])

   link1(outline[i*2+2], i, y+10, false)
   link1(outline[i*2+1], i, y-8, true)

   if i ~= 0 then
      osc.lsin[i] = adder2cl(n, 4000, y, true, { i1 = nl.d }).out
   else
      osc.lsin[i] = adder20l(n, 4000, y, true, { i1 = nl.d }).out
   end
end


local y = 3160 - 60 * 8

nl = match(n, [[
B=d(f, f, h)
E=t(k, i1, f)
F=t(c, a, i2)
F2=t(c2, a, i2)
G=t(f, a, d)
I=vcc(h)
L=gnd(k)
]], { i1 = rom_lsin.output[4], i2 = nl.e, F2 = nl.F })

link1(4, 8, y, false)

move(nl, 3980, y, [[
E -26  0 wk,
L -25 -4,
B -20  0 ef,
I -21  4,

F   0 11 ni2,
G   0  1 nf,
]])

route(nl, 3980, y, [[
a 4 15 4 5,
f -23 -4 -23 4,
]])

osc.lsin[8] = adder2cl(n, 4000, y, true, { i2 = nl.d }).out

for i=9,10 do
   local y = 3160 - 60 * i

   nl = match(n, [[
A=d(d, d, b)
B=t(e, i1, d)
C=t(d, a, c)
D=vcc(b)
E=gnd(e)
]], { i1 = rom_lsin.output[11-i] })

   move(nl, 3980, y, [[
B -26  0 we,
E -25 -4,
A -20  0 ed,
D -21  4,
C   0  1 nd,
]])

   route(nl, 3980, y, [[
a 4 5,
d -23 -4 -23 4,
]])

   link1(11-i, i, y, false)

   if i == 9 then
      osc.lsin[i] = adder1cl(n, 4000, y, true, { i1 = nl.c }).out
   else
      local nl1 = adder1cil(n, 4000, y, { i1 = nl.c })
      osc.lsin[i] = nl1.out
      osc.lsin[i+1] = nl1.oc
   end
end

for i=0,11 do
   osc.lsin[i]:set_name("osx_lsin." .. i)
end

n = nodes_rect(4100, 3210, 4220, 2440)
for i=0,1 do
   local y = 3160 - 60 * i
   nl = match(n, [[
A=d(c, out, out)
B=t(out, i1, d)
C=vcc(c)
D=gnd(d)
]], { i1 = osc.lsin[i] })

   move(nl, 4130, y, [[
B 23 25 wd,
D 24 21,
A 25 33 eout,
C 24 37,
]])

   route(nl, 4130, y, [[
i1 -95 25 -95 33,
]])

   osc.att_preclamp[i] = nl.out
end

for i=2,11 do
   local y = 3160 - 60 * i

   local c
   if (i % 2) == 0 then
      c = { i2 = osc.lsin[i] }
   else
      c = { i1 = osc.lsin[i] }
   end

   local nl;
   if i ~= 11 then
      nl = adder2cl(n, 4130, y, true, c)
   else
      nl = adder2cil(n, 4130, y, c)
      nl.oc:route(4168, y+8)
   end

   local att
   local dy
   if (i % 2) == 0 then
      att = nl.i1
      dy = 10
   else
      att = nl.i2
      dy = 0
   end

   local nl1 = match(n, [[
A=d(d, d, e)
B=t(f, a, d)
C=t(d, b, att)
D=vcc(e)
E=gnd(f)
]], { att = att })

   move(nl1, 4110, y+dy, [[
B -14  0 wf,
E -13 -4,
A  -8  0 ed,
D  -9  4,
C   0  1 nd,
]])

   route(nl1, 4110, y+dy, [[
d -11 -4 -11 4,
b 4 5,
]])

   osc.lsin[i]:route(4035, 3193 - 60*i, 4035, y+10-dy)
   osc.att[i-2] = nl1.a
   nl1.a:set_name("osc_att." .. (i-2))
   osc.att_preclamp[i] = nl.out

   if i == 2 then
      local nl = match(n, [[
A=d(b, oc, oc)
B=vcc(b)
]], { oc = nl.ic })
      move(nl, 0, 0, [[
A 4141 3080 eoc,
B 4140 3084,
]])
   end
end

osc.lsin[11]:route(4024, 3193 - 60*11)

for i=0,11 do
   local y = 3160 - 60 * i

   nl = match(n, [[
A=d(c, c, g)
B=d(h, f, f)
C=t(i, e, c)
D=t(j, b, f)
E=t(k, d, f)
F=t(f, a, e)
G=vcc(g)
H=vcc(h)
I=gnd(i)
J=gnd(j)
K=gnd(k)
L=gnd(l)
M=c(l, e)
]], { b = osc.att_preclamp[i] })

   move(nl, 4163, y, [[
D  0 33 wj,
J  1 29,
E  7 33 wk,
K  8 29,
B  9 41 ef,
H  8 45,

F 17 42 nf,
M 23 40 nl,
L 23 39,

C 27 41 wi,
I 28 37,
A 29 49 ec,
G 28 53,
]])

   route(nl, 4163, y, [[
a 21 46,
]])

   osc.total_att[i] = nl.c
   nl.c:set_name("osc_total_att." .. i)
end

osc.total_att[0]:route(4590, 3220, 4220, 3220, 4220, 3209)

n = nodes_rect(4250, 2650, 4385, 2580)

local outline = {}

for i=0,3 do
   nl = match(n, [[
A=d(g, out, out)
B=d(d, d, h)
C=t(out, e, j)
D=t(d, f, k)
E=t(i, a, f)
F=t(d, b, e)
G=vcc(g)
H=vcc(h)
I=gnd(j)
J=gnd(k)
G1=gnd(g1)
G2=gnd(g2)
C1=c(f, g1)
C2=c(e, g2)
]], { i = osc.total_att[8+i] })

   local y = 2540 - 16*i

   move(nl, 4220, y, [[
E  0 -1 si,
C1 6 -1 ng1,
G1 6 -2,

D 10  0 wk,
J 11 -4,
B 16  0 ed,
H 15  4,

F 24 -1 sd,
C2 30 -1 ng2,
G2 30 -2,
C 34  0 wj,
I 35 -4,
A 40  0 eout,
G 39  4,

]])

   route(nl, 4220, y, [[
d 13 -4 13 4,
out 37 -4 37 4,
a  4 -5,
b 28 -5,
]])

   nl.i:route(4212-2*i, 2729-60*i, 4212-2*i, y)
   outline["i" .. i] = nl.out
end

local inline = {}

n = nodes_rect(4385, 2655, 4550, 2585)
nl = match(n, [[
N0=d(n12, n0, n0)
N1=d(n13, n1, n1)
N2=d(n14, n2, n2)
N3=d(n15, n3, n3)
N4=d(n16, n4, n4)
N5=d(n17, n5, n5)
N6=d(n18, n6, n6)
N7=d(n19, n7, n7)
N8=d(n20, n8, n8)
N9=d(n21, n9, n9)
N10=d(n22, n10, n10)
N11=d(n11, n11, n23)
N12=t(n0, i2, n24)
N13=t(n0, i3, n25)
N14=t(n26, n2, n1)
N15=t(n1, i3, n27)
N16=t(n2, i2, n28)
N17=t(n29, n5, n3)
N18=t(n3, i2, n30)
N19=t(n31, n2, n4)
N20=t(n32, n5, n4)
N21=t(n5, i3, n33)
N22=t(n6, i0, n34)
N23=t(n6, i1, n35)
N24=t(n7, i1, n36)
N25=t(n37, n8, n7)
N26=t(n8, i0, n38)
N27=t(n9, i0, n39)
N28=t(n40, n11, n9)
N29=t(n41, n8, n10)
N30=t(n42, n11, n10)
N31=t(n43, i1, n11)
N32=vcc(n12)
N33=vcc(n13)
N34=vcc(n14)
N35=vcc(n15)
N36=vcc(n16)
N37=vcc(n17)
N38=vcc(n18)
N39=vcc(n19)
N40=vcc(n20)
N41=vcc(n21)
N42=vcc(n22)
N43=vcc(n23)
N44=gnd(n24)
N45=gnd(n25)
N46=gnd(n26)
N47=gnd(n27)
N48=gnd(n28)
N49=gnd(n29)
N50=gnd(n30)
N51=gnd(n31)
N52=gnd(n32)
N53=gnd(n33)
N54=gnd(n34)
N55=gnd(n35)
N56=gnd(n36)
N57=gnd(n37)
N58=gnd(n38)
N59=gnd(n39)
N60=gnd(n40)
N61=gnd(n41)
N62=gnd(n42)
N63=gnd(n43)
]], outline)

move(nl, 0, 0, [[
N5  4280 2492 en5,
N37 4279 2496,
N21 4274 2492 wn33,
N53 4275 2488,

N2  4280 2508 en2,
N34 4279 2512,
N16 4274 2508 wn28,
N48 4275 2504,

N11 4280 2524 en11,
N43 4279 2528,
N31 4274 2524 wn43,
N63 4275 2520,

N8  4280 2540 en8,
N40 4279 2544,
N26 4274 2540 wn38,
N58 4275 2536,


N0  4301 2550 en0,
N32 4300 2554,
N12 4304 2496 nn0,
N44 4308 2495,
N13 4304 2480 nn0,
N45 4308 2479,

N1  4312 2550 en1,
N33 4311 2554,
N14 4315 2504 nn1,
N46 4319 2503,
N15 4315 2480 nn1,
N47 4319 2479,

N3  4323 2550 en3,
N35 4322 2554,
N18 4326 2496 nn3,
N50 4330 2495,
N17 4326 2488 nn3,
N49 4330 2487,

N4  4334 2550 en4,
N36 4333 2554,
N19 4337 2504 nn4,
N51 4341 2503,
N20 4337 2488 nn4,
N52 4341 2487,

N6  4345 2550 en6,
N38 4344 2554,
N22 4348 2528 nn6,
N54 4352 2527,
N23 4348 2512 nn6,
N55 4352 2511,

N7  4356 2550 en7,
N39 4355 2554,
N25 4359 2536 nn7,
N57 4363 2535,
N24 4359 2512 nn7,
N56 4363 2511,

N9  4367 2550 en9,
N41 4366 2554,
N27 4370 2528 nn9,
N59 4374 2527,
N28 4370 2520 nn9,
N60 4374 2519,

N10 4378 2550 en10,
N42 4377 2554,
N29 4381 2536 nn10,
N61 4385 2535,
N30 4381 2520 nn10,
N62 4385 2519,
]])

route(nl, 0, 0, [[
n5  4277 2488 4277 2496,
n2  4277 2504 4277 2512,
n11 4277 2520 4277 2528,
n8  4277 2536 4277 2544,

i0  4270 2532,
i1  4270 2516,
i2  4270 2500,
i3  4270 2484,
]])

inline.i0 = nl.n0
inline.i1 = nl.n1
inline.i2 = nl.n3
inline.i3 = nl.n4
inline.i4 = nl.n6
inline.i5 = nl.n7
inline.i6 = nl.n9
inline.i7 = nl.n10

dofile("rom-exp.lua")

n = nodes_rect(3330, 2430, 3480, 1400)

for i=0,9 do
   nl = match(n, "A=d(v,o,o) V=vcc(v)", { o = osc.mod[i] })
   local y = 2400 - 100 * i
   local x0 = 3334
   move(nl, x0, y, "A 0 0 wo, V 1 4")
   osc.mod[i]:route(3320 - 2*i, y)
   for j=0,7 do
      local x = x0 + j*9
      if j>0 then
	 x = x + 4
      end
      nl = match(n, "A=t(o,s,a) B=t(a,i,g) G=gnd(g)", { o = osc.mod[i], s = osc.mod_shift[j] })
      nl.s:route(x+8, y-8)
      move(nl, x, y, "A 2 -8 ea, B 2 -16 eg, G 1 -20")
      if j > 0 then
	 if i+j < 12 then
	    if i < 9 then
	       nl.i:route(x+6, y-25-2*j, x-3, y-25-2*j)
	    end
	 elseif i+j == 12 then
	    if j < 7 then
	       nl.i:route(x+6, y-2, x+6, y-6, x+6, y-10)
	    end
	 else
	    nl.i:route(x+2, y-2, x+6, y-2, x+6, y-6, x+6, y-10)
	    if i+j == 13 then
	       nl.i:route(x+6, y+10)
	    end
	 end
      else
	 if i > 1 then
	    nl.i:route(x+6, y+75, x+10, y+75)
	 end
      end
      if j == 0 then
	 osc.pre_shift[i+1] = nl.i
      elseif i == 8 and j < 5 then
	 osc.pre_shift[j+10] = nl.i
      end
   end      
end

osc.pre_shift[ 1]:route(3524, 2398, 3340, 2398)
osc.pre_shift[ 2]:route(3524, 2298, 3340, 2298)
osc.pre_shift[ 3]:route(3340, 2220)
osc.pre_shift[ 4]:route(3340, 2150)
osc.pre_shift[ 5]:route(3524, 2098, 3344, 2098)
osc.pre_shift[ 6]:route(3344, 2010)
osc.pre_shift[ 7]:route(3344, 1940)
osc.pre_shift[ 8]:route(3524, 1898, 3353, 1898)
osc.pre_shift[ 9]:route(3353, 1800)
osc.pre_shift[10]:route(3353, 1730)
osc.pre_shift[11]:route(3353, 1660)
osc.pre_shift[12]:route(3524, 1600, 3362, 1600)
osc.pre_shift[13]:route(3362, 1520)
osc.pre_shift[14]:route(3524, 1498)

local xi1 = {}
local xi2 = {}

n = nodes_rect(3540, 2355, 3560, 1400)
n1 = nodes_rect(3570, 2430, 3660, 1400)
for i=1,14 do
   osc.pre_shift[i]:set_name("osc.pre_shift." .. i)
   nl = match(n, "A=d(v,o,o) B=t(o,s,g) C=t(s,c,i) V=vcc(v) G=gnd(g) G1=gnd(g1) C1=c(s, g1)", { o=osc.pre_shift[i] })
   local x = 3528
   local y = 2430 - 70 * i
   move(nl, x, y, "A 0 0 wo, V 1 4, B 6 0 eg, G 5 -4, C 16 1 ns, C1 10 -1 ng1, G1 10 -2")
   route(nl, x, y, "o 3 -4 3 4, c 12 5")

   if i ~= 15 then
      nl = adder2cr(n1, 3580, y-33, i ~= 14, { out = nl.i })
      xi1[i] = nl.i1
      xi2[i] = nl.i2
   end
end

nl = adder20r(n1, 3580, 2430-33, true)
xi1[0] = nl.i1
xi2[0] = nl.i2

local xj1 = {}
local xj2 = {}

n = nodes_rect(3610, 2430, 3650, 1410)
for i=0,13 do
   local y = 2430 - 70 * i

   nl = match(n, [[
A=d(f, d, d)
B=d(g, e, e)
C=t(d, i2, h)
D=t(e, i1, i)
E=t(d, a, o2)
F=t(e, a, o1)
G=vcc(f)
H=vcc(g)
I=gnd(h)
J=gnd(i)
]], { o1 = xi1[i], o2 = xi2[i] })

   move(nl, 0, y, [[
E 3600  -7 no2,
A 3610  -8 wd,
G 3611  -4,
C 3616  -8 eh,
I 3615 -12,

F 3600 -40 no1,
B 3610 -41 we,
H 3611 -37,
D 3616 -41 ei,
J 3615 -45,
]])

   route(nl, 0, y, [[
a 3596 -36 3596 -3,
d 3613 -4 3613 -12,
e 3613 -37 3613 -45,
]])

   xj1[i] = nl.i1
   xj2[i] = nl.i2
end

local y = 2430 - 70 * 14

nl = match(n, [[
E=t(i2, a, o2)
F=t(i1, a, o1)
]], { o1 = xi1[14], o2 = xi2[14] })

move(nl, 0, y, [[
E 3600  -7 no2,
F 3600 -40 no1,
]])

route(nl, 0, y, [[
a 3596 -36 3596 -3,
i1 3606 -41,
]])

xj1[14] = nl.i1
xj2[14] = nl.i2

local xk = {{},{},{},{}}

n = nodes_rect(3650, 2430, 3730, 1470)
for i=0,13 do
   local y = 2430 - 70 * i

   nl = match(n, [[
A=d(j, o1, o1)
B=d(k, o2, o2)
C=t(e, i1, l)
D=t(m, i2, i)
E=t(n, i2, a)
F=t(b, i3, o)
G=t(p, i4, c)
H=t(o1, mc0, e)
I=t(o1, mc1, i)
J=t(o2, mc2, a)
K=t(o2, mc3, b)
L=t(o2, mc4, c)
M=vcc(j)
N=vcc(k)
O=gnd(l)
P=gnd(m)
Q=gnd(n)
R=gnd(o)
S=gnd(p)
]], { mc0 = osc.mid_control[0], mc1 = osc.mid_control[1], mc2 = osc.mid_control[2], mc3 = osc.mid_control[3], mc4 = osc.mid_control[4], o1 = xj1[i], o2 = xj2[i] })

   move(nl, 0, y, [[
B 3630  -8 wo2,
N 3631  -4,
J 3656 -11 no2,
K 3664 -21 no2,
L 3672 -31 no2,

A 3630 -41 wo1,
M 3631 -37,
H 3640 -44 no1,
I 3648 -54 no1,

D 3690 -54 ni,
P 3694 -55,
C 3690 -44 ne,
O 3694 -45,
G 3690 -31 nc,
S 3694 -32,
F 3690 -21 nb,
R 3694 -22,
E 3690 -11 na,
Q 3694 -12,
]])

   route(nl, 0, y, [[
o1  3636 -55,
o2  3652 -22 3652 -32,
mc0 3644 -40,
mc1 3652 -50,
mc2 3660  -7,
mc3 3668 -17,
mc4 3676 -27,
i2  3696 -50 3696 -7,
]])
   xk[1][i] = nl.i1
   xk[2][i] = nl.i2
   xk[3][i] = nl.i3
   xk[4][i] = nl.i4
end

for i=0,13 do
   local x = 3720
   local y = 2430 - 70 * i - 17

   n = nodes_rect(3730, 2430 - 68*i, 3840, 2350 - 68*i)

   local nl1 = srr(n, x, y, { o = xk[3][i] })
   local nl2 = srr(n, x+22, y, { o = nl1.i })
   local nl3 = srr(n, x+44, y, { o = nl2.i })
   local nl4 = srwr(n, x, y, 3, { i = nl3.i, o = nl1.o, C = nl3.C })
   nl1.c1:route(x-10, y-17, x-10, y, x-10, y+19)
   nl1.c2:route(x-8, y-19, x-8, y, x-8, y+17)
   nl4.inp:route(x+64, y-33)
   nl4.cw:route(x+71, y-19)
end

for i=0,13 do
   local x = 3820
   local y = 2430 - 70 * i - 17
   n = nodes_rect(3840, 2430 - 68*i, 3940, 2350 - 68*i)

   local nl1 = srr(n, x, y, { o = xk[4][i] })
   local nl2 = srr(n, x+22, y, { o = nl1.i })
   local nl3 = srr(n, x+44, y, { o = nl2.i })
   local nl4 = srwr(n, x, y, 3, { i = nl3.i, o = nl1.o, C = nl3.C })
   nl1.c1:route(x-10, y-17, x-10, y, x-10, y+19)
   nl1.c2:route(x-8, y-19, x-8, y, x-8, y+17)
   nl4.cw:route(x+64, y-19)
   nl4.o:route(x-2, y-25, x-142, y-25, x-142, y-10)
end

for i=0,13 do
   local x = 3920
   local y = 2430 - 70 * i - 17
   n = nodes_rect(3930, 2430 - 68*i, 4040, 2350 - 68*i)

   local nl1 = srr(n, x, y, { o = xk[1][i] })
   local nl2 = srr(n, x+22, y, { o = nl1.i })
   local nl3 = srr(n, x+44, y, { o = nl2.i })
   local nl4 = srwr(n, x, y, 3, { i = nl3.i, o = nl1.o, C = nl3.C })
   nl1.c1:route(x-10, y-17, x-10, y, x-10, y+19)
   nl1.c2:route(x-8, y-19, x-8, y, x-8, y+17)
   nl4.inp:route(x+64, y-33)
   nl4.o:route(x-2, y-23)
   nl4.cw:route(x+71, y-19)
end

for i=0,13 do
   local x = 4000
   local y = 2409 - 70 * i
   n = nodes_rect(4040, 2430 - 68*i, 4090, 2350 - 68*i)
   nl = match(n, [[
A=d(j, out, out)
B=d(k, h, h)
C=d(l, iout, iout)
D=t(out, g, m)
E=t(h, d, n)
F=t(iout, f, o)
G=t(out, a, f)
H=t(g, b, h)
I=t(d, a, inp)
J=vcc(j)
K=vcc(k)
L=vcc(l)
M=gnd(m)
N=gnd(n)
O=gnd(o)
G1=gnd(g1)
C1=c(f, g1)
G2=gnd(g2)
C2=c(g, g2)
G3=gnd(g3)
C3=c(d, g3)
]])

   move(nl, x, y, [[
C  0  8 wiout,
L  1 12,
F  2  0 eo,
O  1 -4,
C1 6 -1 ng1,
G1 6 -2,
G 10 -1 sf,

A 20  8 wout,
J 21 12,
D 22  0 em,
M 21 -4,
C2 26 -1 ng2,
G2 26 -2,
H 30 -1 sg,

B 40  8 wh,
K 41 12,
E 42  0 en,
N 41 -4,
C3 46 -1 ng3,
G3 46 -2,
I 50 -1 sd,
]])

   route(nl, x, y, [[
iout -4 8 -6 8 -6 -29,
out 14 8 14 -39 -490 -39,
h 34 8,
a 10 -19 -23 -19 -23 -13 50 -19,
b 30 -21 10 -21 -25 -21,
]])

   nl.out:set_name("osc_out."..i)
end

for i=0,13 do
   n = nodes_rect(4090, 2430 - 68*i, 4130, 2350 - 68*i)
   adder1cr(n, 4120, 2376 - 70*i, i ~= 13)
end

for i=0,13 do
   n = nodes_rect(4120, 2430 - 68*i, 4185, 2350 - 68*i)

   nl = match(n, [[
A=d(j, f, f)
B=d(k, i, i)
C=t(f, i, l)
D=t(m, d, i)
E=t(n, g, i)
F=t(o, d, b)
G=t(f, a, e)
H=t(f, g, b)
J=vcc(j)
K=vcc(k)
L=gnd(l)
M=gnd(m)
N=gnd(n)
O=gnd(o)
]])

   move(nl, 4130, 2360 - 70*i, [[
G  0 46 se,
A  8 47 wf,
J  9 51,
C 10 39 el,
L  9 35,
H 17 39 eb,
F 17 31 eo,
O 16 27,
B 18 18 wi,
K 19 22,
D 20 10 em,
M 19  6,
E 27 10 en,
N 26  6,
]])

   route(nl, 4130, 2360 - 70*i, [[
a -4 42,
d 24 31,
g 31 39 31 29 31 19,
]])
end

for i=0,12 do
   n = nodes_rect(4170, 2430 - 68*i, 4220, 2350 - 68*i)
   nl = match(n, [[
A=t(b, i1, c)
B=t(c, i0, d)
C=t(c, i2, e)
D=t(c, i3, a)
]], inline)

   move(nl, 4180, 2360 - 70*i, [[
B  0 38 sc,
A 10 30 sc,
C 20 22 sc,
D 30 14 sc,
]])

   route(nl, 4180, 2360 - 70*i, [[
c -4 31 2 31 -4 23 0 23 7 23 -4 15 9 15 3 15,
i0  6 34,
i1 16 26,
i2 26 18,
i3 36 10,
]])

   local nl1 = match(n, "G=gnd(a)", nl)
   if nl1 then
      nl1.G:move(4214, 2375 - 70*i)
   else
      nl.a:route(4236 + 2*i, 2375 - 70*i)
   end
   local nl1 = match(n, "G=gnd(e)", nl)
   if nl1 then
      nl1.G:move(4204, 2383 - 70*i)
   else
      nl.e:route(4228 + 2*i, 2383 - 70*i)
   end
   local nl1 = match(n, "G=gnd(b)", nl)
   if nl1 then
      nl1.G:move(4194, 2391 - 70*i)
   else
      nl.b:route(4220 + 2*i, 2391 - 70*i, 4220 + 2*i, 2119 - 70*i)
   end
end

for i=0,12 do
   n = nodes_rect(4270, 2430 - 68*i, 4310, 2350 - 68*i)
   nl = match(n, [[
A=t(b, i5, c)
B=t(c, i4, d)
C=t(c, i6, e)
D=t(c, i7, a)
]], inline)

   move(nl, 4270, 2360 - 70*i, [[
B  0 38 sc,
A 10 30 sc,
C 20 22 sc,
D 30 14 sc,
]])

   route(nl, 4270, 2360 - 70*i, [[
c -4 31 2 31 -4 23 0 23 7 23 -4 15 9 15 3 15,
i4  6 34,
i5 16 26,
i6 26 18,
i7 36 10,
]])

   local nl1 = match(n, "G=gnd(a)", nl)
   if nl1 then
      nl1.G:move(4304, 2375 - 70*i)
   else
      nl.a:route(4312 + 2*i, 2375 - 70*i)
   end
   local nl1 = match(n, "G=gnd(e)", nl)
   if nl1 then
      nl1.G:move(4294, 2383 - 70*i)
   else
      nl.e:route(4310 + 2*i, 2383 - 70*i)
   end
   local nl1 = match(n, "G=gnd(b)", nl)
   if nl1 then
      nl1.G:move(4284, 2391 - 70*i)
   else
      nl.b:route(4308 + 2*i, 2391 - 70*i)
   end
   local nl1 = match(n, "G=gnd(d)", nl)
   if nl1 then
      nl1.G:move(4274, 2399 - 70*i)
   else
      nl.d:route(4306 + 2*i, 2399 - 70*i)
   end
end

inline.i0:route(4186, 2450, 4300, 2450)
inline.i1:route(4196, 2448, 4311, 2448)
inline.i2:route(4206, 2446, 4322, 2446)
inline.i3:route(4216, 2444, 4333, 2444)
inline.i4:route(4276, 2442, 4344, 2442)
inline.i5:route(4286, 2440, 4355, 2440)
inline.i6:route(4296, 2438, 4366, 2438)
inline.i7:route(4306, 2436, 4377, 2436)

for i=0,9 do
   n = nodes_rect(4340, 2430 - 68*i, 4370, 2350 - 68*i)
   nl = match(n, [[
A=d(e, d, d)
B=t(d, b, f)
C=t(c, a, b)
D=vcc(e)
E=gnd(f)
F=gnd(g)
G=c(b, g)
]])

   move(nl, 4340, 2360 - 70*i, [[
A  0 23 wd,
D  1 27,
B  2 15 ef,
E  1 11,
G  6 14 ng,
F  6 13,
C 12 16 nb,
]])

   route(nl, 4340, 2360 - 70*i, [[
a  8 20,
]])
end   

n = nodes_rect(4320, 1610, 4330, 1590)
nl = match(n, [[
A=d(b, a, a)
B=vcc(b)
]])

move(nl, 0, 0, [[
A 4340 1683 wa,
B 4341 1687,
]])

for i=0,2 do
   n = nodes_rect(4370, 2430 - 68*i, 4460, 2350 - 68*i)
   if i == 0 then
      nl = adder20r(n, 4400, 2380 - 70*i, true)
   else
      nl = adder2cr(n, 4400, 2380 - 70*i, true)
   end
   nl.out:route(4365, 2413 - 70*i, 4365, 2375 - 70*i)

   n = nodes_rect(4410, 2430 - 68*i, 4470, 2350 - 68*i)
   nl = match(n, [[
A=d(i, g, g)
B=d(j, h, h)
C=t(k, b, g)
D=t(g, d, l)
E=t(m, c, h)
F=t(h, a, e)
G=t(g, a, f)
H=vcc(i)
I=vcc(j)
J=gnd(k)
K=gnd(l)
L=gnd(m)
]])

   move(nl, 4420, 2380 - 70*i, [[
G  0  26 nf,
A  8  25 wg,
H  9  29,
D 14  17 el,
K 13  13,
C 10   9 ek,
J  9   5,

F  0  -7 ne,
B  8  -8 wh,
I  9  -4,
E 16  -8 em,
L 15 -12,
]])

   route(nl, 4420, 2380 - 70*i, [[
a -4 30 -4 -3,
h 12 -12 12 -4,
b 20 9 70 9 120 9 170 9,
]])
end

for i=3,9 do
   n = nodes_rect(4370, 2430 - 68*i, 4470, 2350 - 68*i)
   nl = adder1cr(n, 4400, 2380 - 70*i, i ~= 9)
   nl.out:route(4365, 2413 - 70*i, 4365, 2375 - 70*i)

   n = nodes_rect(4410, 2430 - 68*i, 4470, 2350 - 68*i)
   nl = match(n, [[
B=d(j, h, h)
E=t(m, c, h)
F=t(h, a, e)
I=vcc(j)
L=gnd(m)
]], { e = nl.i1 })

   move(nl, 4420, 2380 - 70*i, [[
F  0  -7 ne,
B  8  -8 wh,
I  9  -4,
E 16  -8 em,
L 15 -12,
]])

   route(nl, 4420, 2380 - 70*i, [[
a -4 30 -4 -3,
h 12 -12 12 -4,
]])
end

n = nodes_rect(3830, 2520, 3900, 2450)
n = merge(n, nodes_rect(4070, 2450, 4160, 2425))
nl = match(n, [[
N0=d(n3, n3, n14)
N1=d(n4, n4, n15)
N2=d(n5, n5, n16)
N3=d(n17, n6, n6)
N4=d(n18, n7, n7)
N5=d(n12, n12, n19)
N6=t(n3, n11, n20)
N7=t(n4, n10, n21)
N8=t(n5, n9, n22)
N9=t(n6, n7, n23)
N10=t(n7, n8, n24)
N11=t(n25, n7, n12)
N12=t(n2, n1, n10)
N13=t(n3, n0, n8)
N14=t(n4, n0, n9)
N15=t(n5, n1, n11)
N16=t(n6, n1, n13)
N17=vcc(n14)
N18=vcc(n15)
N19=vcc(n16)
N20=vcc(n17)
N21=vcc(n18)
N22=vcc(n19)
N23=gnd(n20)
N24=gnd(n21)
N25=gnd(n22)
N26=gnd(n23)
N27=gnd(n24)
N28=gnd(n25)
]])

move(nl, 0, 0, [[
N5  4148 2420 en12,
N22 4147 2424,
N11 4142 2420 wn25,
N28 4143 2416,
N16 4111 2412 en13,

N9  3883 2527 wn23,
N26 3884 2523,
N3  3883 2535 wn6,
N20 3884 2539,
]])

route(nl, 0, 0, [[
n12 4145 2416 4145 2424 4154 2420,
n1  4126 2412,
n7  3879 2520 4020 2520 4020 2434 4108 2434 4108 2420,
n6  3886 2531 3886 2522 4022 2522 4022 2436 4110 2436,
]])

single_inv_r(n, 3840, 2520, { inp = nl.n2 })
single_inv_r(n, 3851, 2520, { inp = nl.n4 })
single_inv_r(n, 3862, 2520, { inp = nl.n5 })
single_inv_r(n, 3873, 2520, { inp = nl.n3 })

osc.phi0:route(3596, 2430, 3599, 2430, 3650, 2430, 3730, 2430, 3750, 2430, 3770, 2430, 3790, 2430, 3840, 2430, 3860, 2430, 3880, 2430, 3940, 2430, 3960, 2430, 3980, 2430, 4114, 2430, 4115, 2430, 4040, 2430, 4010, 2430, 3843, 2430, 3843, 2512, 3844, 2512, 3866, 2512, 4348, 2430, 4224, 2430, 4170, 2430, 4416, 2430, 3598, 2427)
osc.phi1:route(3540, 2445, 3611, 2432, 3650, 2432, 3730, 2432, 3745, 2432, 3745, 2447, 3770, 2432, 3790, 2432, 3840, 2432, 3860, 2432, 3880, 2432, 3940, 2432, 3960, 2432, 3980, 2432, 3845, 2432, 3845, 2447, 3845, 2514, 3855, 2514, 3877, 2514, 4348, 2432, 4248, 2432, 4050, 2432, 4020, 2432, 4000, 2432, 4030, 2390, 3990, 2390)

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
