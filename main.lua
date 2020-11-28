largura_tela = love.graphics.getWidth()
altura_tela = love.graphics.getHeight()

function love.load()
    Classe = require "classic"
    require "cenas/jogo"
    require "cenas/telaInicial"
    require "cenas/gameOver"
    require "classes/nave"
    require "classes/tiro"
    require "classes/inimigo"
    require "classes/item"
    require "classes/planoDeFundo"

    jogo = Jogo()
    telaInicial = TelaInicial()
    gameOver = GameOver()

    cenas = {
        jogo = jogo,
        telaInicial = telaInicial,
        gameOver = gameOver
    }
    cenaAtual = "telaInicial"
    telaInicial.musicaMenu:play()

    fonte20 = love.graphics.newFont("recursos/fontes/visitor1.ttf", 20)
    fonte30 = love.graphics.newFont("recursos/fontes/visitor1.ttf", 30)
end

function love.update(dt)
    --jogo:update(dt)
    cenas[cenaAtual]:update(dt)
end

function love.draw()
    --jogo:draw()
    cenas[cenaAtual]:draw()
end