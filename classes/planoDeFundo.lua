PlanoDeFundo = Classe:extend()


function PlanoDeFundo:new(x, y)
    self.imagem = love.graphics.newImage("recursos/imagens/plano_de_fundo.png")
    self.x = x
    self.y = y
    self.largura = self.imagem:getWidth()
    self.altura = self.imagem:getHeight()
end

function PlanoDeFundo:update(dt)
    self.y = self.y + 50*dt

    if self.y >= altura_tela then
        self.y = -self.altura
    end
end

function PlanoDeFundo:draw()
    love.graphics.draw(self.imagem, self.x, self.y)
end