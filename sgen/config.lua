function adder2cl(n, x, y, link, c)
   local nl = match(n, [[
N0=d(out, out, l)
N1=d(m, h, h)
N2=d(n, oc, oc)
N3=t(o, i1, d)
N4=t(p, ic, g)
N5=t(q, i2, g)
N6=t(r, i1, g)
N7=t(s, i2, i)
N8=t(t, i1, i)
N9=t(u, h, oc)
N10=t(v, i1, k)
N11=t(d, i2, e)
N12=t(e, ic, out)
N13=t(g, h, out)
N14=t(h, ic, i)
N15=t(k, i2, h)
N16=vcc(l)
N17=vcc(m)
N18=vcc(n)
N19=gnd(o)
N20=gnd(p)
N21=gnd(q)
N22=gnd(r)
N23=gnd(s)
N24=gnd(t)
N25=gnd(u)
N26=gnd(v)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   local nl2 = match(n, [[
N28=gnd(c2)
N30=c(i2, c2)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 -8  9 nc1,
N27 -8  8,
]])
   end

   if(nl2) then
      move(nl2, x, y, [[
N30 -8 -1 nc2,
N28 -8 -2,
]])
   end

   move(nl, x, y, [[
N10  0  -8 wv,
N26  1 -12,
N8   7  -8 wt,
N24  8 -12,
N7  14  -8 ws,
N23 15 -12,
N15  0   0 wk,
N14 14   0 wi,
N1  20   8 eh,
N17 19  12,

N3   0 17 wo,
N19  1 13,
N6   7 17 wr,
N22  8 13,
N4  14 17 wp,
N20 15 13,
N5  23 17 wq,
N21 24 13,
N11  0 25 wd,
N12  5 28 se,
N13 23 25 wg,
N0  25 33 eout,
N16 24 37,

N9  21 -10 wu,
N25 22 -14,
N2  23  -2 eoc,
N18 22   2,
]])

   route(nl, x, y, [[
ic 10 24,
i1 -4 10 0 10 3 10 -4 -15 0 -15 3 -15,
i2 -6 -17 0 -17 10 -17 -6 0 -6 25 -6 31 19 31,
h  17 25 17 4,
]])

   if link then
      nl.oc:route(x+29, y-2, x+29, y-19, x+10, y-19)
   end

   return nl
end

function adder2cil(n, x, y, c)
   local nl = match(n, [[
N0=d(out, out, l)
N1=d(m, oc, oc)
N3=t(o, i1, d)
N4=t(p, ic, g)
N5=t(q, i2, g)
N6=t(r, i1, g)
N7=t(s, i2, i)
N8=t(t, i1, i)
N10=t(v, i1, k)
N11=t(d, i2, e)
N12=t(e, ic, out)
N13=t(g, oc, out)
N14=t(oc, ic, i)
N15=t(k, i2, oc)
N16=vcc(l)
N17=vcc(m)
N19=gnd(o)
N20=gnd(p)
N21=gnd(q)
N22=gnd(r)
N23=gnd(s)
N24=gnd(t)
N26=gnd(v)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   local nl2 = match(n, [[
N28=gnd(c2)
N30=c(i2, c2)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 -8  9 nc1,
N27 -8  8,
]])
   end

   if(nl2) then
      move(nl2, x, y, [[
N30 -8 -1 nc2,
N28 -8 -2,
]])
   end

   move(nl, x, y, [[
N10  0  -8 wv,
N26  1 -12,
N8   7  -8 wt,
N24  8 -12,
N7  14  -8 ws,
N23 15 -12,
N15  0   0 wk,
N14 14   0 wi,
N1  20   8 eoc,
N17 19  12,

N3   0 17 wo,
N19  1 13,
N6   7 17 wr,
N22  8 13,
N4  14 17 wp,
N20 15 13,
N5  23 17 wq,
N21 24 13,
N11  0 25 wd,
N12  5 28 se,
N13 23 25 wg,
N0  25 33 eout,
N16 24 37,
]])

   route(nl, x, y, [[
ic 10 24,
i1 -4 10 0 10 3 10 -4 -15 0 -15 3 -15,
i2 -6 -17 0 -17 10 -17 -6 0 -6 25 -6 31 19 31,
oc  17 25 17 4,
]])

   return nl
end

function adder20l(n, x, y, link, c)
   local nl = match(n, [[
N0=d(out, out, l)
N1=d(m, h, h)
N2=d(n, oc, oc)
N3=t(o, i1, d)
N4=t(p, p, g)
N5=t(q, i2, g)
N6=t(r, i1, g)
N7=t(s, i2, i)
N8=t(t, i1, i)
N9=t(u, h, oc)
N10=t(v, i1, k)
N11=t(d, i2, e)
N12=t(e, ic1, out)
N13=t(g, h, out)
N14=t(h, ic2, i)
N15=t(k, i2, h)
N16=vcc(l)
N17=vcc(m)
N18=vcc(n)
N19=gnd(o)
N20=gnd(p)
N21=gnd(q)
N22=gnd(r)
N23=gnd(s)
N24=gnd(t)
N25=gnd(u)
N26=gnd(v)
NC1=gnd(ic1)
NC2=gnd(ic2)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   local nl2 = match(n, [[
N28=gnd(c2)
N30=c(i2, c2)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 -8  9 nc1,
N27 -8  8,
]])
   end

   if(nl2) then
      move(nl2, x, y, [[
N30 -8 -1 nc2,
N28 -8 -2,
]])
   end

   move(nl, x, y, [[
N10  0  -8 wv,
N26  1 -12,
N8   7  -8 wt,
N24  8 -12,
N7  14  -8 ws,
N23 15 -12,
N15  0   0 wk,
N14 14   0 wi,
NC2 10   0,
N1  20   8 eh,
N17 19  12,

N3   0 17 wo,
N19  1 13,
N6   7 17 wr,
N22  8 13,
N4  14 17 wp,
N20 15 13,
N5  23 17 wq,
N21 24 13,
N11  0 25 wd,
N12  5 28 se,
NC1  5 24,
N13 23 25 wg,
N0  25 33 eout,
N16 24 37,

N9  21 -10 wu,
N25 22 -14,
N2  23  -2 eoc,
N18 22   2,
]])

   route(nl, x, y, [[
i1 -4 10 0 10 3 10 -4 -15 0 -15 3 -15,
i2 -6 -17 0 -17 10 -17 -6 0 -6 25 -6 31 19 31,
h  17 25 17 4,
]])

   if link then
      nl.oc:route(x+29, y-2, x+29, y-19, x+10, y-19)
   end

   return nl
end

function adder1cl(n, x, y, link, c)
   local nl = match(n, [[
A=d(i, out, out)
B=d(e, e, b)
C=d(c, oc, oc)
D=t(g, e, out)
E=t(j, i1, f)
F=t(k, ic, g)
G=t(l, i1, g)
H=t(m, e, oc)
I=t(e, ic, f)
J=vcc(b)
K=vcc(c)
L=vcc(i)
M=gnd(j)
N=gnd(k)
O=gnd(l)
P=gnd(m)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 6  -1 nc1,
N27 6  -2,
]])
   end

   move(nl, x, y, [[
F 14  17 wk,
N 15  13,
E 14  -8 wj,
M 15 -12,
I 14   0 wf,
B 20   8 ee,
J 19  12,

G 23  17 wl,
O 24  13,
D 23  25 wg,
A 25  33 eout,
L 24  37,

H 21 -10 wm,
P 22 -14,
C 23  -2 eoc,
K 22   2,
]])

   route(nl, x, y, [[
ic 10 24,
i1 8 -8 8 0 8 25 8 31 19 31,
e  17 25 17 4,
]])

   if link then
      nl.oc:route(x+29, y-2, x+29, y-19, x+10, y-19)
   end

   return nl
end

function adder1cil(n, x, y, c)
   local nl = match(n, [[
A=d(i, out, out)
B=d(oc, oc, b)
D=t(g, oc, out)
E=t(j, i1, f)
F=t(k, ic, g)
G=t(l, i1, g)
I=t(oc, ic, f)
J=vcc(b)
L=vcc(i)
M=gnd(j)
N=gnd(k)
O=gnd(l)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 6  -1 nc1,
N27 6  -2,
]])
   end

   move(nl, x, y, [[
F 14  17 wk,
N 15  13,
E 14  -8 wj,
M 15 -12,
I 14   0 wf,
B 20   8 eoc,
J 19  12,

G 23  17 wl,
O 24  13,
D 23  25 wg,
A 25  33 eout,
L 24  37,
]])

   route(nl, x, y, [[
ic 10 24,
i1 8 -8 8 0 8 25 8 31 19 31,
oc  17 25 17 4,
]])

   return nl
end

function adder2cr(n, x, y, link, c)
   local nl = match(n, [[
N0=d(out, out, l)
N1=d(m, h, h)
N2=d(n, oc, oc)
N3=t(o, i1, d)
N4=t(p, ic, g)
N5=t(q, i2, g)
N6=t(r, i1, g)
N7=t(s, i2, i)
N8=t(t, i1, i)
N9=t(u, h, oc)
N10=t(v, i1, k)
N11=t(d, i2, e)
N12=t(e, ic, out)
N13=t(g, h, out)
N14=t(h, ic, i)
N15=t(k, i2, h)
N16=vcc(l)
N17=vcc(m)
N18=vcc(n)
N19=gnd(o)
N20=gnd(p)
N21=gnd(q)
N22=gnd(r)
N23=gnd(s)
N24=gnd(t)
N25=gnd(u)
N26=gnd(v)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   local nl2 = match(n, [[
N28=gnd(c2)
N30=c(i2, c2)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 8 -9 nc1,
N27 8 -10,
]])
   end

   if(nl2) then
      move(nl2, x, y, [[
N30 8 24 nc2,
N28 8 23,
]])
   end

   move(nl, x, y, [[
N10  -0  -8 ev,
N26  -1 -12,
N8   -7  -8 et,
N24  -8 -12,
N7  -14  -8 es,
N23 -15 -12,
N15  -0   0 ek,
N14 -14   0 ei,
N1  -20   8 wh,
N17 -19  12,

N3   -0 17 eo,
N19  -1 13,
N6   -7 17 er,
N22  -8 13,
N4  -14 17 ep,
N20 -15 13,
N5  -23 17 eq,
N21 -24 13,
N11  -0 25 ed,
N12  -5 28 sout,
N13 -23 25 eg,
N0  -25 33 wout,
N16 -24 37,

N9  -21 -10 eu,
N25 -22 -14,
N2  -23  -2 woc,
N18 -22   2,
]])

   route(nl, x, y, [[
ic -10 24,
i1 4 10 0 10 -3 10 4 -15 0 -15 -3 -15,
i2 6 -17 0 -17 -10 -17 6 0 6 25 6 31 -19 31,
h  -17 25 -17 4,
]])

   if link then
      nl.oc:route(x-29, y-2, x-29, y-19, x-10, y-19)
   end

   return nl
end

function adder20r(n, x, y, link, c)
   local nl = match(n, [[
N0=d(out, out, l)
N1=d(m, h, h)
N2=d(n, oc, oc)
N3=t(o, i1, d)
N4=t(p, p, g)
N5=t(q, i2, g)
N6=t(r, i1, g)
N7=t(s, i2, i)
N8=t(t, i1, i)
N9=t(u, h, oc)
N10=t(v, i1, k)
N11=t(d, i2, e)
N12=t(e, ic1, out)
N13=t(g, h, out)
N14=t(h, ic2, i)
N15=t(k, i2, h)
N16=vcc(l)
N17=vcc(m)
N18=vcc(n)
N19=gnd(o)
N20=gnd(p)
N21=gnd(q)
N22=gnd(r)
N23=gnd(s)
N24=gnd(t)
N25=gnd(u)
N26=gnd(v)
NC1=gnd(ic1)
NC2=gnd(ic2)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   local nl2 = match(n, [[
N28=gnd(c2)
N30=c(i2, c2)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 8 -9 nc1,
N27 8 -10,
]])
   end

   if(nl2) then
      move(nl2, x, y, [[
N30 8 24 nc2,
N28 8 23,
]])
   end

   move(nl, x, y, [[
N10   0  -8 ev,
N26  -1 -12,
N8   -7  -8 et,
N24  -8 -12,
N7  -14  -8 es,
N23 -15 -12,
N15   0   0 ek,
N14 -14   0 ei,
NC2 -10   0,
N1  -20   8 wh,
N17 -19  12,

N3    0 17 eo,
N19  -1 13,
N6   -7 17 er,
N22  -8 13,
N4  -14 17 ep,
N20 -15 13,
N5  -23 17 eq,
N21 -24 13,
N11   0 25 ed,
N12  -5 28 sout,
NC1  -5 24,
N13 -23 25 eg,
N0  -25 33 wout,
N16 -24 37,

N9  -21 -10 eu,
N25 -22 -14,
N2  -23  -2 woc,
N18 -22   2,
]])

   route(nl, x, y, [[
i1 4 10 0 10 -3 10 4 -15 0 -15 -3 -15,
i2 6 -17 0 -17 -10 -17 6 0 6 25 6 31 -19 31,
h  -17 25 -17 4,
]])

   if link then
      nl.oc:route(x-29, y-2, x-29, y-19, x-10, y-19)
   end

   return nl
end

function srr(n, x, y, c)
   local nl = match(n, [[
N5=d(n21, o, o)
N25=vcc(n21)
N11=t(o, n2, n27)
N31=gnd(n27)
N12=t(n11, c1, n2)
G1=gnd(g1)
C1=c(n2, g1)

N0=d(n11, n11, n16)
N20=vcc(n16)
N6=t(n11, n6, n22)
N26=gnd(n22)
C=t(i, c2, n6)
G2=gnd(g2)
C2=c(n6, g2)
]], c)

   move(nl, x, y, [[
N5   1   4 eo,
N25  0   8,
N11  1  -4 en27,
N31  0  -8,
N12  4 -11 wn11,
C1   7  -5 ng1,
G1   7  -6,

N0  12   4 en11,
N20 11   8,
N6  12  -4 en22,
N26 11  -8,
C   15 -11 wi,
C2  18  -5 ng2,
G2  18  -6,
]])

   route(nl, x, y, [[
o   -2 0,
n11  9 -15  9 0,
i   20 -15,
c1   0 -17,
c2  11 -19,
]])

   return nl
end

function srwr(n, x, y, count, c)
   local nl = match(n, [[
N17=t(i, cl, o)
N18=t(i, cw, inp)
C=t(i,a,b)
]], c)

   move(nl, x + count*22, y, [[
N17 -1   4 ei,
N18 -1 -19 einp,
]])

   route(nl, x + count*22, y, "o -2 11")
   route(nl, x, y, "o -2 0 -2 9 -2 11 10 11")

   return nl
end

function adder1cr(n, x, y, link, c)
   local nl = match(n, [[
A=d(i, out, out)
B=d(e, e, b)
C=d(c, oc, oc)
D=t(g, e, out)
E=t(j, i1, f)
F=t(k, ic, g)
G=t(l, i1, g)
H=t(m, e, oc)
I=t(e, ic, f)
J=vcc(b)
K=vcc(c)
L=vcc(i)
M=gnd(j)
N=gnd(k)
O=gnd(l)
P=gnd(m)
]], c)

   local nl1 = match(n, [[
N27=gnd(c1)
N29=c(i1, c1)
]], nl)

   if(nl1) then
      move(nl1, x, y, [[
N29 -6 -9 nc1,
N27 -6 -10,
]])
   end

   move(nl, x, y, [[
F -14  17 ek,
N -15  13,
E -14  -8 ej,
M -15 -12,
I -14   0 ef,
B -20   8 we,
J -19  12,

G -23  17 el,
O -24  13,
D -23  25 eg,
A -25  33 wout,
L -24  37,

H -21 -10 em,
P -22 -14,
C -23  -2 woc,
K -22   2,
]])

   route(nl, x, y, [[
ic -10 24,
i1 -8 -8 -8 0 -8 25 -8 31 -19 31,
e  -17 25 -17 4,
]])

   if link then
      nl.oc:route(x-29, y-2, x-29, y-19, x-10, y-19)
   end

   return nl
end

function single_inv_r(n, x, y, c)
   local nl = match(n, [[
A=t(inp, a, b)
B=t(g, b, out)
C=d(v, out, out)
G=gnd(g)
V=vcc(v)
G1=gnd(g1)
C1=c(b, g1)
]], c)

   move(nl, x, y, [[
A  0  0 einp,
C1 -3 6 ng1,
G1 -3 5,
B  3  7 wg,
G  4  3,
C  3 15 wout,
V  4 19,
]])

   route(nl, x, y, [[
inp -5 -4,
out 6 11,
]])

   return nl
end
