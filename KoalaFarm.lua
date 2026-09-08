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
local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="KoalaFarmMainUI"
ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndex=999
ScreenGui.Parent=PlayerGui
local MainFrame=Instance.new("Frame")
MainFrame.Name="MainFrame"
MainFrame.Size=UDim2.new(0,500,0,700)
MainFrame.Position=UDim2.new(0.5,-250,0.5,-350)
MainFrame.BackgroundColor3=Color3.fromRGB(20,20,30)
MainFrame.BorderSizePixel=0
MainFrame.Parent=ScreenGui
local Corners=Instance.new("UICorner")
Corners.CornerRadius=UDim.new(0,20)
Corners.Parent=MainFrame
local Shadow=Instance.new("Frame")
Shadow.Name="Shadow"
Shadow.Size=UDim2.new(1,20,1,20)
Shadow.Position=UDim2.new(0,-10,0,-10)
Shadow.BackgroundColor3=Color3.fromRGB(0,0,0)
Shadow.BorderSizePixel=0
Shadow.ZIndex=998
Shadow.Parent=ScreenGui
local ShadowCorner=Instance.new("UICorner")
ShadowCorner.CornerRadius=UDim.new(0,20)
ShadowCorner.Parent=Shadow
local TitleBar=Instance.new("Frame")
TitleBar.Name="TitleBar"
TitleBar.Size=UDim2.new(1,0,0,70)
TitleBar.BackgroundColor3=Color3.fromRGB(40,40,60)
TitleBar.BorderSizePixel=0
TitleBar.Parent=MainFrame
local TitleCorner=Instance.new("UICorner")
TitleCorner.CornerRadius=UDim.new(0,20)
TitleCorner.Parent=TitleBar
local TitleText=Instance.new("TextLabel")
TitleText.Name="TitleText"
TitleText.Size=UDim2.new(0.8,0,1,0)
TitleText.BackgroundTransparency=1
TitleText.TextColor3=Color3.fromRGB(255,200,0)
TitleText.TextSize=28
TitleText.Font=Enum.Font.GothamBold
TitleText.Text="🐨 KOALA FARM"
TitleText.TextXAlignment=Enum.TextXAlignment.Left
TitleText.TextScaled=false
TitleText.Parent=TitleBar
local CloseButton=Instance.new("TextButton")
CloseButton.Name="CloseButton"
CloseButton.Size=UDim2.new(0,50,0,50)
CloseButton.Position=UDim2.new(1,-60,0.5,-25)
CloseButton.BackgroundColor3=Color3.fromRGB(200,50,50)
CloseButton.TextColor3=Color3.fromRGB(255,255,255)
CloseButton.TextSize=24
CloseButton.Font=Enum.Font.GothamBold
CloseButton.Text="✕"
CloseButton.BorderSizePixel=0
CloseButton.Parent=TitleBar
local CloseCorner=Instance.new("UICorner")
CloseCorner.CornerRadius=UDim.new(0,10)
CloseCorner.Parent=CloseButton
CloseButton.MouseButton1Click:Connect(function()MainFrame.Visible=not MainFrame.Visible end)
local ScrollFrame=Instance.new("ScrollingFrame")
ScrollFrame.Name="ScrollFrame"
ScrollFrame.Size=UDim2.new(1,-30,1,-80)
ScrollFrame.Position=UDim2.new(0,15,0,75)
ScrollFrame.BackgroundColor3=Color3.fromRGB(20,20,30)
ScrollFrame.BorderSizePixel=0
ScrollFrame.ScrollBarThickness=6
ScrollFrame.ScrollBarImageColor3=Color3.fromRGB(255,200,0)
ScrollFrame.Parent=MainFrame
local UIListLayout=Instance.new("UIListLayout")
UIListLayout.Padding=UDim.new(0,12)
UIListLayout.Parent=ScrollFrame
ScrollFrame.CanvasSize=UDim2.new(0,0,0,0)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()ScrollFrame.CanvasSize=UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y+20)end)
local function CreateSection(title)
local SectionFrame=Instance.new("Frame")
SectionFrame.Name=title
SectionFrame.Size=UDim2.new(1,-20,0,40)
SectionFrame.BackgroundColor3=Color3.fromRGB(50,50,80)
SectionFrame.BorderSizePixel=0
SectionFrame.Parent=ScrollFrame
local SectionCorner=Instance.new("UICorner")
SectionCorner.CornerRadius=UDim.new(0,10)
SectionCorner.Parent=SectionFrame
local SectionLabel=Instance.new("TextLabel")
SectionLabel.Size=UDim2.new(1,-20,1,0)
SectionLabel.Position=UDim2.new(0,10,0,0)
SectionLabel.BackgroundTransparency=1
SectionLabel.TextColor3=Color3.fromRGB(255,200,0)
SectionLabel.TextSize=16
SectionLabel.Font=Enum.Font.GothamBold
SectionLabel.Text="━━ "..title.." ━━"
SectionLabel.TextXAlignment=Enum.TextXAlignment.Left
SectionLabel.Parent=SectionFrame
end
local function CreateButton(text,callback)
local ButtonFrame=Instance.new("Frame")
ButtonFrame.Name=text
ButtonFrame.Size=UDim2.new(1,-20,0,50)
ButtonFrame.BackgroundColor3=Color3.fromRGB(60,60,90)
ButtonFrame.BorderSizePixel=0
ButtonFrame.Parent=ScrollFrame
local ButtonCorner=Instance.new("UICorner")
ButtonCorner.CornerRadius=UDim.new(0,8)
ButtonCorner.Parent=ButtonFrame
local Button=Instance.new("TextButton")
Button.Name="Btn"
Button.Size=UDim2.new(1,0,1,0)
Button.BackgroundTransparency=1
Button.TextColor3=Color3.fromRGB(255,255,255)
Button.TextSize=16
Button.Font=Enum.Font.GothamBold
Button.Text=text
Button.Parent=ButtonFrame
Button.MouseButton1Click:Connect(callback)
Button.MouseEnter:Connect(function()ButtonFrame.BackgroundColor3=Color3.fromRGB(80,80,110)end)
Button.MouseLeave:Connect(function()ButtonFrame.BackgroundColor3=Color3.fromRGB(60,60,90)end)
end
local function CreateTextBox(placeholder,callback)
local TextBoxFrame=Instance.new("Frame")
TextBoxFrame.Size=UDim2.new(1,-20,0,50)
TextBoxFrame.BackgroundColor3=Color3.fromRGB(60,60,90)
TextBoxFrame.BorderSizePixel=0
TextBoxFrame.Parent=ScrollFrame
local TextBoxCorner=Instance.new("UICorner")
TextBoxCorner.CornerRadius=UDim.new(0,8)
TextBoxCorner.Parent=TextBoxFrame
local TextBox=Instance.new("TextBox")
TextBox.Size=UDim2.new(1,-10,1,0)
TextBox.Position=UDim2.new(0,5,0,0)
TextBox.BackgroundTransparency=1
TextBox.TextColor3=Color3.fromRGB(255,255,255)
TextBox.TextSize=14
TextBox.Font=Enum.Font.Gotham
TextBox.PlaceholderColor3=Color3.fromRGB(150,150,150)
TextBox.PlaceholderText=placeholder
TextBox.Text=""
TextBox.Parent=TextBoxFrame
TextBox:GetPropertyChangedSignal("Text"):Connect(function()callback(TextBox.Text)end)
end
local function CreateToggle(text,callback)
local ToggleFrame=Instance.new("Frame")
ToggleFrame.Name=text
ToggleFrame.Size=UDim2.new(1,-20,0,50)
ToggleFrame.BackgroundColor3=Color3.fromRGB(60,60,90)
ToggleFrame.BorderSizePixel=0
ToggleFrame.Parent=ScrollFrame
local ToggleCorner=Instance.new("UICorner")
ToggleCorner.CornerRadius=UDim.new(0,8)
ToggleCorner.Parent=ToggleFrame
local Label=Instance.new("TextLabel")
Label.Size=UDim2.new(0.7,0,1,0)
Label.BackgroundTransparency=1
Label.TextColor3=Color3.fromRGB(255,255,255)
Label.TextSize=14
Label.Font=Enum.Font.GothamBold
Label.Text=text
Label.TextXAlignment=Enum.TextXAlignment.Left
Label.Parent=ToggleFrame
local ToggleButton=Instance.new("TextButton")
ToggleButton.Size=UDim2.new(0,60,0,30)
ToggleButton.Position=UDim2.new(1,-70,0.5,-15)
ToggleButton.BackgroundColor3=Color3.fromRGB(100,100,100)
ToggleButton.TextColor3=Color3.fromRGB(255,255,255)
ToggleButton.TextSize=12
ToggleButton.Font=Enum.Font.GothamBold
ToggleButton.Text="OFF"
ToggleButton.BorderSizePixel=0
ToggleButton.Parent=ToggleFrame
local ToggleButtonCorner=Instance.new("UICorner")
ToggleButtonCorner.CornerRadius=UDim.new(0,6)
ToggleButtonCorner.Parent=ToggleButton
local state=false
ToggleButton.MouseButton1Click:Connect(function()
state=not state
ToggleButton.BackgroundColor3=state and Color3.fromRGB(0,200,50)or Color3.fromRGB(100,100,100)
ToggleButton.Text=state and"ON"or"OFF"
callback(state)
end)
end
local NameInput=""
CreateSection("📹 GRAVAÇÃO DE MOVIMENTOS")
CreateTextBox("Digite o nome da gravação...",function(text)NameInput=text~=""and text or"Gravacao_"..os.date("%H%M%S")end)
CreateButton("🔴 INICIAR GRAVAÇÃO",function()StartRecording(NameInput)end)
CreateButton("⏹️ PARAR GRAVAÇÃO",function()StopRecording()end)
CreateButton("▶️ REPRODUZIR ÚLTIMA",function()
local last=nil
for name,_ in pairs(RecordingData)do last=name break end
if last then PlayRecording(last)else print("❌ Nenhuma gravação!")end
end)
CreateButton("📊 LISTAR GRAVAÇÕES",function()
print("\n"..string.rep("═",60))
print("GRAVAÇÕES SALVAS:")
print(string.rep("═",60))
local i=0
for name,data in pairs(RecordingData)do i=i+1 print(i..". "..name.." ("..data.count.." frames)")end
if i==0 then print("Nenhuma gravação salva!")end
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
CreateToggle("⚡ AUTO-FASE LOOP",function(state)
AutoFaseActive=state
if state and SelectedRecording~=""then
task.spawn(function()
while AutoFaseActive do PlayRecording(SelectedRecording)task.wait(2)end
end)
else
AutoFaseActive=false
if state then print("❌ Selecione uma gravação primeiro!")end
end
end)
CreateSection("🎮 FARM")
local AutoClickActive=false
CreateToggle("🖱️ AUTO CLICK",function(state)
AutoClickActive=state
if state and Remotes then
task.spawn(function()
while AutoClickActive do
pcall(function()Remotes.ClicouParaGanharEgo:FireServer()end)
task.wait(0.05)
end
end)
end
end)
local AntiAFKActive=true
CreateToggle("🛡️ ANTI-AFK",function(state)
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
end
end)
print("\n"..string.rep("═",70))
print("✅ KOALA FARM v1.0 - CARREGADO COM SUCESSO!")
print(string.rep("═",70))
print("📌 PRESSIONE: RightControl (Ctrl Direito) para abrir/fechar a UI")
print("🎮 COMPATÍVEL: PC, Mobile, Tablets")
print("🔐 SCRIPT: Ofuscado e Otimizado")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📊 FUNCIONALIDADES:")
print("   ✅ Gravação de Movimentos em Tempo Real")
print("   ✅ Auto-Fase com Loop Infinito")
print("   ✅ Auto Click Automático")
print("   ✅ Anti-AFK Protegido")
print("   ✅ Coletar Presentes e Recompensas")
print(string.rep("═",70).."\n")
