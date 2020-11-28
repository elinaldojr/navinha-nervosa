GameOver = Classe:extend()

function GameOver:new()
    self.imagem = love.graphics.newImage("recursos/imagens/game_over.png")

    self.musicaGameOver = love.audio.newSource("recursos/sons/game_over.ogg", "stream")
end

function GameOver:update(dt)
    if love.keyboard.isDown("space") then
        cenaAtual = "telaInicial"
        self.musicaGameOver:stop()
        telaInicial.musicaMenu:play()
    end
end

function GameOver:draw()
    love.graphics.draw(self.imagem)

    love.graphics.setFont(fonte30)
    love.graphics.print("Aperte espaço para voltar ao menu.", 120, altura_tela/2 + 50)
end