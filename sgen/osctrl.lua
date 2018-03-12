local function inverted_clocked_amp(n, x, y)
   local nl = match(n, [[
A=t(g, d, out)
B=d(h, d, d)
C=d(i, e, e)
D=t(out, f, j)
E=t(d, f, k)
F=t(e, inp, l)
G=t(e, clk, f)
H=vcc(g)
I=vcc(h)
J=vcc(i)
K=gnd(j)
L=gnd(k)
M=gnd(l)
N=c(a, f)
O=gnd(a)
]])

   move(nl, x, y, [[
A  1  8 eout,
H  0 12,
D  1  0 ej,
K  0 -4,

B  9  8 wd,
I 10 12,
E  9  0 wk,
L 10 -4,

G 10 -8 sf,
N  5 -8,
O  5 -9,

C 17  8 ee,
J 16 12,
F 17  0 el,
M 16 -4,
]])

   route(nl, x, y, [[
f  5 -7,
e  14 4,
clk -5 -12,
]])

   return nl
end

local function inverted_clocked_amp_nocaps(n, x, y)
   local nl = match(n, [[
A=t(g, d, out)
B=d(h, d, d)
C=d(i, e, e)
D=t(out, f, j)
E=t(d, f, k)
F=t(e, inp, l)
G=t(e, clk, f)
H=vcc(g)
I=vcc(h)
J=vcc(i)
K=gnd(j)
L=gnd(k)
M=gnd(l)
]])

   move(nl, x, y, [[
A  1  8 eout,
H  0 12,
D  1  0 ej,
K  0 -4,

B  9  8 wd,
I 10 12,
E  9  0 wk,
L 10 -4,

G 10 -8 sf,

C 17  8 ee,
J 16 12,
F 17  0 el,
M 16 -4,
]])

   route(nl, x, y, [[
f  5 -7,
e  14 4,
clk -5 -12,
]])

   return nl
end

local n

n = nodes_rect(4950, 2560, 4990, 2490)
inverted_clocked_amp(n, 4800, 2590)

n = nodes_rect(4765, 2560, 4825, 2525)
inverted_clocked_amp(n, 4800, 2550)

n = nodes_rect(4895, 2560, 4930, 2490)
inverted_clocked_amp(n, 4800, 2510)

n = nodes_rect(4765, 2620, 4825, 2585)
inverted_clocked_amp(n, 4800, 2620)

n = nodes_rect(4860, 2560, 4895, 2490)
inverted_clocked_amp(n, 4800, 2650)


n = nodes_rect(4840, 2675, 4980, 2560)
nl = match(n, [[
N0=d(n30, n15, n15)
N1=d(n31, n17, n17)
N2=d(n32, n21, n21)
N3=d(n33, n23, n23)
N4=d(n34, n27, n27)
N5=t(n16, n5, n35)
N6=t(n16, n6, n36)
N7=t(n37, n9, n16)
N8=t(n38, n8, n18)
N9=t(n39, n5, n19)
N10=t(n40, n4, n20)
N11=t(n41, n6, n20)
N12=t(n42, n8, n20)
N13=t(n43, n9, n20)
N14=t(n22, n3, n44)
N15=t(n45, n4, n22)
N16=t(n46, n6, n22)
N17=t(n47, n8, n22)
N18=t(n48, n10, n22)
N19=t(n23, n12, n49)
N20=t(n50, n9, n24)
N21=t(n51, n10, n24)
N22=t(n52, n5, n25)
N23=t(n53, n10, n25)
N24=t(n54, n3, n26)
N25=t(n55, n4, n26)
N26=t(n56, n10, n26)
N27=t(n57, n11, n26)
N28=t(n58, n14, n27)
N29=t(n59, n3, n28)
N30=t(n60, n10, n28)
N31=t(n61, n11, n28)
N32=t(n62, n11, n29)
N34=t(n15, n14, n16)
N35=t(n15, n7, n18)
N36=t(n17, n7, n19)
N37=t(n21, n7, n20)
N38=t(n21, n2, n22)
N39=t(n23, n14, n24)
N40=t(n23, n7, n25)
N41=t(n27, n12, n26)
N42=t(n27, n7, n28)
N43=t(n27, n2, n29)
N44=vcc(n30)
N45=vcc(n31)
N46=vcc(n32)
N47=vcc(n33)
N48=vcc(n34)
N49=gnd(n35)
N50=gnd(n36)
N51=gnd(n37)
N52=gnd(n38)
N53=gnd(n39)
N54=gnd(n40)
N55=gnd(n41)
N56=gnd(n42)
N57=gnd(n43)
N58=gnd(n44)
N59=gnd(n45)
N60=gnd(n46)
N61=gnd(n47)
N62=gnd(n48)
N63=gnd(n49)
N64=gnd(n50)
N65=gnd(n51)
N66=gnd(n52)
N67=gnd(n53)
N68=gnd(n54)
N69=gnd(n55)
N70=gnd(n56)
N71=gnd(n57)
N72=gnd(n58)
N73=gnd(n59)
N74=gnd(n60)
N75=gnd(n61)
N76=gnd(n62)
]])

move(nl, 0, 0, [[
N4   4840 2510 wn27,
N48  4841 2514,

N3   4840 2550 wn23,
N47  4841 2554,

N2   4840 2590 wn21,
N46  4841 2594,

N1   4840 2620 wn17,
N45  4841 2624,

N0   4840 2650 wn15,
N44  4841 2654,

N43  4860 2507 nn27,
N42  4870 2518 nn27,
N41  4880 2529 nn27,
N28  4890 2540 nn27,
N72  4894 2539,

N40  4870 2547 nn23,
N19  4880 2558 nn23,
N63  4884 2557,
N39  4890 2569 nn23,

N38  4860 2587 nn21,
N37  4870 2598 nn21,

N36  4870 2617 nn17,

N35  4870 2647 nn15,
N34  4890 2658 nn15,

N32  4914 2502 wn62,
N76  4915 2498,

N31  4914 2513 wn61,
N75  4915 2509,
N29  4924 2513 wn59,
N73  4925 2509,
N30  4934 2513 wn60,
N74  4935 2509,

N27  4914 2524 wn57,
N71  4915 2520,
N24  4924 2524 wn54,
N68  4925 2520,
N26  4934 2524 wn56,
N70  4935 2520,
N25  4944 2524 wn55,
N69  4945 2520,

N23  4934 2542 wn53,
N67  4935 2538,
N22  4964 2542 wn52,
N66  4965 2538,

N21  4934 2564 wn51,
N65  4935 2560,
N20  4974 2564 wn50,
N64  4975 2560,

N14  4924 2582 wn44,
N58  4925 2578,
N18  4934 2582 wn48,
N62  4935 2578,
N15  4944 2582 wn45,
N59  4945 2578,
N17  4954 2582 wn47,
N61  4955 2578,
N16  4984 2582 wn46,
N60  4985 2578,

N10  4944 2593 wn40,
N54  4945 2589,
N12  4954 2593 wn42,
N56  4955 2589,
N13  4974 2593 wn43,
N57  4975 2589,
N11  4984 2593 wn41,
N55  4985 2589,

N9   4964 2612 wn39,
N53  4965 2608,

N8   4954 2642 wn38,
N52  4955 2638,

N5   4964 2653 wn35,
N49  4965 2649,
N7   4974 2653 wn37,
N51  4975 2649,
N6   4984 2653 wn36,
N50  4985 2649,
]])

route(nl, 0, 0, [[
n27  4850 2506 4850 2517 4850 2528 4850 2539 4870 2539 4863 2528 4857 2539 4857 2517,
n23  4850 2546 4850 2557 4850 2568 4860 2557 4870 2568 4855 2568,
n21  4850 2586 4850 2597,
n15  4850 2646 4850 2657 4870 2657 4860 2657 4855 2646,
n2   4856 2511 4856 2591,
n7   4866 2522 4866 2551 4866 2602 4866 2621 4866 2651,
n12  4876 2533 4876 2562,
n14  4886 2544 4886 2573 4886 2662,
]])

n = nodes_rect(4905, 2780, 4990, 2680)
n = merge(n, nodes_rect(4974, 2586, 4993, 2583))

nl = match(n, [[
N0=d(n18, n4, n4)
N1=d(n19, n5, n5)
N2=d(n20, n6, n6)
N3=d(n21, n7, n7)
N4=d(n22, n8, n8)
N5=d(n9, n9, n23)
N6=d(n10, n10, n24)
N7=d(n11, n11, n25)
N8=d(n12, n12, n26)
N9=d(n27, n14, n14)
N10=d(n28, n16, n16)
N11=t(n29, n13, n4)
N12=t(n4, n15, n30)
N13=t(n31, n16, n4)
N14=t(n32, n13, n5)
N15=t(n33, n14, n5)
N16=t(n34, n16, n5)
N17=t(n35, n8, n6)
N18=t(n6, n15, n36)
N19=t(n37, n16, n6)
N20=t(n38, n8, n7)
N21=t(n39, n14, n7)
N22=t(n40, n16, n7)
N23=t(n41, n13, n8)
N24=t(n42, n8, n9)
N25=t(n9, n15, n43)
N26=t(n9, n17, n44)
N27=t(n45, n8, n10)
N28=t(n46, n14, n10)
N29=t(n10, n17, n47)
N30=t(n48, n13, n11)
N31=t(n49, n14, n11)
N32=t(n11, n17, n50)
N33=t(n51, n13, n12)
N34=t(n12, n15, n52)
N35=t(n12, n17, n53)
N36=t(n14, n15, n54)
N37=t(n16, n17, n55)
N38=t(n15, n0, n1)
N39=t(n17, n0, n2)
N40=t(n13, n0, n3)
N41=vcc(n18)
N42=vcc(n19)
N43=vcc(n20)
N44=vcc(n21)
N45=vcc(n22)
N46=vcc(n23)
N47=vcc(n24)
N48=vcc(n25)
N49=vcc(n26)
N50=vcc(n27)
N51=vcc(n28)
N52=gnd(n29)
N53=gnd(n30)
N54=gnd(n31)
N55=gnd(n32)
N56=gnd(n33)
N57=gnd(n34)
N58=gnd(n35)
N59=gnd(n36)
N60=gnd(n37)
N61=gnd(n38)
N62=gnd(n39)
N63=gnd(n40)
N64=gnd(n41)
N65=gnd(n42)
N66=gnd(n43)
N67=gnd(n44)
N68=gnd(n45)
N69=gnd(n46)
N70=gnd(n47)
N71=gnd(n48)
N72=gnd(n49)
N73=gnd(n50)
N74=gnd(n51)
N75=gnd(n52)
N76=gnd(n53)
N77=gnd(n54)
N78=gnd(n55)
]])

move(nl, 0, 0, [[
N8  4909 2774 wn12,
N49 4910 2778,
N35 4914 2700 nn12,
N76 4918 2699,
N34 4914 2720 nn12,
N75 4918 2719,
N33 4914 2740 nn12,
N74 4918 2739,

N0  4919 2774 wn4,
N41 4920 2778,
N13 4924 2710 nn4,
N54 4928 2709,
N12 4924 2720 nn4,
N53 4928 2719,
N11 4924 2740 nn4,
N52 4928 2739,

N7  4929 2774 wn11,
N48 4930 2778,
N32 4934 2700 nn11,
N73 4938 2699,
N31 4934 2730 nn11,
N72 4938 2729,
N30 4934 2740 nn11,
N71 4938 2739,

N1  4939 2774 wn5,
N42 4940 2778,
N16 4944 2710 nn5,
N57 4948 2709,
N15 4944 2730 nn5,
N56 4948 2729,
N14 4944 2740 nn5,
N55 4948 2739,

N5  4949 2774 wn9,
N46 4950 2778,
N26 4954 2700 nn9,
N67 4958 2699,
N25 4954 2720 nn9,
N66 4958 2719,
N24 4954 2750 nn9,
N65 4958 2749,

N2  4959 2774 wn6,
N43 4960 2778,
N19 4964 2710 nn6,
N60 4968 2709,
N18 4964 2720 nn6,
N59 4968 2719,
N17 4964 2750 nn6,
N58 4968 2749,

N6  4969 2774 wn10,
N47 4970 2778,
N29 4974 2700 nn10,
N70 4978 2699,
N28 4974 2730 nn10,
N69 4978 2729,
N27 4974 2750 nn10,
N68 4978 2749,

N3  4979 2774 wn7,
N44 4980 2778,
N22 4984 2710 nn7,
N63 4988 2709,
N21 4984 2730 nn7,
N62 4988 2729,
N20 4984 2750 nn7,
N61 4988 2749,


N10 4995 2714 wn16,
N51 4996 2718,
N37 5001 2714 en55,
N78 5000 2710,
N39 5009 2715 nn17,

N9  4995 2734 wn14,
N50 4996 2738,
N36 5001 2734 en54,
N77 5000 2730,
N38 5009 2735 nn15,

N4  4995 2754 wn8,
N45 4996 2758,
N23 5001 2754 en41,
N64 5000 2750,
N40 5009 2755 nn13,
]])

route(nl, 0, 0, [[
n17 5005 2704,
n16 4998 2710 4998 2718,
n15 5005 2724,
n14 4998 2730 4998 2738,
n13 5005 2744,
n8  4998 2750 4998 2758,
]])

n = nodes_rect(4765, 2710, 4830, 2665)
inverted_clocked_amp(n, 4800, 2680)

n = nodes_rect(4770, 2707, 4800, 2595)
nl = match(n, [[
A=c(d, c)
B=t(b, a, c)
C=gnd(d)
]])

move(nl, 0, 0, [[
B 4825 2679 sc,
A 4821 2679 nd,
C 4821 2678,
]])

route(nl, 0, 0, [[
b 4797 2714 4797 2696 4831 2696 4831 2680,
]])

n = nodes_rect(4765, 2740, 4860, 2705)
inverted_clocked_amp(n, 4800, 2710)

n = nodes_rect(4760, 2790, 4860, 2755)
inverted_clocked_amp(n, 4800, 2740)

n = nodes_rect(4840, 2806, 4905, 2680)
nl = match(n, [[
N0=t(n9, n4, n19)
N1=t(n9, n7, n20)
N2=t(n21, n3, n11)
N3=t(n22, n6, n11)
N4=t(n23, n13, n12)
N5=t(n24, n2, n14)
N6=t(n25, n8, n14)
N7=t(n26, n1, n16)
N8=t(n27, n5, n16)
N9=t(n17, n18, n28)
N10=d(n29, n9, n9)
N11=d(n30, n11, n11)
N12=d(n31, n12, n12)
N13=d(n32, n14, n14)
N14=d(n33, n16, n16)
N15=d(n34, n17, n17)
N16=t(n9, n0, n10)
N17=t(n11, n0, n13)
N18=t(n14, n0, n15)
N19=t(n16, n0, n18)
N20=c(n35, n10)
N21=c(n36, n13)
N22=c(n37, n15)
N23=c(n38, n18)
N24=gnd(n19)
N25=gnd(n20)
N26=gnd(n21)
N27=gnd(n22)
N28=gnd(n23)
N29=gnd(n24)
N30=gnd(n25)
N31=gnd(n26)
N32=gnd(n27)
N33=gnd(n28)
N34=vcc(n29)
N35=vcc(n30)
N36=vcc(n31)
N37=vcc(n32)
N38=vcc(n33)
N39=vcc(n34)
N40=gnd(n35)
N41=gnd(n36)
N42=gnd(n37)
N43=gnd(n38)
]])

move(nl, 0, 0, [[
N15 4883 2688 wn17,
N39 4884 2692,
N9  4883 2680 wn28,
N33 4884 2676,
N23 4879 2679 nn38,
N43 4879 2678,
N19 4875 2679 sn16,
N14 4875 2712 wn16,
N38 4876 2716,
N7  4877 2704 en26,
N31 4876 2700,
N8  4884 2704 en27,
N32 4883 2700,

N12 4863 2688 wn12,
N36 4864 2692,
N4  4863 2680 wn23,
N28 4864 2676,
N21 4859 2679 nn36,
N41 4859 2678,
N17 4855 2679 sn11,

N11 4855 2712 wn11,
N35 4856 2716,
N2  4857 2704 en21,
N26 4856 2700,
N3  4864 2704 en22,
N27 4863 2700,

N22 4821 2709 nn37,
N42 4821 2708,
N18 4825 2709 sn15,
N13 4837 2728 wn14,
N37 4838 2732,
N5  4839 2720 en24,
N29 4838 2716,
N6  4846 2720 en25,
N30 4845 2716,

N20 4821 2739 nn35,
N40 4821 2738,
N16 4825 2739 sn10,
N10 4837 2758 wn9,
N34 4838 2762,
N0  4839 2750 en19,
N24 4838 2746,
N1  4846 2750 en20,
N25 4845 2746,
]])

route(nl, 0, 0, [[
n17 4886 2684,
n12 4866 2684,
n14 4831 2728 4831 2710,
n9  4831 2758 4831 2740,
]])

rename(nl)


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