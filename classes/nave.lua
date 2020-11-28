Nave = Classe:extend()

function Nave:new()
    self.imagem = love.graphics.newImage("recursos/imagens/navinha.png")
    self.x, self.y = 400, 300
    self.largura = self.imagem:getWidth()
    self.altura = self.imagem:getHeight()
    self.velocidade = 400

    self.listaDeTiros = {}

    self.pontos = 0
    self.vidas = 3

    self.forcaDoTiro = 1
    self.tempoDeTiro = 0

    self.somTiro = love.audio.newSource("recursos/sons/tiro.wav", "static")
end

function Nave:update(dt)
    self:mover(dt)
    self:manterNaTela()

    --tiro:update(dt)
    for i, tiro in pairs(self.listaDeTiros) do
        tiro:update(dt)

        if tiro:saiuDaTela() then
            table.remove(self.listaDeTiros, i)
        end
    end

    self.tempoDeTiro = self.tempoDeTiro + dt

    if love.keyboard.isDown("space") and self.tempoDeTiro > 0.2 then
        self.tempoDeTiro = 0
        self:atirar(dt)
    end
end

function Nave:draw()
    for i, tiro in pairs(self.listaDeTiros) do
        tiro:draw()
    end

    love.graphics.draw(self.imagem, self.x, self.y)
end

--Faz a nave se mover de acordo com as teclas pressionadas
function Nave:mover(dt)
    if love.keyboard.isDown("up") then
        self.y = self.y - self.velocidade*dt
    elseif love.keyboard.isDown("down") then
        self.y = self.y + self.velocidade*dt
    end

    if love.keyboard.isDown("left") then
        self.x = self.x - self.velocidade*dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.velocidade*dt
    end
end

function Nave:manterNaTela()
    if self.x < 0 then
        self.x = 0
    elseif self.x + self.largura > largura_tela then
        self.x = love.graphics.getWidth() - self.largura
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.altura > altura_tela then
        self.y = love.graphics.getHeight() - self.altura
    end
end

function Nave:atirar(dt)
    --print("atirou")
    self.somTiro:play()

    local tiro = Tiro(self.x + self.largura/2, self.y)

    table.insert(self.listaDeTiros, tiro)
end

function Nave:incrementarPontos(pontosInimigo)
    self.pontos = self.pontos + pontosInimigo
end

function Nave:ganharVida()
    self.vidas = self.vidas + 1
end

function Nave:perderVida()
    self.vidas = self.vidas - 1
end

function Nave:incrementarTiros()
    self.forcaDoTiro = self.forcaDoTiro + 0.1
end

function Nave:incrementarVelocidade()
    self.velocidade = self.velocidade + 10
end

function Nave:velocidadeBase()
    self.velocidade = 400
end

function Nave:tiroBase()
    self.forcaDoTiro = 1
end