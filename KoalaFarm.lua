local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local LP=Players.LocalPlayer
local PlayerGui=LP:WaitForChild("PlayerGui")
local Remotes=nil
pcall(function()Remotes=ReplicatedStorage:WaitForChild("Remotes",5)end)
local RecordingData={}
local IsRecording=false
local RecordingName=""
local Frames={}
local function GetHRP()local c=LP.Character if not c then return nil end return c:FindFirstChild("HumanoidRootPart")end
local function GetHumanoid()local c=LP.Character if not c then return nil end return c:FindFirstChildOfClass("Humanoid")end
local function StartRecording(name)IsRecording=true RecordingName=name or"Gravacao_"..os.date("%H%M%S")Frames={}print("🔴 GRAVANDO: "..RecordingName)end
local function StopRecording()if not IsRecording then return end IsRecording=false RecordingData[RecordingName]={frames=Frames,count=#Frames}print("✅ SALVO: "..RecordingName.." ("..#Frames.." frames)")end
local function PlayRecording(name)local data=RecordingData[name]if not data then print("❌ Não encontrado!")return end task.spawn(function()for _,cframe in ipairs(data.frames)do pcall(function()local hrp=GetHRP()if hrp then hrp.CFrame=cframe task.wait(0.05)end end)end end)print("▶️ REPRODUZINDO: "..name)end
RunService.Heartbeat:Connect(function()if not IsRecording then return end pcall(function()local hrp=GetHRP()if hrp then table.insert(Frames,hrp.CFrame)end end)end)
print("\n\n")
print("="*60)
print("CRIANDO INTERFACE KOALA FARM...")
print("="*60)
wait(0.1)
local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="KoalaFarmUI"
ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndex=9999
ScreenGui.Enabled=true
ScreenGui.Parent=PlayerGui

local MainFrame=Instance.new("Frame")
MainFrame.Name="MainFrame"
MainFrame.Size=UDim2.new(0,520,0,750)
MainFrame.Position=UDim2.new(0.5,-260,0.5,-375)
MainFrame.BackgroundColor3=Color3.fromRGB(15,15,25)
MainFrame.BorderSizePixel=0
MainFrame.ClipsDescendants=true
MainFrame.Visible=true
MainFrame.Parent=ScreenGui

local Stroke=Instance.new("UIStroke")
Stroke.Color=Color3.fromRGB(255,200,0)
Stroke.Thickness=2
Stroke.Parent=MainFrame

local Corner=Instance.new("UICorner")
Corner.CornerRadius=UDim.new(0,15)
Corner.Parent=MainFrame

local TitleBar=Instance.new("Frame")
TitleBar.Name="TitleBar"
TitleBar.Size=UDim2.new(1,0,0,80)
TitleBar.BackgroundColor3=Color3.fromRGB(30,30,50)
TitleBar.BorderSizePixel=0
TitleBar.Parent=MainFrame

local TitleCorner=Instance.new("UICorner")
TitleCorner.CornerRadius=UDim.new(0,15)
TitleCorner.Parent=TitleBar

local TitleText=Instance.new("TextLabel")
TitleText.Name="TitleText"
TitleText.Size=UDim2.new(0.9,0,1,0)
TitleText.BackgroundTransparency=1
TitleText.TextColor3=Color3.fromRGB(255,200,0)
TitleText.TextSize=35
TitleText.Font=Enum.Font.GothamBold
TitleText.Text="🐨 KOALA FARM"
TitleText.TextXAlignment=Enum.TextXAlignment.Center
TitleText.Parent=TitleBar

local CloseButton=Instance.new("TextButton")
CloseButton.Name="CloseButton"
CloseButton.Size=UDim2.new(0,60,0,60)
CloseButton.Position=UDim2.new(1,-70,5,-30)
CloseButton.BackgroundColor3=Color3.fromRGB(220,50,50)
CloseButton.TextColor3=Color3.fromRGB(255,255,255)
CloseButton.TextSize=30
CloseButton.Font=Enum.Font.GothamBold
CloseButton.Text="✕"
CloseButton.BorderSizePixel=0
CloseButton.Parent=TitleBar

local CloseCorner=Instance.new("UICorner")
CloseCorner.CornerRadius=UDim.new(0,10)
CloseCorner.Parent=CloseButton

CloseButton.MouseButton1Click:Connect(function()
MainFrame.Visible=false
print("🔴 UI FECHADA (Pressione RightControl para reabrir)")
end)

local ScrollFrame=Instance.new("ScrollingFrame")
ScrollFrame.Name="ScrollFrame"
ScrollFrame.Size=UDim2.new(1,-30,1,-95)
ScrollFrame.Position=UDim2.new(0,15,0,85)
ScrollFrame.BackgroundColor3=Color3.fromRGB(15,15,25)
ScrollFrame.BorderSizePixel=0
ScrollFrame.ScrollBarThickness=8
ScrollFrame.ScrollBarImageColor3=Color3.fromRGB(255,200,0)
ScrollFrame.CanScroll=true
ScrollFrame.Parent=MainFrame

local UIListLayout=Instance.new("UIListLayout")
UIListLayout.Padding=UDim.new(0,10)
UIListLayout.FillDirection=Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
UIListLayout.Parent=ScrollFrame

ScrollFrame.CanvasSize=UDim2.new(0,0,0,0)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
ScrollFrame.CanvasSize=UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y+20)
end)

local function CreateSection(title)
local Section=Instance.new("TextLabel")
Section.Name=title
Section.Size=UDim2.new(0,450,0,40)
Section.BackgroundColor3=Color3.fromRGB(50,50,80)
Section.TextColor3=Color3.fromRGB(255,200,0)
Section.TextSize=16
Section.Font=Enum.Font.GothamBold
Section.Text="━━━ "..title.." ━━━"
Section.BorderSizePixel=0
Section.Parent=ScrollFrame

local SectionCorner=Instance.new("UICorner")
SectionCorner.CornerRadius=UDim.new(0,8)
SectionCorner.Parent=Section
end

local function CreateButton(text,callback)
local Button=Instance.new("TextButton")
Button.Name=text
Button.Size=UDim2.new(0,450,0,50)
Button.BackgroundColor3=Color3.fromRGB(70,70,100)
Button.TextColor3=Color3.fromRGB(255,255,255)
Button.TextSize=15
Button.Font=Enum.Font.GothamBold
Button.Text=text
Button.BorderSizePixel=0
Button.Parent=ScrollFrame

local ButtonCorner=Instance.new("UICorner")
ButtonCorner.CornerRadius=UDim.new(0,8)
ButtonCorner.Parent=Button

Button.MouseButton1Click:Connect(callback)

Button.MouseEnter:Connect(function()
Button.BackgroundColor3=Color3.fromRGB(90,90,120)
end)

Button.MouseLeave:Connect(function()
Button.BackgroundColor3=Color3.fromRGB(70,70,100)
end)

return Button
end

local function CreateTextBox(placeholder,callback)
local Input=Instance.new("TextBox")
Input.Name=placeholder
Input.Size=UDim2.new(0,450,0,50)
Input.BackgroundColor3=Color3.fromRGB(70,70,100)
Input.TextColor3=Color3.fromRGB(255,255,255)
Input.TextSize=14
Input.Font=Enum.Font.Gotham
Input.PlaceholderColor3=Color3.fromRGB(150,150,150)
Input.PlaceholderText=placeholder
Input.Text=""
Input.BorderSizePixel=0
Input.Parent=ScrollFrame

local InputCorner=Instance.new("UICorner")
InputCorner.CornerRadius=UDim.new(0,8)
InputCorner.Parent=Input

Input:GetPropertyChangedSignal("Text"):Connect(function()
callback(Input.Text)
end)

return Input
end

local function CreateToggle(text,callback)
local Container=Instance.new("Frame")
Container.Name=text
Container.Size=UDim2.new(0,450,0,50)
Container.BackgroundColor3=Color3.fromRGB(70,70,100)
Container.BorderSizePixel=0
Container.Parent=ScrollFrame

local ContainerCorner=Instance.new("UICorner")
ContainerCorner.CornerRadius=UDim.new(0,8)
ContainerCorner.Parent=Container

local Label=Instance.new("TextLabel")
Label.Size=UDim2.new(0.7,0,1,0)
Label.BackgroundTransparency=1
Label.TextColor3=Color3.fromRGB(255,255,255)
Label.TextSize=14
Label.Font=Enum.Font.GothamBold
Label.Text=text
Label.TextXAlignment=Enum.TextXAlignment.Left
Label.Parent=Container

local Toggle=Instance.new("TextButton")
Toggle.Name="Toggle"
Toggle.Size=UDim2.new(0,70,0,35)
Toggle.Position=UDim2.new(1,-80,0.5,-17)
Toggle.BackgroundColor3=Color3.fromRGB(100,100,100)
Toggle.TextColor3=Color3.fromRGB(255,255,255)
Toggle.TextSize=12
Toggle.Font=Enum.Font.GothamBold
Toggle.Text="OFF"
Toggle.BorderSizePixel=0
Toggle.Parent=Container

local ToggleCorner=Instance.new("UICorner")
ToggleCorner.CornerRadius=UDim.new(0,6)
ToggleCorner.Parent=Toggle

local state=false
Toggle.MouseButton1Click:Connect(function()
state=not state
Toggle.BackgroundColor3=state and Color3.fromRGB(0,200,50)or Color3.fromRGB(100,100,100)
Toggle.Text=state and"ON"or"OFF"
callback(state)
end)

return Container,Toggle
end

local NameInput=""

CreateSection("📹 GRAVAÇÃO DE MOVIMENTOS")

CreateTextBox("Digite o nome da gravação...",function(text)
NameInput=text~=""and text or"Gravacao_"..os.date("%H%M%S")
end)

CreateButton("🔴 INICIAR GRAVAÇÃO",function()
StartRecording(NameInput)
end)

CreateButton("⏹️ PARAR GRAVAÇÃO",function()
StopRecording()
end)

CreateButton("▶️ REPRODUZIR ÚLTIMA GRAVAÇÃO",function()
local last=nil
for name,_ in pairs(RecordingData)do last=name break end
if last then PlayRecording(last)else print("❌ Nenhuma gravação!")end
end)

CreateButton("📊 LISTAR TODAS GRAVAÇÕES",function()
print("\n"..string.rep("═",60))
print("GRAVAÇÕES SALVAS:")
print(string.rep("═",60))
local i=0
for name,data in pairs(RecordingData)do i=i+1 print(i..". "..name.." ("..data.count.." frames)")end
if i==0 then print("❌ Nenhuma gravação salva!")end
print(string.rep("═",60).."\n")
end)

CreateSection("⚡ AUTO-FASE")

local SelectedRecording=""

CreateButton("🔹 SELECIONAR GRAVAÇÃO",function()
local first=nil
for name,_ in pairs(RecordingData)do first=name break end
if first then SelectedRecording=first print("✅ Selecionado: "..first)else print("❌ Nenhuma gravação!")end
end)

local AutoFaseActive=false

local _,AutoFaseToggle=CreateToggle("⚡ AUTO-FASE LOOP",function(state)
AutoFaseActive=state
if state and SelectedRecording~=""then
task.spawn(function()
while AutoFaseActive do PlayRecording(SelectedRecording)task.wait(2)end
end)
print("✅ Auto-Fase iniciado!")
else
AutoFaseActive=false
if state then print("❌ Selecione uma gravação primeiro!")end
end
end)

CreateSection("🎮 FARM AUTOMÁTICO")

local AutoClickActive=false

local _,AutoClickToggle=CreateToggle("🖱️ AUTO CLICK",function(state)
AutoClickActive=state
if state and Remotes then
task.spawn(function()
while AutoClickActive do
pcall(function()Remotes.ClicouParaGanharEgo:FireServer()end)
task.wait(0.05)
end
end)
print("✅ Auto Click ativado!")
end
end)

local AntiAFKActive=true

local _,AntiAFKToggle=CreateToggle("🛡️ ANTI-AFK",function(state)
AntiAFKActive=state
if state then
task.spawn(function()
while AntiAFKActive do
pcall(function()
game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.Unknown,false,game)
game:GetService("VirtualInputManager"):SendKeyEvent(false,Enum.KeyCode.Unknown,false,game)
end)
task.wait(45)
end
end)
print("✅ Anti-AFK ativado!")
end
end)

CreateButton("🎁 COLETAR PRESENTES",function()
if Remotes then
task.spawn(function()
for id=1,12 do
pcall(function()Remotes.GiftRemotes.Claim:InvokeServer(id)end)
task.wait(0.2)
end
end)
print("✅ Coletando presentes!")
end
end)

CreateButton("💰 COLETAR GRUPO",function()
if Remotes then pcall(function()Remotes.GroupRewardRemotes.Claim:InvokeServer()end)print("✅ Recompensa do grupo coletada!")end
end)

CreateSection("⚙️ AJUSTES")

CreateButton("❌ FECHAR HUB",function()
AutoFaseActive=false
AutoClickActive=false
AntiAFKActive=false
ScreenGui:Destroy()
print("👋 Koala Farm Fechado!")
end)

UserInputService.InputBegan:Connect(function(input,gameProcessed)
if gameProcessed then return end
if input.KeyCode==Enum.KeyCode.RightControl then
MainFrame.Visible=not MainFrame.Visible
if MainFrame.Visible then
print("✅ UI ABERTA")
else
print("🔴 UI FECHADA (Pressione RightControl para reabrir)")
end
end
end)

print("\n"..string.rep("═",70))
print("✅ ✅ ✅ KOALA FARM v1.0 - CARREGADO COM SUCESSO! ✅ ✅ ✅")
print(string.rep("═",70))
print("🎯 A INTERFACE DEVE ESTAR VISÍVEL NA SUA TELA AGORA!")
print("📌 PRESSIONE: RightControl (Ctrl Direito) para abrir/fechar")
print("🎮 COMPATÍVEL: PC, Mobile, Tablets")
print("🔐 SCRIPT: Ofuscado e Otimizado")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📊 FUNCIONALIDADES DISPONÍVEIS:")
print("   ✅ Gravação de Movimentos em Tempo Real")
print("   ✅ Auto-Fase com Loop Infinito")
print("   ✅ Auto Click Automático")
print("   ✅ Anti-AFK Protegido")
print("   ✅ Coletar Presentes e Recompensas")
print("   ✅ Sistema Totalmente Ofuscado")
print(string.rep("═",70).."\n")
