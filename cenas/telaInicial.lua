TelaInicial = Classe:extend()

function TelaInicial:new()
    self.imagem = love.graphics.newImage("recursos/imagens/tela_inicial.png")
    self.opcoes = {"Jogar", "Sair"}

    self.iconeSelecao = {}
    self.iconeSelecao.imagem = love.graphics.newImage("recursos/imagens/navinha.png")
    self.iconeSelecao.x = largura_tela/2- 70
    self.iconeSelecao.y = altura_tela/2 + 50

    self.escolha = 1 -- 1:Jogar e 2:Sair

    self.tempoMudarOpcao = 0

    self.musicaMenu = love.audio.newSource("recursos/sons/menu.ogg", "stream")

    self.mudaOpcaoMenu = love.audio.newSource("recursos/sons/mudar_opcao_menu.ogg", "static")
    self.selecionaOpcaoMenu = love.audio.newSource("recursos/sons/selecionar_opcao_menu.ogg", "static")
end

function TelaInicial:update(dt)
    self.tempoMudarOpcao = self.tempoMudarOpcao + dt

    if love.keyboard.isDown("up", "down") and self.tempoMudarOpcao > 0.5 then
        self.tempoMudarOpcao = 0
        self.mudaOpcaoMenu:play()

        if self.iconeSelecao.y == altura_tela/2 + 50 then
            self.iconeSelecao.y = altura_tela/2 + 100
            self.escolha = 2 -- Sair
        elseif self.iconeSelecao.y == altura_tela/2 + 100 then
            self.iconeSelecao.y = altura_tela/2 + 50
            self.escolha = 1 -- Jogar
        end
    end

    if love.keyboard.isDown("space") and self.tempoMudarOpcao > 0.5 then
        self.tempoMudarOpcao = 0
        if self.escolha == 1 then
            cenaAtual = "jogo"
            jogo:new()
            self.musicaMenu:stop()
            self.selecionaOpcaoMenu:play()
            jogo.musicaJogo:play()
        elseif self.escolha == 2 then
            love.event.quit()
        end
    end

end

function TelaInicial:draw()
    love.graphics.draw(self.imagem)

    love.graphics.setFont(fonte30)

    for i=1, #self.opcoes do 
        love.graphics.print(self.opcoes[i], largura_tela/2- 50, altura_tela/2 + 50*i)
    end

    love.graphics.draw(self.iconeSelecao.imagem, self.iconeSelecao.x, self.iconeSelecao.y, 1.5, 0.3)
end