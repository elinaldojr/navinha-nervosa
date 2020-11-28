Inimigo = Classe:extend()

function Inimigo:new(x, y, velocidade)
    self.x, self.y = x, y
    self.imagem = love.graphics.newImage("recursos/imagens/inimigo.png")
    self.largura = self.imagem:getWidth()
    self.altura = self.imagem:getHeight()
    self.velocidade = velocidade

    self.pontosInimigo = 1

    self.vidas = 3
end

function Inimigo:update(dt)
    self.y = self.y + self.velocidade*dt
end

function Inimigo:draw()
    love.graphics.draw(self.imagem, self.x, self.y)

    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", self.x, self.y-5, self.largura*self.vidas/3, 3)
    love.graphics.setColor(1, 1, 1)
end

function Inimigo:saiuDaTela()
    if self.y > altura_tela then
        return true
    end
    return false
end