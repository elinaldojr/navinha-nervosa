Tiro = Classe:extend()

function Tiro:new(x, y)
    self.x, self.y = x, y
    self.velocidade = 1000
    self.imagem = love.graphics.newImage("recursos/imagens/tiro.png")
    self.largura = self.imagem:getWidth()
    self.altura = self.imagem:getHeight()
end

function Tiro:update(dt)
    self.y = self.y - self.velocidade*dt
end

function Tiro:draw()
    love.graphics.draw(self.imagem, self.x, self.y)
end

function Tiro:saiuDaTela()
    if self.y < -self.altura then
        return true
    end
    return false
end