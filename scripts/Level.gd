extends Node2D

var pontos = 0
var distancia_pulo = 250 
var altura_proxima_plataforma = 0 
var posicao_x_plataformas = 0 # Guarda o eixo X para não nascer torto 

@export var velocidade_perigo = 50 # valor da barra que sobe atrás do player
var jogo_iniciado = false

var cena_game_over = preload("res://scenes/GameOver.tscn")
var cena_plataforma = preload("res://scenes/Plataforma.tscn")

@onready var label_equacao = $Hud/Equacoes
@onready var label_pontos = $Hud/Pontos
@onready var btn1 = $Hud/Opcoes/Opcao1
@onready var btn2 = $Hud/Opcoes/Opcao2
@onready var btn3 = $Hud/Opcoes/Opcao3
@onready var player = $Player
@onready var area_dano = $AreaDeDano
@onready var camera = $Camera2D
@onready var background = $Fundo

func _ready():
	velocidade_perigo = GeradorDeEquacoes.velocidade_jogo # Usa a variavel que persiste
	print("[Level] velocidade_perigo é", velocidade_perigo)

	atualizar_conta()
	atualizar_pontos()
	
	# Salva a posição horizontal exata do jogador logo que o jogo começa
	posicao_x_plataformas = player.position.x - 150
	
	altura_proxima_plataforma = player.position.y - distancia_pulo
	criar_plataforma()
	
	btn1.pressed.connect(_on_opcao_pressionada.bind(btn1))
	btn2.pressed.connect(_on_opcao_pressionada.bind(btn2))
	btn3.pressed.connect(_on_opcao_pressionada.bind(btn3))
	
	area_dano.body_entered.connect(_on_perigo_encostou)
	
	area_dano.position.y = player.position.y + 100 - 495

func atualizar_conta():
	label_equacao.text = GeradorDeEquacoes.gerar_nova_conta()
	var botoes = [btn1, btn2, btn3]
	botoes.shuffle() 
	
	var certa = GeradorDeEquacoes.resposta_correta
	
	# Cria uma lista que já começa com a resposta certa guardada
	var respostas_para_botoes = [certa]
	
	# Fica sorteando números até termos 3 opções únicas
	while respostas_para_botoes.size() < 3:
		# Sorteia uma variação de -5 a +5
		var variacao = randi_range(-5, 5)
		
		# Não queremos somar zero, senão teremos a resposta certa duplicada
		if variacao == 0:
			continue
			
		var nova_errada = certa + variacao
		
		# Impede de gerar números negativos nas alternativas
		if nova_errada < 0:
			continue
			
		# Se esse número ainda não está na nossa lista, nós o adicionamos
		if not respostas_para_botoes.has(nova_errada):
			respostas_para_botoes.append(nova_errada)
			
	# Distribui as 3 respostas para os botões que já foram embaralhados
	botoes[0].text = str(respostas_para_botoes[0]) # Esta é a certa
	botoes[1].text = str(respostas_para_botoes[1]) # Errada aleatória 1
	botoes[2].text = str(respostas_para_botoes[2]) # Errada aleatória 2

func _on_opcao_pressionada(botao_clicado):
	if botao_clicado.text == str(GeradorDeEquacoes.resposta_correta):
		jogo_iniciado = true
		
		# Usa os pontos dinâmicos baseados na operação em vez de um número fixo!
		pontos += GeradorDeEquacoes.pontos_da_rodada 
		
		player.acertou_conta() 
		criar_plataforma() 
		resetar_perigo()   
		atualizar_conta()  
	else:
		pontos -= 5
		if pontos < 0:
			pontos = 0
		area_dano.position.y -= 100 
		
	atualizar_pontos()

func atualizar_pontos():
	label_pontos.text = "Pontos: " + str(pontos)

func resetar_perigo():
	# Retorna a lava para ali embaixo visivel (+100 de Y)
	# O nó AreaDeDano tem um offset visual de ~495 pixels.
	# Para a lava ficar visível a 100 pixels sob o jogador, descontamos esse offset.
	area_dano.position.y = player.position.y + 100 - 495

func criar_plataforma():
	var nova_plataforma = cena_plataforma.instantiate()
	# Usa o X fixo salvo lá no _ready! Acabaram as plataformas tortas.
	nova_plataforma.position = Vector2(posicao_x_plataformas, altura_proxima_plataforma)
	add_child(nova_plataforma)
	
	altura_proxima_plataforma -= distancia_pulo

func _on_perigo_encostou(body):
	if body == player:
		# Cria a tela de Game Over
		var tela_fim = cena_game_over.instantiate()
		
		# Adiciona a tela dentro do Hud (assim ela fica fixa na frente da câmera)
		$Hud.add_child(tela_fim)
		
		# Manda a pontuação para a tela exibir
		tela_fim.definir_pontos(pontos)
		
		# Pausa o jogo inteiro (congela o perigo, física e contas)
		get_tree().paused = true 

func _process(delta):
	# substitui o número padrão por uma variavel, facilita a manipulação
	if jogo_iniciado:
		area_dano.position.y -= velocidade_perigo * delta 
	
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
	
	# Faz o fundo acompanhar a câmera
	background.position.y = camera.position.y - 360
