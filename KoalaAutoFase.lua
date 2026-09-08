--[[
    ██╗  ██╗ ██████╗  █████╗ ██╗      █████╗     ██╗  ██╗██╗   ██╗██████╗
    ██║ ██╔╝██╔═══██╗██╔══██╗██║     ██╔══██╗    ██║  ██║██║   ██║██╔══██╗
    █████╔╝ ██║   ██║███████║██║     ███████║    ███████║██║   ██║██████╔╝
    ██╔═██╗ ██║   ██║██╔══██║██║     ██╔══██║    ██╔══██║██║   ██║██╔══██╗
    ██║  ██╗╚██████╔╝██║  ██║███████╗██║  ██║    ██║  ██║╚██████╔╝██████╔╝
    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝

    KOALA HUB v4.0 — UI NATIVA 100% FUNCIONAL
    Compatível com: PC, Mobile, Tablets, Arceus, Delta
    Discord: https://discord.gg/ZRFffEgQQM
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local Remotes = nil

pcall(function()
    Remotes = RS:WaitForChild("Remotes", 5)
end)

print("\n" .. string.rep("═", 60))
print("✅ KOALA HUB v4.0 - INICIANDO INTERFACE")
print(string.rep("═", 60) .. "\n")

--==================================================================--
-- CRIAR GUI NA TELA
--==================================================================--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KoalaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndex = 1000
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

-- TEMA CORES
local COLOR_BG = Color3.fromRGB(25, 25, 35)
local COLOR_HEADER = Color3.fromRGB(50, 50, 60)
local COLOR_BUTTON = Color3.fromRGB(60, 60, 70)
local COLOR_BUTTON_HOVER = Color3.fromRGB(80, 80, 90)
local COLOR_TEXT = Color3.fromRGB(255, 255, 255)
local COLOR_ACCENT = Color3.fromRGB(255, 200, 0)

-- FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 650)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -325)
MainFrame.BackgroundColor3 = COLOR_BG
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- CORNER RADIUS
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

-- TÍTULO
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = COLOR_HEADER
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.9, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = COLOR_ACCENT
TitleText.TextSize = 22
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "🐨 KOALA HUB v4.0"
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- BOTÃO FECHAR
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = COLOR_TEXT
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- SCROLL FRAME
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -80)
ScrollFrame.Position = UDim2.new(0, 10, 0, 70)
ScrollFrame.BackgroundColor3 = COLOR_BG
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.ScrollBarImageColor3 = COLOR_ACCENT
ScrollFrame.Parent = MainFrame

-- LAYOUT
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollFrame

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end)

--==================================================================--
-- FUNÇÕES AUXILIARES
--==================================================================--

local function CreateSection(name)
    local Section = Instance.new("Frame")
    Section.Name = name
    Section.Size = UDim2.new(1, -20, 0, 35)
    Section.BackgroundColor3 = COLOR_HEADER
    Section.BorderSizePixel = 0
    Section.Parent = ScrollFrame
    
    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 8)
    SectionCorner.Parent = Section
    
    local SectionText = Instance.new("TextLabel")
    SectionText.Size = UDim2.new(1, -10, 1, 0)
    SectionText.Position = UDim2.new(0, 5, 0, 0)
    SectionText.BackgroundTransparency = 1
    SectionText.TextColor3 = COLOR_ACCENT
    SectionText.TextSize = 14
    SectionText.Font = Enum.Font.GothamBold
    SectionText.Text = "━━ " .. name .. " ━━"
    SectionText.TextXAlignment = Enum.TextXAlignment.Left
    SectionText.Parent = Section
    
    return Section
end

local function CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = text
    Button.Size = UDim2.new(1, -20, 0, 40)
    Button.BackgroundColor3 = COLOR_BUTTON
    Button.TextColor3 = COLOR_TEXT
    Button.TextSize = 13
    Button.Font = Enum.Font.Gotham
    Button.Text = text
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = COLOR_BUTTON_HOVER
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = COLOR_BUTTON
    end)
    
    Button.MouseButton1Click:Connect(callback)
    
    return Button
end

local function CreateToggle(parent, text, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -20, 0, 40)
    Container.BackgroundColor3 = COLOR_BUTTON
    Container.BorderSizePixel = 0
    Container.Parent = parent
    
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
    ContainerCorner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.75, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = COLOR_TEXT
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Container
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 25)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    ToggleBtn.TextColor3 = COLOR_TEXT
    ToggleBtn.TextSize = 11
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Text = "OFF"
    ToggleBtn.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleBtn
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
        ToggleBtn.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    return Container, ToggleBtn
end

--==================================================================--
-- SISTEMA DE GRAVAÇÃO
--==================================================================--
local MotionRecorder = {
    Recording = false,
    Recordings = {},
    CurrentName = "",
    Frames = {},
    StartTime = 0,
}

local function StartRecording(nome)
    MotionRecorder.Recording = true
    MotionRecorder.CurrentName = nome
    MotionRecorder.Frames = {}
    MotionRecorder.StartTime = tick()
    print("🔴 Gravando: " .. nome)
end

local function StopRecording()
    if not MotionRecorder.Recording then return end
    MotionRecorder.Recording = false
    local nome = MotionRecorder.CurrentName
    MotionRecorder.Recordings[nome] = MotionRecorder.Frames
    print("✅ Salvo: " .. nome .. " (" .. #MotionRecorder.Frames .. " frames)")
end

local function PlayRecording(nome)
    local rec = MotionRecorder.Recordings[nome]
    if not rec then
        print("❌ Gravação não encontrada!")
        return
    end
    
    task.spawn(function()
        for _, frame in ipairs(rec) do
            pcall(function()
                local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = frame
                    task.wait(0.05)
                end
            end)
        end
    end)
    print("▶️ Reproduzindo: " .. nome)
end

-- Grava movimentos em tempo real
RunService.Heartbeat:Connect(function()
    if not MotionRecorder.Recording then return end
    pcall(function()
        local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if root then
            table.insert(MotionRecorder.Frames, root.CFrame)
        end
    end)
end)

--==================================================================--
-- FLAGS
--==================================================================--
local Flags = {
    AutoClick = false,
    AutoFase = false,
    AntiLag = false,
    Noclip = false,
}

--==================================================================--
-- ANTI-LAG
--==================================================================--
local function EnableAntiLag()
    pcall(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 0
        settings.GraphicsQualityLevel = 1
        print("⚡ Anti-Lag Ativado")
    end)
end

local function DisableAntiLag()
    pcall(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 1
        settings.GraphicsQualityLevel = 3
        print("⚡ Anti-Lag Desativado")
    end)
end

--==================================================================--
-- NOCLIP
--==================================================================--
RunService.Stepped:Connect(function()
    if not Flags.Noclip then return end
    pcall(function()
        local c = LP.Character
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then
                    p.CanCollide = false
                end
            end
        end
    end)
end)

--==================================================================--
-- CONSTRUIR INTERFACE
--==================================================================--

-- SEÇÃO: GRAVAÇÃO
CreateSection("GRAVAÇÃO DE MOVIMENTOS")

local nomeInput = "Gravação_" .. os.date("%H%M%S")
local gravacaoAtual = ""

local inputContainer = Instance.new("Frame")
inputContainer.Size = UDim2.new(1, -20, 0, 40)
inputContainer.BackgroundColor3 = COLOR_BUTTON
inputContainer.BorderSizePixel = 0
inputContainer.Parent = ScrollFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputContainer

local textInput = Instance.new("TextBox")
textInput.Size = UDim2.new(1, -10, 1, 0)
textInput.Position = UDim2.new(0, 5, 0, 0)
textInput.BackgroundTransparency = 1
textInput.TextColor3 = COLOR_TEXT
textInput.TextSize = 12
textInput.Font = Enum.Font.Gotham
textInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
textInput.PlaceholderText = "Nome da gravação..."
textInput.Text = ""
textInput.Parent = inputContainer

textInput:GetPropertyChangedSignal("Text"):Connect(function()
    nomeInput = textInput.Text ~= "" and textInput.Text or "Gravação_" .. os.date("%H%M%S")
end)

local recordingToggle, recordingBtn = CreateToggle(ScrollFrame, "🔴 Gravar Movimento", function(state)
    if state then
        StartRecording(nomeInput)
    else
        StopRecording()
    end
end)

CreateButton(ScrollFrame, "▶️ Reproduzir Última", function()
    local ultima = nil
    for nome, _ in pairs(MotionRecorder.Recordings) do
        ultima = nome
        break
    end
    if ultima then
        PlayRecording(ultima)
    else
        print("❌ Nenhuma gravação!")
    end
end)

CreateButton(ScrollFrame, "📊 Listar Gravações", function()
    print("\n" .. string.rep("═", 50))
    print("GRAVAÇÕES SALVAS:")
    print(string.rep("═", 50))
    local i = 0
    for nome, data in pairs(MotionRecorder.Recordings) do
        i = i + 1
        print(i .. ". " .. nome .. " (" .. #data .. " frames)")
    end
    if i == 0 then
        print("Nenhuma gravação salva!")
    end
    print(string.rep("═", 50) .. "\n")
end)

-- SEÇÃO: AUTO-FASE
CreateSection("AUTO-FASE")

local autoFaseToggle, autoFaseBtn = CreateToggle(ScrollFrame, "⚡ Auto-Fase (Loop)", function(state)
    Flags.AutoFase = state
    if state then
        local ultima = nil
        for nome, _ in pairs(MotionRecorder.Recordings) do
            ultima = nome
            break
        end
        if ultima then
            task.spawn(function()
                while Flags.AutoFase do
                    PlayRecording(ultima)
                    task.wait(2)
                end
            end)
        else
            print("❌ Selecione uma gravação!")
            autoFaseBtn.Text = "OFF"
            autoFaseBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            Flags.AutoFase = false
        end
    end
end)

-- SEÇÃO: OTIMIZAÇÃO
CreateSection("OTIMIZAÇÃO")

local antiLagToggle, antiLagBtn = CreateToggle(ScrollFrame, "⚡ Anti-Lag", function(state)
    Flags.AntiLag = state
    if state then
        EnableAntiLag()
    else
        DisableAntiLag()
    end
end)

local noclipToggle, noclipBtn = CreateToggle(ScrollFrame, "👻 Noclip", function(state)
    Flags.Noclip = state
    if not state then
        local c = LP.Character
        if c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then
                    pcall(function() p.CanCollide = true end)
                end
            end
        end
    end
end)

-- SEÇÃO: FARM
CreateSection("FARM")

local autoClickToggle, autoClickBtn = CreateToggle(ScrollFrame, "🖱️ Auto Click", function(state)
    Flags.AutoClick = state
    if state and Remotes then
        task.spawn(function()
            while Flags.AutoClick do
                pcall(function()
                    Remotes.ClicouParaGanharEgo:FireServer()
                end)
                task.wait(0.05)
            end
        end)
    end
end)

CreateButton(ScrollFrame, "🎁 Coletar Presentes", function()
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

CreateButton(ScrollFrame, "💰 Coletar Grupo", function()
    if Remotes then
        pcall(function()
            Remotes.GroupRewardRemotes.Claim:InvokeServer()
        end)
        print("✅ Coletado!")
    end
end)

-- SEÇÃO: AJUSTES
CreateSection("AJUSTES")

CreateButton(ScrollFrame, "❌ FECHAR HUB", function()
    MainFrame.Visible = false
    Flags.AutoClick = false
    Flags.AutoFase = false
    Flags.AntiLag = false
    Flags.Noclip = false
    print("👋 Hub Fechado!")
end)

--==================================================================--
-- ATALHOS DE TECLADO
--==================================================================--
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- RightControl para abrir/fechar
    if input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

--==================================================================--
-- MENSAGEM INICIAL
--==================================================================--
print("\n" .. string.rep("═", 60))
print("✅ KOALA HUB v4.0 CARREGADO COM SUCESSO!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📌 Pressione RightControl (Ctrl Direito) para abrir/fechar")
print("🎮 A interface já deve estar visível na tela!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✨ Gravação + Auto-Fase + Anti-Lag + Noclip + Auto Click")
print(string.rep("═", 60) .. "\n")
