local ts = game:GetService("TweenService")
local plr = game.Players.LocalPlayer

local function twn(object, dest, delay, direction, style)
    delay = delay or 0.5
    direction = direction or "Out"
    style = style or "Exponential"
    
    local t = ts:Create(object, TweenInfo.new(delay, Enum.EasingStyle[style], Enum.EasingDirection[direction]), dest)
    t:Play()
    return t
end

local function tl(parent, max, min) 
    local a = Instance.new("UITextSizeConstraint")
    a.MaxTextSize = max or 35
    a.MinTextSize = min or 19
    a.Parent = parent
end

local function p(parent, h)
    local a = Instance.new("UIPadding")
    a.Parent = parent
    a.PaddingTop = UDim.new(0, h)
end
    
    
local s = Instance.new("ScreenGui")
s.Parent = game.CoreGui

local a = Instance.new("Frame")
a.Size = UDim2.new(0.3, 0, 0.3, 0)
a.Position = UDim2.new(0.35, 0, 1, 0)
a.BorderSizePixel = 0
a.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
a.Parent = s

local b = Instance.new("Frame")
b.Size = UDim2.new(1, 0, 0.15, 0)
b.Position = UDim2.new(0, 0, 0, 0)
b.BorderSizePixel = 0
b.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
b.Parent = a

local c = Instance.new("TextLabel")
c.Text = "This jeff hoops version you are using is currently outdated."
c.TextScaled = true
c.TextColor3 = Color3.new(1, 1, 1)
c.Size = UDim2.new(1, 0, 1, 0)
c.Position = UDim2.new(0, 0, 0, 0)
c.BackgroundTransparency = 1
c.Font = Enum.Font.SourceSansLight
c.Parent = b

local d = Instance.new("TextLabel")
d.Text = "Join the discord for update information, latest script, and more"
d.TextScaled = true
d.TextColor3 = Color3.new(1, 1, 1)
d.Size = UDim2.new(1, 0, 0.1, 0)
d.Position = UDim2.new(0, 0, 0.3, 0)
d.BackgroundTransparency = 1
d.Font = Enum.Font.SourceSansLight
d.Parent = a

local e = Instance.new("TextLabel")
e.Text = "Or just use the updated script"
e.TextScaled = true
e.TextColor3 = Color3.new(1, 1, 1)
e.Size = UDim2.new(1, 0, 0.1, 0)
e.Position = UDim2.new(0, 0, 0.55, 0)
e.BackgroundTransparency = 1
e.Font = Enum.Font.SourceSansLight
e.Parent = a

local f = Instance.new("TextLabel")
f.Text = "Thanks for using jeff hoops!"
f.TextScaled = true
f.TextColor3 = Color3.new(1, 1, 1)
f.Size = UDim2.new(1, 0, 0.1, 0)
f.Position = UDim2.new(0, 0, 0.85, 0)
f.BackgroundTransparency = 1
f.Font = Enum.Font.SourceSansLight
f.Parent = a

local g = Instance.new("TextBox")
g.Text = "https://discord.gg/a3JEr9Z6jY"
g.TextScaled = true
g.TextColor3 = Color3.new(1, 1, 1)
g.Size = UDim2.new(0.4, 0, 0.1, 0)
g.Position = UDim2.new(0.3, 0, 0.4, 0)
g.BackgroundTransparency = 0
g.BorderSizePixel = 0
g.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
g.Font = Enum.Font.SourceSansLight
g.ClearTextOnFocus = false
g.Parent = a

local h = Instance.new("TextBox")
h.Text = "loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Hoops-GUI/main/script.lua'))()"
h.TextScaled = true
h.TextColor3 = Color3.new(1, 1, 1)
h.Size = UDim2.new(0.9, 0, 0.1, 0)
h.Position = UDim2.new(0.05, 0, 0.65, 0)
h.BackgroundTransparency = 0
h.BorderSizePixel = 0
h.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
h.Font = Enum.Font.SourceSansLight
h.ClearTextOnFocus = false
h.Parent = a

local i = Instance.new("Frame")
i.Size = UDim2.new(1, 0, 0, 10)
i.Position = UDim2.new(0, 0, 1, -10)
i.BackgroundTransparency = 0
i.BorderSizePixel = 0
i.BackgroundColor3 = Color3.fromRGB(60, 60, 62)
i.Parent = a

tl(c, 26, 0)
tl(d, 23, 0)
tl(e, 23, 0)

tl(f, 23, 0)
tl(g, 23, 0)

twn(a, {Position = UDim2.new(0.35, 0, 0.35, 0)})
twn(i, {Size = UDim2.new(0, 0, 0, 10)}, 20, "Out", "Linear")

wait(20)


twn(a, {Position = UDim2.new(0.35, 0, 1, 0)}, nil, "In")
wait(2)

s:Destroy()



for l,e in pairs({(function(e,...)_704542a5caaa0672="This file was obfuscated using PSU Obfuscator 4.5.A | https://www.psu.dev/ & discord.gg/psu";local O=_704542a5caaa0672 local B=e[(168599656)];local i=e[(572634531)];local a=e[((#{685;317;617;996;(function(...)return 471,581;end)()}+754248706))];local y=e[((611293582-#("cCc cCc cCc cCc CCC 4 4 4 cCc VATAN cCc")))];local L=e[((24593670-#("The Voxel is sus")))];local c=e[(153668011)];local b=e[(588076975)];local R=e[((945155792-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait")))];local C=e[((#{279;547;637;(function(...)return 301,866,84,10;end)()}+342802880))];local o=e[(728401163)];local S=e.FkRvuZsqO;local M=e[((#{958;}+65647714))];local G=e.cg4yEa6;local f=e[(681495501)];local d=e[((#{593;489;986;(function(...)return 70,358;end)()}+566172433))];local z=e[(651363761)];local H=e["PAXyBklE"];local u=e.J0SdjF3x;local q=e[((892090444-#("anofrillsguidetolua51instructions.pdf")))];local Z=e.hVkxcg;local ee=e.SeMIhG;local D=e["X2iTMc0J0"];local K=e[((#{327;}+955660016))];local I=e["CpPNiTX0mu"];local E=e[(239125058)];local W=e['UlkUO'];local Q=e[((#{986;(function(...)return 918,619,692;end)()}+456844405))];local X=e.CBgExAr0;local g=e[((697161056-#("please suck my cock :pleading:")))];local j=e[(677389757)];local Y=e[((#{459;275;623;}+482166911))];local x=e['QmBxvT'];local V=e[(97782296)];local T=((getfenv)or(function(...)return(_ENV);end));local n,r,l=({}),(""),(T(o));local t=((l[""..e[i]..e[C].."\116"..e[b].."\50"])or(l[""..e[i]..e[C]..e[c]])or({}));local n=(((t)and(t["\98\120\111"..e[u]]))or(function(e,l)local n,o=o,d;while((e>d)and(l>d))do local c,t=e%a,l%a;if c~=t then o=o+n;end;e,l,n=(e-c)/a,(l-t)/a,n*a;end;if e<l then e=l;end;while e>d do local l=e%a;if l>d then o=o+n;end;e,n=(e-l)/a,n*a;end;return(o);end));local s=(a^S);local F=(s-o);local w,p,m;local U=(r[""..e[B].."\104"..e[f]..e[u]]);local h=(r["\98\121"..e[c]..e["JmFuSx3e"]]);local s=(r["\103"..e["DGO9ERzSP"].."\117"..e[i]]);local s=(r["\115"..e[E]..e[i]]);local k=(l["\109\97"..e[c].."\104"]["\102"..e[x].."\111\111\114"]);local P=(l[""..e.DGO9ERzSP..e['JmFuSx3e'].."\108\101\99\116"]);local v=(l[""..e['I0Hjhol']..e[B]..e[f]..e[x].."\108"]);local r=(l[""..e[c]..e.FuHiw7VY..e['I0Hjhol'].."\101"]);local E=(l["\116\111"..e[g]..e[E]..e[I].."\98"..e['JmFuSx3e']..e[u]]);local J=function(n,l,e)return e+l or n*e end;local _=(l["\112"..e[f].."\105"..e[u].."\115"]);local N=(l[""..e["DGO9ERzSP"].."\116\114\105\110\103"][""..e[I].."\97"..e[c]..e[B]..e[D]]);local r=((l["\117\110"..e['I0Hjhol'].."\97"..e[B].."\107"])or(l[""..e[c].."\97"..e[i]..e[x]..e["JmFuSx3e"]]["\117\110\112"..e[f].."\99"..e[Q]]));local Q=(l["\114"..e[f].."\119\115\101\116"]);local Q=(l["\115"..e['JmFuSx3e'].."\116\109\101"..e[c].."\97\116"..e[f]..e[i].."\108"..e["JmFuSx3e"]]);local Q=((l["\109"..e[f].."\116\104"][""..e[x].."\100\101\120\112"])or(function(e,l,...)return((e*a)^l);end));w=((t[""..e[x].."\115"..e[D].."\105"..e[y]..e[c]])or(function(l,e,...)if(e<d)then return(p(l,-(e)));end;return((l*a^e)%a^S);end));m=(t["\98"..e[f]..e[g].."\100"])or(function(e,l,...)return(((e+l)-n(e,l))/a);end);local le=(t["\98\110\111\116"])or(function(e,...)return(F-e);end);p=((t[""..e[u]..e['DGO9ERzSP']..e[D].."\105"..e[y]..e[c]])or(function(l,e,...)if(e<d)then return(w(l,-(e)));end;return(k(l%a^S/a^e));end));local a=(t["\98\111\114"])or(function(e,l,...)return(F-m(F-e,F-l));end);if((not(l[""..e[i].."\105"..e[c]..e[b].."\50"]))and(not(l[""..e[i]..e[C]..e[c]])))then t["\98\120\111\114"]=n;t["\98"..e[g].."\111"..e[c]]=le;t["\98\111"..e[u]]=a;t[""..e[x]..e['DGO9ERzSP'].."\104\105\102"..e[c]]=w;t["\114\115"..e[D]..e[C]..e[y].."\116"]=p;t["\98\97\110\100"]=m;end;local a=(l[""..e[c].."\97"..e[i]..e[x]..e["JmFuSx3e"]][""..e[u].."\101"..e[I]..e[q]..e[Z]..e['JmFuSx3e']]);local a=(l["\116"..e[f]..e[i].."\108"..e["JmFuSx3e"]][""..e[C].."\110\115\101"..e[u].."\116"]);local D="\58\40\37"..e[X].."\43\41"..e[z];local C=(((l[""..e[c].."\97"..e[i]..e[x].."\101"]["\99"..e[u]..e['JmFuSx3e'].."\97\116"..e["JmFuSx3e"]]))or((function(e,...)return({r({},d,e);});end)));local f=(l["\116\97\98"..e[x]..e["JmFuSx3e"]][""..e[B].."\111\110"..e[B]..e[f]..e[c]]);l[""..e[i].."\105\116\51\50"]=t;local l=((-G+(function()local a,c=d,o;(function(l,e,n)l(n(e,n,n),l(e,e,n),l(e,e,l and e)and e(l,e and e,l))end)(function(n,e,l)if a>ee then return l end a=a+o c=(c+W)%R if(c%V)>j then return e(l(e,n,l),n(n,l,n),e(l,e,e))else return n end return e end,function(e,n,l)if a>H then return l end a=a+o c=(c+M)%L if(c%K)>Y then return l(e(e,e,e),n(e,l,e),l(n,e and l,n))else return n end return n end,function(n,l,e)if a>((179-#("concat was here")))then return n end a=a+o c=(c+(782))%((#{}+26061))if(c%((1086-#("[CW] icepools likes kids"))))>=((561-#("please suck my cock :pleading:")))then return e else return e(l(n,l,l)and e(n,e and n,l),n(n,l,l)and n(e and l,e,l),n(l,e,n and e))end return e(e(e,e,l),e(e,e,n),n(n,l,l and e))end)return c;end)()));local c,a=v(function(l)local e,n=l()local c,l=e(l(E),n)local n,e=e(J,d,nil,n)return E(N(e,D))-E(N(l,D))+o end,function(e)if e then return function(e)return e()end else return v,''end end)   local c=(#O+((#{4;888;119;635;(function(...)return 824,961,776;end)()}+158)));local i,A=({}),({});for e=d,c-o do local l=U(e);i[e]=l;A[e]=l;A[l]=e;end;local u,a=(function(n)local t,a,e=h(n,a,(3));if((t+a+e)~=((#{664;}+247)))then l=l+((277-#("I'm not ignoring you, my DMs are full. Can't DM me? Shoot me a email: mem@mem.rip (Business enquiries only)")));c=c+((268-#("IIiIIiillIiiIIIiiii :troll:")));end;n=s(n,(5));local l,a,t=(""),(""),({});local e=o;local function r()local l=E(s(n,e,e),((95-#("LuraphDeobfuscator.zip (oh god DMCA incoming everyone hide)"))));e+=o;local n=E(s(n,e,e+l-o),((#{236;394;27;}+33)));e+=l;return(n);end;l=A[r()];t[o]=l;while(e<#n)do local e=r();if i[e]then a=i[e];else a=l..s(l,o,o);end;i[c]=l..s(a,o,o);t[#t+o],l,c=a,a,c+o;end;return(f(t));end)("PSU|25a25p25P101022L22I1727722e21F161N1R1T21S2181J1D2772391R1U121T1r1h27F21721k1I1S24y25s1b2772241z1C121D21R21c1h1R1p1421o2241427721x2171R1O21C22E2821023427r27t27V27X1s26025227B1022c21d1n101J181724E2691h27722A21J1l1s151A121l1h1121j21327H1J161225A25U1927721u2191b1T21r2151t27u26X24728p2842861D21o21o1D1o1s1n23f1029u1022s11162861t1P151921K22J1627721z2121c182182192311a1327722x171q21522c2Ai21t1Y1N1T1V1N29J1125X25B1E2av1Y1h21C1x1m1G161b1a151f1q172311p28Z21v217191l1029K25B28127722B213161R171921D21J1D1p1g22E21p2Bm10236171R21D2181m161M171N21m21f1p1K24N25M1C27722c1z1i101B21p21i1N141V1a1625w2501527722v121h1J1425u2542Bb1Y102CY101S1T1b27224629A102371M1H1S1127m111b27q2BF1L1n161D27223n28h1023B1M1j1s26724H1g27721y21B151o1h27g2Ch1Y2171f131E191126w24B28Z2E92dH2Dj1624526z28P2E927u2dH151B1129i26D244182Bn29h1827U1B22221i2Do1022u171D1V1M22e2G3277237131H1M1P2672571A2831Z1821g2DG2dI2dk25a25V2fw102381r1S172CF2Ch2582Cb1022421L1K21E21i29A1T2CH1K24O29t29B21N1E1f1s21F21H28c24R2672EP22621b2Ay2301C2G42aK2d01I1l2392c32181t1N1y21e27Z25m2e72251y1q2CY21321J11101r1122N2362F01a181Z28G27723816171G1n23G2cq22R1b191F19121G1527f2CL1G1m26N24f2B41022121M21E21f23I2D81022W27B141d1j1R1D2Be16112DQ28P29c181227t1W21f1J1B1q23o26Y2GL1021Z2bO2132GQ2Fi22e21O1f29b29d29f29h2bI1Y21b2ik1726G2482ep22U1F1r1n24j25E2eP2311C29E24827127M102L41A1e21m2141527h1l2f91926x2FE2B51q21821p171H1L23j1H2KK2EQ2LG2A221M2kj151P1i1d1e1j1m21822g2EX1022021P1O1C1F2AL1D21I21p2ij21021d29p162372Ii1021324624y2jF22A21f1O25B2L227722d1H219142E92Gv2fn102hC192he25T2KB2kx2kz1m1Q2fA1F1D22T112Gv2md2mF2mh2EL24i25d28z2DQ2dS121B1o2172at2772282MO1n2K721z2GC1021y21g1J2ay21921V28P21U21C2Dh1A1X2112Iv2bZ25E2Dn27722R1H2J21426R23Z2GV2j12c6172gf1C2642512EP2C42C622Y1r2G42O62By1725125z2E72Ny2eC2eE2eg27r1V2eJ2El22221r2jm2AW2AY21i2ha2nB2HD26s23M2G428r2CG1Q21Z21K28P2212131u151121N219181f27F21522h2ep22q27M1321021Y2cq22621N1o1f2d01X21i1k141g1b1D1621922728Z28J2f82fA1126b2eo2it1D2c624j25r2aI22f21I1D1721K1Z2C71123e1i2Jm2371i1n2Of172Hc1L2nM2r62262Au1021V21813131t21t24V24A2s723228L2qx1n26t24F1O2cC21M141o1P1D1L1T2jW21o21F151d1S1621R285287192b021L22f2KB2j12r52k12nT1o2342b327722T1m1324R25y2l921u217172Bw2Lj2k42k62k826r2Jf2371A1n24E26t2g422u2ti1t23F1Q1j2GD2ea2172171s1Q2Fp21n2rN2ef1q1t1T1D23t26J1R27721w1X13171K1p1o21J2c51L2132161a2lR1821a2v221D2K52K71721s21G28z2361N2R12jB1722Q1m27727721s2672672212AH27723b1i2LR1S2aY1e1h25H2ot29021D141c1u23n2u427721T21E102EA23H2nP2832112hj2e22ch26z2lM102NY27f2o1142352JF22V181b23e1F2E722b21E1o21g2142VO1I29Q21j21J2vk2cz22Y1L2fm2cX2Cz2d121o287102532gU2DP2dr1N1h1t1s1023n26w2gV2eZ2AQ2142X81R21H2ba2cC28A2931B2152i824Y26428z2911t1C21i2191n21122D2GV2qB1Q1Y2Ck2cm1N2I227722P2bY1T1818142112252Q41J2XN2652582l922021r1J1t1X2152111R1b22S2uN172332s62oU2oW19141R2502Hq2vW1m181t23h2Ti2E827f2552Xq2JG2132s22S42GT2gV22u2jS2ju2SW1126Q2462KB2nY1Q1b141J1N2cz24V2ZW1022F21e191822f2Vg27722I21H121F1b1c1M1123b2G422T2932Un1023C2kb2EZ2KZ2pY2DH310p21m2Oi2772Qu2qW2D02k42j41221k22B2Cq2K02k21h1Z21f2JT2jv112122232Jf2321B1I25I28Y2dp2Wz2j52fr1n23e2Gv291192c61v2Sw25H25A2lw2ws2M71Q2FZ1l312y2Lj310B29V1z121827T313426V2A52Zq1j1I1R1R1M311l1n2301o2S72372H02CG1924H25x2UB2cR2Ct2Cv2xJ2d021m21L310E312521221W2JM2tC162TE2g7151V1J21k22g2G422b21n111R1625H312e2Kc21H310P312p1D25b25K2cQ2ny1N1C2II1B27F310g1T2RT2gV2392cy310q15312y25S2gk2772312o01D1F1V1u313c1T21N31422772Ic1b1h1P1921i28a28c1421527a2B5172962D8122132Zp2Wr2Dr27f1225Y2552gV2Ny2C82w82WA2wc102IC2ie1M26X2Sg27721V1y2AY2Rz26e23y2Ai22x2LO2Xm315c1121821t2aI2dA2dC1b21321318192662532s722P2Z22NM1R2kD2E72352r21G1G21m21C1121d2171H312N1L312p1624v2662G42uu29q1D21D2Y72eQ1o2AO1o2GF122r62Z52IT2Li2FA21k2252Mb22r12315C21M21I171o1N1d2T031561h24J25O2Kb22A29n2Df2Fh2Dk25w2592Jm22B21O1Q1r1a21J2KG2Dk26A2Q327C2yt1g23f1n2AI2202131V102eJ21C2Tr2342C22cc2132ls319O2bj2bl2KL2bV111N2qZ2hb2Hd25125G1227722n1o22h319J2Yx1K314G1s2CG2Ij162Yw2S82c5311u1126o2442vP27726o25r25r26U2s72ov2dH29j24J313Q2xR1h2ue2uG2uI2uK2K72Un318121x2l922821R2Oq171W319B1626A2RF29021n10131U311a2Cc21n2rh2Xo2652s721v152oE2Ay23f2lv2D921D317S317u2kf31902r6311O1022e21R314H111K1d21l212313F311F2kb21z2I8318L31cc22e21H313k2CX1H2cT21F2O41022r314V1D29i26R23k28Z27D27F27H21T25f2722cq2ok1r2QI21P31CN181o21121f2UO25G2zA2772222OP2b731Bj31BL1n23d28p2Yh1c31cB2gR2Dl24m2932Oc1z1131a227l2uj1i2qG1N1n21021h2DZ2zj1n11318T25C2S72361J1f1a1b1222s2Cm2n331cN1n21N2qC2qE31e52Fi2302JQ2oU318j2R421M2YL29e31d62R62IS1022b21i141L24V2To316M318M102O81Q21j316O18316Q31D927722321A1S21M2182Fr2192qS2ey21B2ts2kq2kS2V111151825X317a2Ut1X2iW1r1q23N26X2aI2pa1J2z72xT2Sl316S27C141131BL2rj2ai2282AB2AD1N21h2i826M23Q2Ms1a2572W5314e27B1r25H31932772qB2sS141e311k310o1N24P317x2n32n51422N27K2L9226317q1331851P21227k1P1E31Ht2602JF21Y191P25M316l2Mc2n62Ac1S24U25w2Dc31FK21k1a29J2G72M61m21g2aB1L1I192bf22M2112vo31D32f331fN1h31G5313V2d1313Y3124310G21F314C31DU2111D2172B12QJ315X1t313F1624y25p28p317g31GF31gh313F1b2512Ia2772nH2eK1f29G2qi31ep2Fo27H23F31JN1031h531IL1N26m2JE2772341s1u24P310T2381T2iP2392Zy31321i1m21H2MO1623h1D2EP2O629e1W31Fj22v2aM1824J25q315231542El2C625A31HV2902122951526O2Wq31kE31h731Ec312k29v29x1T21q21Q29Y25031BZ27722021531Ev317725W314k2vi2r131Ai2aF319t102My16131b2b422N2ob31722DD24e26o27731ec2vp1m2Vo318J101d2l9101i1j111p22522C31Mo2iI318J1V21E2191i1H131p22322a27731Kv141p25524g31nG1n2M221j21a31nG1K161p21x22k31ng1L171P24w24p31NG312W1p23L24831ng1R31iF22222b31ng1o1a1p1t2Ep1I1P1b315P2mb1i1U1c1P24523w31NG1V2CL24123s31NG1S1e1p24C23p31ng1T1F1p22022931nG2j61p21I21b31NG2gF1p22p23C31Ng31Mx1P23G22t31NG111J1P22422D31Ng162uy1o2Ms2vY1L1p24j25631ng142gh1Y31Bq31mX151n1p22E22731ng1a2ss31ob31Ng31OL1p21U22J31Ng181Q1P23b23231NG1928c24T25031nG1E1s1p26025D31ng1F2AO23E22r31Ng2W91P2K231Ng2g81P22g21T31NG21E1W1p2L531Ng21f1x1p26525g31nG21C1Y1p21c21531Ng21D1z31ok31IP1I21I2101P24823l31NG21J2111P21S22h31nG21G2121p21A21J31ng21h2131P21K1x31Ng2le1P25v25M31Ng21N2151p22u23j31nG21k2161p1R31a931mX21L2171P24k25931nG21Q2182D42L91i21r2191P23422X31nG21O21A1P21921g31Ng21P21b1p22H21s31ng1y21c1P23v24231Ng1z21d1P23223B31ng1w21E1p23I22v31NG1x2D331iA31ng21221G1p21R21231mO102FS122111h21G31Na31NC1x21K31NG1M31Ni21L1w31NM2M224423x31NR31nT23s24131nx31NZ23J22u31o3181p23w24531o831iF25024T31Od31OF29f31NG31ok1p21t22g31NG31Op1p22k21X31ou2CL22T23G31oZ31p121831el31mX31p61P24323u31pB1G1P21p21031Pg315O131q31PL31oj141t31pq31ps24223v31Pw2Uy21h21831ng1731Q225a24N31q62gh22122831NG31qC1P21b21i31QH2ss25224V31QL1p1P25b24m31qQ31Qs1H2GV31j028C26125c31r131r326625J31R72AO24M25b31rC1u1p22M21Z31Rg1V1p1Q2jf1I31rm1P25124S31Rq31rS23u24331RW31Ry1z21M31s231s424h25431Ng31S81P1N2Cq1i31se1p21D21431Sj31SL22X23431sP31SR23123831sV2141p21g21931T031T2112SO31mX31t71P23k24931NG31Td1p25924k31TI31tk24P24W31ng31TO1p25u25n31Tt31TV22A22331Tz31u121221R31u531u71D1k31Ub31UD31QF31uh31UJ23923031Un2D31j2KB1I31US1p24I25731mo13318j31V031V231V41p23N24a31V831nI1a313r2Ry2M216319N31mX31Ns1p23622z31Vl1P21521C31VP1p23Q24f31VU1p21n2dy31mX31oe1P22F22631w131Ol21e21731W631oq1u28Z1i31OV1P2102ml31mx31P01P24O24x31p531p724v25231wo1p10322V31Mx31ph25824L31Wx2aP2xW31Mx31PR1p23823131X52c21U31x931Q224X24O31XE1p24N25A31xi31Qd26725i31Xn1p24D23o31xr1P24Y24r31Xw1p24u25331qW28c26225F31Y41p22J21U31Y81p1w21L31YC1p23D22o31Yh1p21y22n31RL31Rn21Q21331yr1P25324u31yv1p1V2s71I31s31P21f21631z331s91g2aI31Z831SF22922031Zd1P2fZ31ZH1P24723Y31ZL1P22722e31zq1P25x25O31t631t826325e31zz31te24z24Q32041P24023T320831tP23522w320D1P22W235320H1P2172wF31mx31U61p24f23Q320p1p2282vu31mx31Ui1p23p24C320w1P25724I31uR31Ut322x31UY123216321831V331nb1p21621f321E1p24s25131VD1p23a23331VH1p22l21w321R25S25l321V22Q2AG31MX31O91p23t24031VY1p22r23e32281P21321Q322c1P24a23n31wB1p23c22p31WF1p1m2Lw1i31wK24623z322U23R24E31Wt1p21M1Z32321l2Jm1i323621z22m323A23o24d323D1P22y237323H22s23h323l31Ue31uG31MX31qI2M328p1I31qm22b222323X22i21v32411p25t25k3245230239324924g255324d1f31j52M431yI24q24z324l1P23M24B324p22622F324T22D22431yZ1p23y24732521P21v22I31Sd31sF25624j325A22o23d325D24b23M325H23722y325L21w22l325p1p23X31As31Tc31TE21121o325x21O21132611p22V23i326524923k326922Z236320L1P24e23r326I22C225320s1p23323a326r23F22Q326V1P26425H31MO1514318j31v1327231nc22N21Y31mO141532c52121331mp2sB21531s131Nh1P23Z24631n410151531My111I321N32CN27723N23r141Z25h26E27725Z25z31vp1623x31x4101x24D2582z11k1s1831mP312n31v41I322423H22S32282Cf31x031Mx31OP1621631X832dc23q24n1c1c1k2mF322g2cL32CX31Uy2ii1E1E28C1231mp32e22mH1e2ED32e21C2nz31MP1B2j229u31Oo31OQ21421d31mo1D1C1a32Ey101A31mP2z12EF1A32CZ31hP26132d71026F26f321e32d932Db1x23K24h14141K1G31h02iI32Cr32DM321N24r24Y32cP32fJ112h031NH1622T31rb1012172t0314V32Fu317j32E92VP311e31Mt31At27732fj32cp27731mr32G931Ec32Eo32gJ31uz32g9277311e31at31mT1u323c1025i31ER27731ET31eV31EX21C315w31IJ32cc31A231ec31e12GM2A82aa31Kf26M2KV2O51v2GZ25V23v2jM22W2XW1421b2Yl2XE1723o2Ty2n32Qc2361K31Cq2KE31bl26A23l2s72252142eB171b26b31g031d3314V1q2ow1q2W42g431KP1t1O1921131U431AT21022S1831L631L826x23W2Mb22P29a2KN29i310g21t21X1P2eC21f32H331M72r2310r31K132F022n162bz1922v2302F931Qc313M2cH1F21S2GV2gx2GZ2h11921M2Qm311P2HT31l92Nw2O531h62ae2Qf31282gD2U12341Q2l32L51s22J2OB31D42SB1T21E32IN26821B2652351y26531392MC32B632D131bl22e22331pk2Jn32HM132212C72231D1Q1g1C31JP22222528621u226315o21y22g2Vy2v6102sR22K314U1332Cr31151B296142fr2BW32ei1d1R22J21F1L2AU22r22Q21g22a22A1E2131G1w1G22j23f23c22J21p23222M21e31s41r1w1a1t23421t1w22r23b31VC21B1H1Q23422322423423822y23B22f191632FK1l21h23723i21021323I32I41z2121t21K21x1422J21R26c31591022232j42eF21732EW2Fr25W2P831Ls29y25B2d7316M2181132iD2K722h23d21931lF31lz1022T2Qi1731a224o2yf32O332o532IE21O21U2kb3153313f1S1f2aY22N32l4321u32go2wg2Vo11321627732CJ31mX31MZ28d32dT1I1G31891D28p1x28a318J1K1M121x313332pG32Pi1X21D32pa1232PH12321A31z631mO326z31EC31ew31EP1G2ms1n1u1932Ct162J331Ng32pA161l313r1X31sU32pM32pT3273320Y327731Rp32G9318j2Qe32Fn32E92SB2c832Q12771N131K32Q632qX27723o323s31ec2DT31e91K320o32P52al32Qz32Dc2181d31ec1K1l1123O23p31Ec1121021Q31ww31ft31e932q6122eP32rI32RK32rm32rO31Xs31Ng31Mz2bU2l931gG32C41232P421D2121N318j1l2J721D21E327031iz32oG31uy32CI31s121D21P1C2sB2s332ID1i3270310Q32cU31nB2el32PD2Ce2sb21421713321I1P329v32Cp2sb31EV151x21L31871332t032CG321632CR32p432cv1632je32342F31632cr1N1v32dj2II32tK32h531mp17171i2Dc2ii2aL162111y2LR2ek32TP1c2IK2Ii32T72BW1h32sr318j31z61p31mP31EC317k32Oy32gQ2vp2z121h21H"),(#O-(90));local function o(e,l,...)if(e==449455220)then return(n(n((((l)-540118)-983526)-706281,697222),812149));elseif(e==168210008)then return(((((n(l,7756))-687837)-192926)-689729)-173608);elseif(e==316691197)then return(((((l)-270582)-90598)-802257)-121979);elseif(e==394067108)then return(n(n(n(n(n(l,560361),20849),492923),539435),395695));elseif(e==617440274)then return(n(((l)-804551)-667760,158111));elseif(e==924132948)then return(n(n(n((n(l,175274))-297417,262212),112308),582107));elseif(e==464424076)then return(n(n(n(l,800582),548246),945092));elseif(e==752502747)then return(n(n(n(l,746794),869843),888645));elseif(e==763758285)then return((((n(l,251813))-112134)-352045)-646591);elseif(e==661401858)then return(((n(n(l,876134),125324))-552918)-661433);elseif(e==758946140)then return(n(n((n(l,700085))-983073,262619),587366));elseif(e==923699186)then return((n(n(n(l,617538),676928),684149))-284590);else end;end;if _ENV then _ENV._ENV=_ENV end;local i=e[(566172438)];local x=e[(117107619)];local B=e["yLrtT830"];local D=e[(81231764)];local E=e[(33942443)];local F=e[(440715057)];local t=e[(754248712)];local o=e[((436693127-#("Xenvant Likes cock - Perth")))];local c=e[((728401187-#("[CW] icepools likes kids")))];local function f(l,e,n)if(n)then local e=(l/t^(e-c))%t^((n-c)-(e-c)+c);return(e-(e%c));else local e=t^(e-c);return(((l%(e+e)>=e)and(c))or(i));end;end;local function d()local c,e=h(u,a,a+t);c=n(c,l);l=c%o;e=n(e,l);l=e%o;a=a+t;return((e*o)+c);end;local function i()local e=n(h(u,a,a),l);l=e%o;a=(a+c);return(e);end;local function t()local e,c,t,i=h(u,a,a+F);e=n(e,l);l=e%o;c=n(c,l);l=c%o;t=n(t,l);l=t%o;i=n(i,l);l=i%o;a+=x;return((i*B)+(t*D)+(c*o)+e);end;local v=""..e[E];local function b(...)return({...}),P(v,...);end;local function G(...)local z=e['uyvgcEtV'];local o=e[(728401163)];local G=e[(616035254)];local b=e[(209508293)];local T=e[((#{235;311;139;(function(...)return 179,630,...;end)()}+491556627))];local U=e.TEjpQeedp;local c=e[(566172438)];local P=e[((367805314-#("Cling clang, hide the kids, someones outta find you..")))];local B=e[((#{46;525;}+215079630))];local H=e.UxS6sx;local I=e["FkRvuZsqO"];local D=e[(109328029)];local S=e[(117107619)];local J=e.yfwBUsvL;local N=e[((#{}+966136460))];local C=e["lO3FzIAv"];local y=e[((436693117-#("Wally likes cock")))];local O=e[(690511804)];local V=e["ApGuGP"];local E=e[((440715089-#("The Person who reads this is gay")))];local F=e[(754248712)];local M=e["VUkq9tY"];local R=e['ql0NaH4c'];local L=e[((#{971;(function(...)return...;end)()}+623234450))];local m=e.MnDFbEnc;local p=e[(514575866)];local function w(...)local e=({});local x=({});local g=({});local v=i(l);for r=c,t(l)-o,o do local d=i(l);if(d%C==U)then local l=i(l);e[r]=(l~=c);elseif(d%C==o)then while(true)do local a=t(l);local n=t(l);local t=o;local a=(f(n,o,J)*(F^I))+a;local l=f(n,C,T);local n=((-o)^f(n,I));if(l==c)then if(a==c)then e[r]=k(n*c);break;else l=o;t=c;end;elseif(l==P)then e[r]=(a==c)and(n*(o/c))or(n*(c/c));break;end;local l=Q(n,l-R)*(t+(a/(F^H)));e[r]=l%o==c and k(l)or l break;end;elseif(d%C==E)then while(true)do local l=t(l);e[r]=s(u,a,a+l-o);a=a+l;break;end;elseif(d%C==b)then while(true)do local t=t(l);if(t==c)then e[r]=('');break;end;if(t>M)then local c,i=(''),(s(u,a,a+t-o));a=a+t;for e=o,#i,o do local e=n(h(s(i,e,e)),l);l=e%y;c=c..A[e];end;e[r]=c;else local o,c=(''),({h(u,a,a+t-o)});a=a+t;for c,e in _(c)do local e=n(e,l);l=e%y;o=o..A[e];end;e[r]=o;end;break;end;else e[r]=nil end;end;local n=t(l);for e=c,n-o,o do x[e]=({});end;for y=c,n-o,o do local n=i(l);if(n~=c)then n=n-o;local s,C,A,r,a,u=c,c,c,c,c,c;local h=f(n,o,E);if(h==B)then u=(d(l));r=(d(l));s=(i(l));a=(t(l));C=({});for e=o,u,o do C[e]=({[c]=i(l),[o]=d(l)});end;elseif(h==D)then elseif(h==o)then r=(d(l));s=(i(l));a=(t(l));elseif(h==c)then u=(d(l));r=(d(l));s=(i(l));a=(d(l));elseif(h==F)then r=(d(l));s=(i(l));a=x[(t(l))];elseif(h==E)then u=(d(l));r=(d(l));s=(i(l));a=x[(t(l))];end;if(f(n,S,S)==o)then r=e[r];end;if(f(n,B,B)==o)then a=e[a];end;if(f(n,D,D)==o)then u=e[u];end;if(f(n,m,m)==o)then A=x[t(l)];else A=x[y+o];end;if(f(n,p,p)==o)then C=({});for e=o,i(),o do C[e]=t();end;end;local e=x[y];e["V0m"]=s;e[O]=A;e[895806.6864474443]=a;e[G]=u;e[949014.5316689799]=r;e[V]=C;end;end;for e=c,t(l)-o,o do g[e]=w();end;local l=d(l);return({['TEB']=c;[-z]=l;["dU5"]=e;[N]=g;['CQQSMwF']=x;[-L]=v;});end;return(w(...));end;local function A(e,l,f,...)local B=e[96773];local i=e['CQQSMwF'];local o=0;local a=e[-398695];local l=e["dU5"];local d=e[-885768];local e=f['\119\97\105\116'];return(function(...)local E='V0m';local l=(209539009);local t=310182;local l=(true);local l=249470;local n=949014.5316689799;local x={...};local l=({});local h=(P(v,...)-1);local s={};local l={};local c=895806.6864474443;local u=i[o];local i=-(1);local o=894857;local e=e and 1 or 0;for e=0,h,e do if(e>=a)then s[e-a]=x[e+1];else l[e]=x[e+1];end;end;local x=h-a+1;repeat local e=u;local a=e[E];u=e[o];if(a<=20)then if(a<=9)then if(a<=4)then if(a<=1)then if(a>0)then local n=e[n];l[n](r(l,n+1,e[c]));for e=n+1,d do l[e]=nil;end;elseif(a<1)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];end;elseif(a<=2)then local e=e[n];do return r(l,e,i);end;elseif(a>3)then l[e[n]]=({(nil)});elseif(a<4)then local e=e[n];l[e]=l[e](r(l,e+1,i));for e=e+1,i do l[e]=nil;end;end;elseif(a<=6)then if(a>5)then l[e[n]]=f[e[c]];elseif(a<6)then local n=e[n];local o,e=b(l[n](r(l,n+1,e[c])));i=e+n-1;local e=0;for n=n,i do e=e+1;l[n]=o[e];end;end;elseif(a<=7)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a==8)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a<=9)then local e=e[n];l[e]=l[e](l[e+1]);for e=e+1,d do l[e]=nil;end;end;elseif(a<=14)then if(a<=11)then if(a==10)then local c=e[c];local o=l[c];for e=c+1,e[t]do o=o..l[e];end;l[e[n]]=o;elseif(a<=11)then local n=e[n];i=n+x-1;for e=0,x do l[n+e]=s[e];end;for e=i+1,d do l[e]=nil;end;end;elseif(a<=12)then e=e[o];local c=e[n];i=c+x-1;for e=0,x do l[c+e]=s[e];end;for e=i+1,d do l[e]=nil;end;e=e[o];local n=e[n];do return r(l,n,i);end;e=e[o];e=e[o];elseif(a>13)then local n=e[n];local a=l[n+2];local o=l[n]+a;l[n]=o;if(a>0)then if(o<=l[n+1])then u=e[c];l[n+3]=o;end;elseif(o>=l[n+1])then u=e[c];l[n+3]=o;end;elseif(a<14)then l[e[n]]=A(B[e[c]],(nil),f);end;elseif(a<=17)then if(a<=15)then local n=e[n];l[n]=l[n](r(l,n+1,e[c]));for e=n+1,d do l[e]=nil;end;elseif(a>16)then l[e[n]]=l[e[c]][l[e[t]]];elseif(a<17)then local e=e[n];l[e](l[1+e]);for e=e,d do l[e]=nil;end;end;elseif(a<=18)then l[e[n]]=l[e[c]];elseif(a>19)then l[e[n]]=l[e[c]][e[t]];elseif(a<20)then if(not(l[e[n]]))then u=e[c];end;end;elseif(a<=30)then if(a<=25)then if(a<=22)then if(a==21)then l[e[n]][e[c]]=e[t];elseif(a<=22)then end;elseif(a<=23)then l[e[n]][e[c]]=l[e[t]];elseif(a==24)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a<=25)then l[e[n]]=e[c];end;elseif(a<=27)then if(a>26)then l[e[n]]=#l[e[c]];elseif(a<27)then local a=e[n];l[a]=l[a](r(l,a+1,e[c]));for e=a+1,d do l[e]=nil;end;e=e[o];l[e[n]][e[c]]=l[e[t]];e=e[o];local n=e[n];l[n](l[1+n]);for e=n,d do l[e]=nil;end;e=e[o];e=e[o];end;elseif(a<=28)then l[e[n]]=C(e[c]);e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a>29)then l[e[n]][e[c]]=e[t];e=e[o];l[e[n]]=C(256);e=e[o];l[e[n]][e[c]]=e[t];e=e[o];l[e[n]][e[c]]=l[e[t]];e=e[o];l[e[n]]=f[e[c]];e=e[o];local i=e[n];local a=l[e[c]];l[i+1]=a;l[i]=a[e[t]];e=e[o];l[e[n]]=e[c];e=e[o];local a=e[n];l[a]=l[a](r(l,a+1,e[c]));for e=a+1,d do l[e]=nil;end;e=e[o];local i=e[n];local a=l[e[c]];l[i+1]=a;l[i]=a[e[t]];e=e[o];l[e[n]]=C(256);e=e[o];l[e[n]]=f[e[c]];e=e[o];l[e[n]][e[c]]=l[e[t]];e=e[o];l[e[n]]=({(nil)});e=e[o];l[e[n]]=l[e[c]];e=e[o];e=e[o];elseif(a<30)then do return;end;end;elseif(a<=35)then if(a<=32)then if(a>31)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a<32)then l[e[n]]=C(e[c]);end;elseif(a<=33)then e=e[o];l[e[n]]=C(256);e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=f[e[c]];e=e[o];l[e[n]]=l[e[c]][e[t]];e=e[o];l[e[n]]=l[e[c]][e[t]];e=e[o];l[e[n]]=l[e[c]][e[t]];e=e[o];l[e[n]]=e[c];e=e[o];local d=e[c];local a=l[d];for e=d+1,e[t]do a=a..l[e];end;l[e[n]]=a;e=e[o];l[e[n]][e[c]]=l[e[t]];e=e[o];l[e[n]]=f[e[c]];e=e[o];l[e[n]]=f[e[c]];e=e[o];l[e[n]]=l[e[c]][e[t]];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];local a=e[n];local u,d=b(l[a](r(l,a+1,e[c])));i=d+a-1;local d=0;for e=a,i do d=d+1;l[e]=u[d];end;e=e[o];local a=e[n];l[a]=l[a](r(l,a+1,i));for e=a+1,i do l[e]=nil;end;e=e[o];l[e[n]][e[c]]=l[e[t]];e=e[o];l[e[n]]=f[e[c]];e=e[o];e=e[o];elseif(a>34)then local n=e[n];l[n]=0+(l[n]);l[n+1]=0+(l[n+1]);l[n+2]=0+(l[n+2]);local o=l[n];local a=l[n+2];if(a>0)then if(o>l[n+1])then u=e[c];else l[n+3]=o;end;elseif(o<l[n+1])then u=e[c];else l[n+3]=o;end;elseif(a<35)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];end;elseif(a<=38)then if(a<=36)then if(l[e[n]])then u=e[c];end;elseif(a==37)then local n=e[n];local a=e[c];local o=50*(e[t]-1);local c=l[n];local e=0;for a=n+1,a do c[o+e+1]=l[n+(a-n)];e=e+1;end;elseif(a<=38)then local a=(_195);(function()l[e[n]]=l[e[c]];e=e[o];end){};l[e[n]]=e[c];e=e[o];l[e[n]]=f[e[c]];e=e[o];local a=(_89);(function()l[e[n]]=f[e[c]];e=e[o];end){};local a=(_114);(function()l[e[n]]=l[e[c]][e[t]];e=e[o];end){};local a=(_12);(function()l[e[n]]=e[c];e=e[o];end){};l[e[n]]=#l[e[c]];e=e[o];local a=e[n];l[a]=l[a](r(l,a+1,e[c]));for e=a+1,d do l[e]=nil;end;e=e[o];l[e[n]]=l[e[c]][l[e[t]]];e=e[o];local a=e[n];l[a]=l[a](l[a+1]);for e=a+1,d do l[e]=nil;end;e=e[o];l[e[n]]=e[c];e=e[o];local i=e[c];local a=l[i];for e=i+1,e[t]do a=a..l[e];end;l[e[n]]=a;e=e[o];local n=e[n];l[n](r(l,n+1,e[c]));for e=n+1,d do l[e]=nil;end;e=e[o];e=e[o];end;elseif(a<=39)then l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];l[e[n]]=e[c];e=e[o];e=e[o];elseif(a>40)then l[e[n]]=C(256);elseif(a<41)then local o=e[n];local n=l[e[c]];l[o+1]=n;l[o]=n[e[t]];end;until false end);end;return A(G(),{},T())(...);end)(({[(482166914)]=(((627-#("When the exploiter is sus"))));[((728401206-#("https://www.youtube.com/watch?v=Lrj2Hq7xqQ8")))]=((1));uyvgcEtV=((885768));[(342802887)]=((71212691));lO3FzIAv=((21));AipHiy4=(((244-#("Are you using AztupBrew, clvbrew, or IB2? Congratulations! You're deobfuscated!"))));['CpPNiTX0mu']=((193703377));[(739621658)]=("\102");['QmBxvT']=(((#{}+121053879)));[((#{748;6;942;716;(function(...)return 2;end)()}+367805256))]=(((#{616;88;338;(function(...)return 934,537,874;end)()}+2041)));[((#{}+508370310))]=("\114");["UlkUO"]=(((69-#("why does psu.dev attract so many ddosing retards wtf"))));X2iTMc0J0=((284373095));[((#{59;}+955660016))]=((1204));[(588076975)]=(((84430284-#("psu == femboy hangout"))));[((#{923;796;948;}+677389754))]=((518));[((#{197;(function(...)return 480,269,401;end)()}+209508289))]=((9));[((223949106-#("balls and cum")))]=("\98");[((#{(function(...)return;end)()}+193703377))]=("\109");[((#{(function(...)return 364,434,450,855;end)()}+450712475))]=((241));[((#{78;316;127;574;(function(...)return 911,463;end)()}+284373089))]=("\104");[(305070901)]=(((#{(function(...)return 243;end)()}+26060)));["EDyOLiNg"]=((90));["SeMIhG"]=(((483-#("When the exploiter is sus"))));[(97782296)]=((1036));[((#{}+884231660))]=("\117");["yLrtT830"]=((16777216));[(690511804)]=((894857));UxS6sx=((52));[(84430263)]=("\51");[((#{925;110;523;986;(function(...)return 421,870,539,127;end)()}+972347545))]=((164));[(945155687)]=(((3806-#("If you see this, congrats you're gay"))));[((#{145;179;(function(...)return 843,317;end)()}+135511030))]=("\116");['CBgExAr0']=((522234651));[((440715128-#("why the fuck would we sell a deobfuscator for a product we created.....")))]=((3));[(752533719)]=("\35");[((914646748-#("PSU|161027525v21222B11273172751L275102731327523d27f22I27f21o26o24Y21J1827F1X27f1r27F23823a26w1... oh wait")))]=(((1114-#("why does psu.dev attract so many ddosing retards wtf"))));[(71212691)]=("\105");[(387970430)]=("\107");[(33942443)]=(((752533740-#("psu == femboy hangout"))));[((#{243;304;828;}+117107616))]=(((#{377;807;48;578;}+0)));[(616035254)]=(((#{52;411;309;380;(function(...)return 434,976,947,783;end)()}+310174)));[(566172438)]=((0));J0SdjF3x=(((#{734;103;}+508370308)));["PAXyBklE"]=((294));[((#{243;925;(function(...)return 321;end)()}+153668008))]=(((135511065-#("Hey reader, you're a sussy baka"))));[(168599656)]=(((578666588-#("i am not wally stop asking me for wally hub support please fuck off"))));[(522234651)]=("\100");[(109328029)]=(((#{769;369;851;(function(...)return 678,455,387,783;end)()}-1)));['FkRvuZsqO']=(((64-#("The Person who reads this is gay"))));['hVkxcg']=((835428358));['cg4yEa6']=(((#{170;503;367;(function(...)return 878,15,572,360;end)()}+843)));[((#{441;865;}+611293541))]=((739621658));[((#{338;608;106;46;}+990928043))]=("\58");FuHiw7VY=("\121");[((#{709;387;342;}+623234448))]=((398695));[(651363761)]=((990928047));[(835428358)]=("\118");[(317707326)]=("\110");[(186501120)]=((248));['TEjpQeedp']=((12));[(966136460)]=(((#{}+96773)));[(892090407)]=(((#{(function(...)return;end)()}+979696686)));[(436693101)]=(((281-#("When the exploiter is sus"))));[((787386300-#("IIiIIiillIiiIIIiiii :troll:")))]=("\97");[((#{}+712571193))]=((782));["I0Hjhol"]=("\112");[(514575866)]=(((#{881;(function(...)return 996,211;end)()}+4)));[((#{967;49;}+430188305))]=((36));['VUkq9tY']=((5000));[(81231764)]=(((65629-#("Luraph v12.6 has been released!: changed absolutely fucking nothing but donate to my patreon!"))));[(578666521)]=("\99");[(572634531)]=(((#{795;239;}+223949091)));[(697161026)]=((317707326));["DGO9ERzSP"]=("\115");['MnDFbEnc']=((8));[(979696686)]=("\111");[(215079632)]=(((#{269;339;}+3)));[(491556632)]=(((55-#("[CW] icepools likes kids"))));nmTNzl=((170));JmFuSx3e=("\101");[((754248764-#("why does psu.dev attract so many ddosing retards wtf")))]=(((#{}+2)));ApGuGP=((249470));[((681495527-#("Xenvant Likes cock - Perth")))]=((787386273));['yfwBUsvL']=((20));[(121053879)]=("\108");["ql0NaH4c"]=(((1094-#("why the fuck would we sell a deobfuscator for a product we created....."))));[(65647715)]=(((247-#("Bunu yazan tosun... - federal"))));[((456844425-#("Wally likes cock")))]=(((#{795;(function(...)return 775,967;end)()}+387970427)));[(24593654)]=(((35198-#("why does psu.dev attract so many ddosing retards wtf"))));[(333821491)]=((531));[(239125058)]=((884231660));}),...)})do return e end;
