local a=game:GetService("Players").LocalPlayer
local b=game:GetService("RunService")
local c=game:GetService("UserInputService")
local d=game:GetService("ReplicatedStorage")
local e=a:WaitForChild("PlayerGui")
local f=false
local g={}
local h=""
local i={}
local j=0
local k=nil
pcall(function()
k=d:WaitForChild("Remotes",5)
end)
local function l(m)
if not m.Character then return nil end
return m.Character:FindFirstChild("HumanoidRootPart")
end
local function n(m)
if not m.Character then return nil end
return m.Character:FindFirstChildOfClass("Humanoid")
end
local function o()
f=true
h="Gravacao_"..os.date("%H%M%S")
i={}
j=tick()
print("🔴 GRAVANDO: "..h)
end
local function p()
if not f then return end
f=false
g[h]={frames=i,created=tick()}
print("✅ SALVO: "..h.." ("..#i.." frames)")
end
local function q(r)
local s=g[r]
if not s then print("❌ Não encontrado!")return end
task.spawn(function()
for _,t in ipairs(s.frames)do
pcall(function()
local u=a.Character
if u then
local v=u:FindFirstChild("HumanoidRootPart")
if v then
v.CFrame=t
task.wait(0.05)
end
end
end)
end
end)
print("▶️ REPRODUZINDO: "..r)
end
b.Heartbeat:Connect(function()
if not f then return end
pcall(function()
local u=a.Character
if u then
local v=u:FindFirstChild("HumanoidRootPart")
if v then
table.insert(i,v.CFrame)
end
end
end)
end)
local w=nil
local x=pcall(function()
w=loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinglsl/Rayfield/main/source"))()
end)
if not w then
print("❌ Rayfield não disponível, usando UI nativa...")
local y=Instance.new("ScreenGui")
y.Name="KoalaFarmUI"
y.ResetOnSpawn=false
y.Parent=e
local z=Instance.new("Frame")
z.Name="MainFrame"
z.Size=UDim2.new(0,400,0,600)
z.Position=UDim2.new(0.5,-200,0.5,-300)
z.BackgroundColor3=Color3.fromRGB(30,30,30)
z.BorderSizePixel=0
z.Parent=y
local A=Instance.new("UICorner")
A.CornerRadius=UDim.new(0,15)
A.Parent=z
local B=Instance.new("TextLabel")
B.Name="Title"
B.Size=UDim2.new(1,0,0,50)
B.BackgroundColor3=Color3.fromRGB(50,50,50)
B.TextColor3=Color3.fromRGB(255,200,0)
B.TextSize=20
B.Font=Enum.Font.GothamBold
B.Text="🐨 Koala Farm"
B.Parent=z
local C=Instance.new("ScrollingFrame")
C.Name="Scroll"
C.Size=UDim2.new(1,-20,1,-60)
C.Position=UDim2.new(0,10,0,60)
C.BackgroundColor3=Color3.fromRGB(30,30,30)
C.BorderSizePixel=0
C.ScrollBarThickness=8
C.Parent=z
local D=Instance.new("UIListLayout")
D.Padding=UDim.new(0,8)
D.Parent=C
C.CanvasSize=UDim2.new(0,0,0,0)
D:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
C.CanvasSize=UDim2.new(0,0,0,D.AbsoluteContentSize.Y)
end)
local function E(F)
local G=Instance.new("Frame")
G.Size=UDim2.new(1,-20,0,35)
G.BackgroundColor3=Color3.fromRGB(50,50,50)
G.BorderSizePixel=0
G.Parent=C
local H=Instance.new("UICorner")
H.CornerRadius=UDim.new(0,8)
H.Parent=G
local I=Instance.new("TextLabel")
I.Size=UDim2.new(1,-10,1,0)
I.Position=UDim2.new(0,5,0,0)
I.BackgroundTransparency=1
I.TextColor3=Color3.fromRGB(255,200,0)
I.TextSize=14
I.Font=Enum.Font.GothamBold
I.Text="━━ "..F.." ━━"
I.TextXAlignment=Enum.TextXAlignment.Left
I.Parent=G
end
local function J(F,K)
local L=Instance.new("TextButton")
L.Name=F
L.Size=UDim2.new(1,-20,0,40)
L.BackgroundColor3=Color3.fromRGB(60,60,70)
L.TextColor3=Color3.fromRGB(255,255,255)
L.TextSize=13
L.Font=Enum.Font.Gotham
L.Text=F
L.Parent=C
local M=Instance.new("UICorner")
M.CornerRadius=UDim.new(0,8)
M.Parent=L
L.MouseButton1Click:Connect(K)
return L
end
E("GRAVAÇÃO DE MOVIMENTOS")
local N="Nova Gravação"
local O=Instance.new("Frame")
O.Size=UDim2.new(1,-20,0,40)
O.BackgroundColor3=Color3.fromRGB(60,60,70)
O.BorderSizePixel=0
O.Parent=C
local P=Instance.new("UICorner")
P.CornerRadius=UDim.new(0,8)
P.Parent=O
local Q=Instance.new("TextBox")
Q.Size=UDim2.new(1,-10,1,0)
Q.Position=UDim2.new(0,5,0,0)
Q.BackgroundTransparency=1
Q.TextColor3=Color3.fromRGB(255,255,255)
Q.TextSize=12
Q.Font=Enum.Font.Gotham
Q.PlaceholderText="Nome da gravação..."
Q.Text=""
Q.Parent=O
Q:GetPropertyChangedSignal("Text"):Connect(function()
N=Q.Text~=""and Q.Text or"Gravacao_"..os.date("%H%M%S")
end)
J("🔴 INICIAR GRAVAÇÃO",function()
o()
end)
J("⏹️ PARAR GRAVAÇÃO",function()
p()
end)
J("▶️ REPRODUZIR ÚLTIMA",function()
local r=nil
for R,_ in pairs(g)do
r=R
break
end
if r then
q(r)
else
print("❌ Nenhuma gravação!")
end
end)
J("📊 LISTAR GRAVAÇÕES",function()
print("\n"..string.rep("═",50))
print("GRAVAÇÕES SALVAS:")
print(string.rep("═",50))
local S=0
for R,_ in pairs(g)do
S=S+1
print(S..". "..R.." ("..#_.frames.." frames)")
end
if S==0 then
print("Nenhuma gravação salva!")
end
print(string.rep("═",50).."\n")
end)
E("AUTO-FASE")
local T=false
local U=""
local V=Instance.new("Frame")
V.Size=UDim2.new(1,-20,0,40)
V.BackgroundColor3=Color3.fromRGB(60,60,70)
V.BorderSizePixel=0
V.Parent=C
local W=Instance.new("UICorner")
W.CornerRadius=UDim.new(0,8)
W.Parent=V
local X=Instance.new("TextLabel")
X.Size=UDim2.new(0.7,0,1,0)
X.BackgroundTransparency=1
X.TextColor3=Color3.fromRGB(255,255,255)
X.TextSize=12
X.Font=Enum.Font.Gotham
X.Text="Selecionar Gravação:"
X.TextXAlignment=Enum.TextXAlignment.Left
X.Parent=V
local Y=Instance.new("TextButton")
Y.Size=UDim2.new(0,60,0,25)
Y.Position=UDim2.new(1,-70,0.5,-12)
Y.BackgroundColor3=Color3.fromRGB(100,100,100)
Y.TextColor3=Color3.fromRGB(255,255,255)
Y.TextSize=11
Y.Font=Enum.Font.GothamBold
Y.Text="..."
Y.Parent=V
local Z=Instance.new("UICorner")
Z.CornerRadius=UDim.new(0,6)
Z.Parent=Y
Y.MouseButton1Click:Connect(function()
local aa=""
for R,_ in pairs(g)do
aa=aa==""and R or aa..", "..R
end
if aa~=""then
U=aa:match("^([^,]+)")
print("✅ Selecionado: "..U)
else
print("❌ Nenhuma gravação!")
end
end)
local function ab(ac,ad)
local ae=Instance.new("Frame")
ae.Size=UDim2.new(1,-20,0,40)
ae.BackgroundColor3=Color3.fromRGB(60,60,70)
ae.BorderSizePixel=0
ae.Parent=C
local af=Instance.new("UICorner")
af.CornerRadius=UDim.new(0,8)
af.Parent=ae
local ag=Instance.new("TextLabel")
ag.Size=UDim2.new(0.7,0,1,0)
ag.BackgroundTransparency=1
ag.TextColor3=Color3.fromRGB(255,255,255)
ag.TextSize=12
ag.Font=Enum.Font.Gotham
ag.Text=ac
ag.TextXAlignment=Enum.TextXAlignment.Left
ag.Parent=ae
local ah=Instance.new("TextButton")
ah.Size=UDim2.new(0,50,0,25)
ah.Position=UDim2.new(1,-60,0.5,-12)
ah.BackgroundColor3=Color3.fromRGB(100,100,100)
ah.TextColor3=Color3.fromRGB(255,255,255)
ah.TextSize=11
ah.Font=Enum.Font.GothamBold
ah.Text="OFF"
ah.Parent=ae
local ai=Instance.new("UICorner")
ai.CornerRadius=UDim.new(0,6)
ai.Parent=ah
local aj=false
ah.MouseButton1Click:Connect(function()
aj=not aj
ah.BackgroundColor3=aj and Color3.fromRGB(50,200,50)or Color3.fromRGB(100,100,100)
ah.Text=aj and"ON"or"OFF"
ad(aj)
end)
end
ab("⚡ AUTO-FASE",function(ak)
T=ak
if T and U~=""then
task.spawn(function()
while T do
q(U)
task.wait(2)
end
end)
else
T=false
print("❌ Selecione uma gravação!")
end
end)
E("FARM")
ab("🖱️ AUTO CLICK",function(ak)
if ak and k then
task.spawn(function()
while ak do
pcall(function()
k.ClicouParaGanharEgo:FireServer()
end)
task.wait(0.05)
end
end)
end
end)
ab("🛡️ ANTI-AFK",function(ak)
if ak then
task.spawn(function()
while ak do
pcall(function()
game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Unknown,false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Unknown,false,game)
end)
task.wait(45)
end
end)
end
end)
J("❌ FECHAR",function()
T=false
y:Destroy()
print("👋 Hub Fechado!")
end)
c.InputBegan:Connect(function(al,am)
if am then return end
if al.KeyCode==Enum.KeyCode.RightControl then
z.Visible=not z.Visible
end
end)
else
local an=w:CreateWindow({Name="Koala Farm",LoadingTitle="Koala Farm",LoadingSubtitle="Carregando...",ConfigurationSaving={Enabled=false},Discord={Enabled=false},KeySystem=false})
local ao=an:CreateTab("🎬 Gravação",0)
local N="Nova Gravação"
ao:CreateInput({Name="Nome da Gravação",PlaceHolder="Digite um nome",RemoveTextAfterFocusLost=false,Callback=function(ap)
N=ap~=""and ap or"Gravacao_"..os.date("%H%M%S")
end})
ao:CreateButton({Name="🔴 INICIAR GRAVAÇÃO",Callback=function()
o()
end})
ao:CreateButton({Name="⏹️ PARAR GRAVAÇÃO",Callback=function()
p()
end})
ao:CreateButton({Name="▶️ REPRODUZIR ÚLTIMA",Callback=function()
local r=nil
for R,_ in pairs(g)do
r=R
break
end
if r then
q(r)
else
print("❌ Nenhuma gravação!")
end
end})
ao:CreateButton({Name="📊 LISTAR GRAVAÇÕES",Callback=function()
print("\n"..string.rep("═",50))
print("GRAVAÇÕES SALVAS:")
print(string.rep("═",50))
local S=0
for R,_ in pairs(g)do
S=S+1
print(S..". "..R.." ("..#_.frames.." frames)")
end
if S==0 then
print("Nenhuma gravação salva!")
end
print(string.rep("═",50).."\n")
end})
local aq=an:CreateTab("⚡ Auto-Fase",1)
local T=false
local U=""
aq:CreateDropdown({Name="Selecionar Gravação",Options=function()
local ar={}
for R,_ in pairs(g)do
table.insert(ar,R)
end
return ar
end,CurrentOption="",Flag="AutoFaseRec",Callback=function(as)
U=as
end})
aq:CreateToggle({Name="Auto-Fase Loop",Default=false,Flag="AutoFaseToggle",Callback=function(ak)
T=ak
if T and U~=""then
task.spawn(function()
while T do
q(U)
task.wait(2)
end
end)
else
T=false
print("❌ Selecione uma gravação!")
end
end})
local at=an:CreateTab("🎮 Farm",2)
at:CreateToggle({Name="Auto Click",Default=false,Flag="AutoClickToggle",Callback=function(ak)
if ak and k then
task.spawn(function()
while ak do
pcall(function()
k.ClicouParaGanharEgo:FireServer()
end)
task.wait(0.05)
end
end)
end
end})
at:CreateToggle({Name="Anti-AFK",Default=true,Flag="AntiAFKToggle",Callback=function(ak)
if ak then
task.spawn(function()
while ak do
pcall(function()
game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Unknown,false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Unknown,false,game)
end)
task.wait(45)
end
end)
end
end})
local au=an:CreateTab("⚙️ Config",3)
au:CreateButton({Name="🎨 Tema Claro",Callback=function()
w:SetTheme("Light")
end})
au:CreateButton({Name="🎨 Tema Escuro",Callback=function()
w:SetTheme("Dark")
end})
au:CreateButton({Name="❌ FECHAR SCRIPT",Callback=function()
T=false
pcall(function()
an:Destroy()
end)
print("👋 Script Fechado!")
end})
w:Notify({Title="Koala Farm",Content="✅ Sistema de Gravação Carregado!",Duration=5})
end
print("\n"..string.rep("═",60))
print("✅ KOALA FARM - GRAVAÇÃO AVANÇADA")
print(string.rep("═",60))
print("📌 Script carregado com sucesso!")
print("🎮 Compatível com PC, Mobile e Tablets")
print("🔐 Script ofuscado e otimizado")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📊 Funcionalidades Principais:")
print("   ✅ Gravação de Movimentos em Tempo Real")
print("   ✅ Auto-Fase com Loop Infinito")
print("   ✅ Auto Click Automático")
print("   ✅ Anti-AFK Protegido")
print("   ✅ UI Rayfield ou Nativa")
print(string.rep("═",60).."\n")
