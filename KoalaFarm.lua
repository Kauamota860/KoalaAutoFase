wait(0.5)
print("Iniciando Koala Farm...")

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

print("Player GUI encontrado")

-- Limpar UIs antigas
for _, gui in pairs(PlayerGui:GetChildren()) do
    if gui.Name == "KoalaFarmUI" then
        gui:Destroy()
    end
end

local RecordingData = {}
local IsRecording = false
local RecordingName = ""
local Frames = {}
local SelectedRecording = ""
local AutoFaseActive = false
local AutoClickActive = false
local AntiAFKActive = false

local function GetHRP()
    local c = LP.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

local function StartRecording(name)
    IsRecording = true
    RecordingName = name or "Gravacao_" .. os.date("%H%M%S")
    Frames = {}
    print("🔴 GRAVANDO: " .. RecordingName)
end

local function StopRecording()
    if not IsRecording then return end
    IsRecording = false
    RecordingData[RecordingName] = {frames = Frames, count = #Frames}
    print("✅ SALVO: " .. RecordingName .. " (" .. #Frames .. " frames)")
end

local function PlayRecording(name)
    local data = RecordingData[name]
    if not data then
        print("❌ Não encontrado!")
        return
    end
    task.spawn(function()
        for _, cframe in ipairs(data.frames) do
            pcall(function()
                local hrp = GetHRP()
                if hrp then
                    hrp.CFrame = cframe
                    task.wait(0.05)
                end
            end)
        end
    end)
    print("▶️ REPRODUZINDO: " .. name)
end

local Remotes = nil
pcall(function()
    Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
end)

local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
    if not IsRecording then return end
    pcall(function()
        local hrp = GetHRP()
        if hrp then
            table.insert(Frames, hrp.CFrame)
        end
    end)
end)

-- CRIAR UI
print("Criando interface...")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoalaFarmUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndex = 9999
ScreenGui.Enabled = true
ScreenGui.DisplayOrder = 9999
ScreenGui.Parent = PlayerGui

print("ScreenGui criado")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 800)
MainFrame.Position = UDim2.new(0.5, -275, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

print("MainFrame criado")

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 200, 0)
Stroke.Thickness = 3
Stroke.Parent = MainFrame

-- TITULO
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 90)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.fromRGB(255, 200, 0)
TitleText.TextSize = 40
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "🐨 KOALA FARM"
TitleText.Parent = TitleBar

-- BOTAO FECHAR
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 60, 0, 60)
CloseButton.Position = UDim2.new(1, -75, 0, 15)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 30
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- SCROLL
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -105)
ScrollFrame.Position = UDim2.new(0, 10, 0, 95)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 0)
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollFrame

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)

local function CreateLabel(text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 35)
    Label.BackgroundColor3 = Color3.fromRGB(50, 50, 90)
    Label.TextColor3 = Color3.fromRGB(255, 200, 0)
    Label.TextSize = 16
    Label.Font = Enum.Font.GothamBold
    Label.Text = text
    Label.BorderSizePixel = 0
    Label.Parent = ScrollFrame
    
    local Cor = Instance.new("UICorner")
    Cor.CornerRadius = UDim.new(0, 8)
    Cor.Parent = Label
end

local function CreateButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold
    Button.Text = text
    Button.BorderSizePixel = 0
    Button.Parent = ScrollFrame
    
    local Cor = Instance.new("UICorner")
    Cor.CornerRadius = UDim.new(0, 8)
    Cor.Parent = Button
    
    Button.MouseButton1Click:Connect(callback)
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(100, 100, 140)
    end)
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    end)
end

local function CreateTextBox(placeholder)
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -20, 0, 50)
    TextBox.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextSize = 14
    TextBox.Font = Enum.Font.Gotham
    TextBox.PlaceholderText = placeholder
    TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    TextBox.BorderSizePixel = 0
    TextBox.Parent = ScrollFrame
    
    local Cor = Instance.new("UICorner")
    Cor.CornerRadius = UDim.new(0, 8)
    Cor.Parent = TextBox
    
    return TextBox
end

local function CreateToggle(text, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -20, 0, 50)
    Container.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
    Container.BorderSizePixel = 0
    Container.Parent = ScrollFrame
    
    local Cor = Instance.new("UICorner")
    Cor.CornerRadius = UDim.new(0, 8)
    Cor.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.Text = text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 70, 0, 35)
    Toggle.Position = UDim2.new(1, -80, 0.5, -17)
    Toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 12
    Toggle.Font = Enum.Font.GothamBold
    Toggle.Text = "OFF"
    Toggle.BorderSizePixel = 0
    Toggle.Parent = Container
    
    local TogCorner = Instance.new("UICorner")
    TogCorner.CornerRadius = UDim.new(0, 6)
    TogCorner.Parent = Toggle
    
    local state = false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 50) or Color3.fromRGB(100, 100, 100)
        Toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)
end

-- CONTEUDO
local NameInput = ""

CreateLabel("📹 GRAVAÇÃO DE MOVIMENTOS")

local InputBox = CreateTextBox("Nome da gravação...")
InputBox:GetPropertyChangedSignal("Text"):Connect(function()
    NameInput = InputBox.Text ~= "" and InputBox.Text or "Gravacao_" .. os.date("%H%M%S")
end)

CreateButton("🔴 INICIAR GRAVAÇÃO", function()
    StartRecording(NameInput)
end)

CreateButton("⏹️ PARAR GRAVAÇÃO", function()
    StopRecording()
end)

CreateButton("▶️ REPRODUZIR ÚLTIMA", function()
    local last = nil
    for name, _ in pairs(RecordingData) do
        last = name
        break
    end
    if last then
        PlayRecording(last)
    else
        print("❌ Nenhuma gravação!")
    end
end)

CreateButton("📊 LISTAR GRAVAÇÕES", function()
    print("\n" .. string.rep("═", 60))
    print("GRAVAÇÕES SALVAS:")
    print(string.rep("═", 60))
    local i = 0
    for name, data in pairs(RecordingData) do
        i = i + 1
        print(i .. ". " .. name .. " (" .. data.count .. " frames)")
    end
    if i == 0 then
        print("❌ Nenhuma gravação salva!")
    end
    print(string.rep("═", 60) .. "\n")
end)

CreateLabel("⚡ AUTO-FASE")

CreateButton("🔹 SELECIONAR GRAVAÇÃO", function()
    local first = nil
    for name, _ in pairs(RecordingData) do
        first = name
        break
    end
    if first then
        SelectedRecording = first
        print("✅ Selecionado: " .. first)
    else
        print("❌ Nenhuma gravação!")
    end
end)

CreateToggle("⚡ AUTO-FASE LOOP", function(state)
    AutoFaseActive = state
    if state and SelectedRecording ~= "" then
        task.spawn(function()
            while AutoFaseActive do
                PlayRecording(SelectedRecording)
                task.wait(2)
            end
        end)
        print("✅ Auto-Fase iniciado!")
    else
        AutoFaseActive = false
        if state then
            print("❌ Selecione uma gravação primeiro!")
        end
    end
end)

CreateLabel("🎮 FARM AUTOMÁTICO")

CreateToggle("🖱️ AUTO CLICK", function(state)
    AutoClickActive = state
    if state and Remotes then
        task.spawn(function()
            while AutoClickActive do
                pcall(function()
                    Remotes.ClicouParaGanharEgo:FireServer()
                end)
                task.wait(0.05)
            end
        end)
        print("✅ Auto Click ativado!")
    end
end)

CreateToggle("🛡️ ANTI-AFK", function(state)
    AntiAFKActive = state
    if state then
        task.spawn(function()
            while AntiAFKActive do
                pcall(function()
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Unknown, false, game)
                end)
                task.wait(45)
            end
        end)
        print("✅ Anti-AFK ativado!")
    end
end)

CreateButton("🎁 COLETAR PRESENTES", function()
    if Remotes then
        task.spawn(function()
            for id = 1, 12 do
                pcall(function()
                    Remotes.GiftRemotes.Claim:InvokeServer(id)
                end)
                task.wait(0.2)
            end
        end)
        print("✅ Coletando presentes!")
    end
end)

CreateButton("💰 COLETAR GRUPO", function()
    if Remotes then
        pcall(function()
            Remotes.GroupRewardRemotes.Claim:InvokeServer()
        end)
        print("✅ Recompensa do grupo coletada!")
    end
end)

CreateLabel("⚙️ CONTROLES")

CreateButton("❌ FECHAR HUB", function()
    AutoFaseActive = false
    AutoClickActive = false
    AntiAFKActive = false
    ScreenGui:Destroy()
    print("👋 Koala Farm Fechado!")
end)

-- ATALHOS
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("\n" .. string.rep("═", 70))
print("✅ KOALA FARM v1.0 - CARREGADO COM SUCESSO!")
print(string.rep("═", 70))
print("🎯 A INTERFACE ESTÁ VISÍVEL NA SUA TELA!")
print("📌 Pressione: RightControl (Ctrl Direito) para abrir/fechar")
print("🎮 Compatível: PC, Mobile, Tablets")
print(string.rep("═", 70) .. "\n")
