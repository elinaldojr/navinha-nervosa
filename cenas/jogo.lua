Jogo = Classe:extend()

function Jogo:new()
    nave = Nave()

    tempoInimigo = 0
    listaDeInimigos = {}
    listaDeItens = {}

    fase = {
        --x, velocidade, tempoParaAparecer
        {100, 75, 2},
        {200, 75, 2},
        {300, 75, 2},
        {700, 150, 1},
        {600, 150, 1},
        {500, 150, 1},
        {150, 200, 2},
        {0, 200, 1},
        {650, 200, 1},
        {500, 200, 3},
        {2300, 300, 3},
        {150, 150, 1},
        {300, 150, 1},
        {450, 150, 1},
        {700, 150, 1},
        {600, 150, 1},
        {500, 150, 1},
        {150, 200, 2},
        {10, 200, 1},
        {650, 200, 1},
        {500, 200, 3},
        {2300, 300, 3}
    }
    indiceFase = 1

    self.musicaJogo = love.audio.newSource("recursos/sons/tema_jogo.wav", "stream")
    self.musicaJogo:setLooping(true)

    efeitoItem = love.audio.newSource("recursos/sons/pegar_item.ogg", "static")

    tiroNoInimigo = love.audio.newSource("recursos/sons/tiro_no_inimigo.wav", "static")

    planoDeFundo1 = PlanoDeFundo(0, 0)
    planoDeFundo2 = PlanoDeFundo(0,-altura_tela)
end

function Jogo:update(dt)
    tempoInimigo = tempoInimigo + dt

    if indiceFase <= #fase and tempoInimigo > fase[indiceFase][3] then
        local inimigo = Inimigo(fase[indiceFase][1], -100, fase[indiceFase][2])
        table.insert(listaDeInimigos, inimigo)
        tempoInimigo = 0 
        indiceFase = indiceFase + 1
    end

    nave:update(dt)

    for i, inimigo in pairs(listaDeInimigos) do
        inimigo:update(dt)

        if verificaColisao(inimigo, nave) then
            table.remove(listaDeInimigos, i)
            nave:perderVida()
            nave:velocidadeBase()
            nave:tiroBase()

            local explosao = love.audio.newSource("recursos/sons/explosao.ogg", "static")
            explosao:play()

            if nave.vidas <= 0 then
                cenaAtual = "gameOver"
                self.musicaJogo:stop()
                gameOver.musicaGameOver:play()
            end
        end

        if inimigo:saiuDaTela() then
            table.remove(listaDeInimigos, i)
        end

        for j, tiro in pairs(nave.listaDeTiros) do
            if verificaColisao(inimigo, tiro) then
                tiroNoInimigo:play()

                inimigo.vidas = inimigo.vidas - nave.forcaDoTiro


                if inimigo.vidas <= 0 then
                    local explosao = love.audio.newSource("recursos/sons/explosao.ogg", "static")
                    explosao:play()

                    table.remove(listaDeInimigos, i)

                    local tipo = love.math.random(1, 2)
                    local item = Item(tipo, inimigo.x, inimigo.y)
                    table.insert(listaDeItens, item)
                end
                
                table.remove(nave.listaDeTiros, j)
                
                nave:incrementarPontos(inimigo.pontosInimigo)
            end
        end
    end

    for i, item in pairs(listaDeItens) do
        item:update(dt)

        if item:saiuDaTela() then
            table.remove(listaDeItens, i)
        end

        if verificaColisao(nave, item) then
            efeitoItem:play()

           if item.tipo == 1 then
                nave:incrementarTiros()
           elseif item.tipo == 2 then
                nave:incrementarVelocidade()
           end

           table.remove(listaDeItens, i)
        end
    end

    planoDeFundo1:update(dt)
    planoDeFundo2:update(dt)
end

function Jogo:draw()
    planoDeFundo1:draw()
    planoDeFundo2:draw()
    nave:draw()

    for i, inimigo in pairs(listaDeInimigos) do
        inimigo:draw()
    end

    for i, item in pairs(listaDeItens) do
        item:draw()
    end

    for i=1, nave.vidas do
        love.graphics.draw(nave.imagem, 30*i, 25, 0, 0.3)
    end

    love.graphics.setFont(fonte20)

    love.graphics.print("Pontos: "..nave.pontos, 30, 50, 0, 1.3)
end

function verificaColisao(A, B)
    if A.x < B.x + B.largura and
        A.x + A.largura > B.x and
        A.y < B.y + B.altura and
        A.y + A.largura > B.y then
            return true
        end
end