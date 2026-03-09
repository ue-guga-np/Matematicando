extends Node2D

var pontos = 0
var distancia_pulo = 250 
var altura_proxima_plataforma = 0 
var posicao_x_plataformas = 0 # Guarda o eixo X para não nascer torto

var cena_game_over = preload("res://scenes/GameOver.tscn")
var cena_plataforma = preload("res://scenes//plataforma.tscn")

@onready var label_equacao = $Hud/Equacoes
@onready var label_pontos = $Hud/Pontos
@onready var btn1 = $Hud/Opcoes/Opcao1
@onready var btn2 = $Hud/Opcoes/Opcao2
@onready var btn3 = $Hud/Opcoes/Opcao3
@onready var player = $Player
@onready var area_dano = $AreaDeDano
@onready var camera = $Camera2D

func _ready():
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
	
	area_dano.position.y = player.position.y - 150

func atualizar_conta():
	label_equacao.text = GeradorDeEquacoes.gerar_nova_conta()
	var botoes = [btn1, btn2, btn3]
	botoes.shuffle() 
	
	botoes[0].text = str(GeradorDeEquacoes.resposta_correta)
	botoes[1].text = str(GeradorDeEquacoes.resposta_correta + randi_range(1, 4))
	botoes[2].text = str(GeradorDeEquacoes.resposta_correta - randi_range(1, 4))
	
	if botoes[1].text == botoes[2].text:
		botoes[2].text = str(GeradorDeEquacoes.resposta_correta + 5)

func _on_opcao_pressionada(botao_clicado):
	if botao_clicado.text == str(GeradorDeEquacoes.resposta_correta):
		pontos += 10
		player.acertou_conta() 
		criar_plataforma() 
		resetar_perigo()   
		atualizar_conta()  
	else:
		pontos -= 5
		if pontos < 0:
			pontos = 0
		# Punição: o perigo dá um salto maior pra cima
		area_dano.position.y -= 100 
		
	atualizar_pontos()

func atualizar_pontos():
	label_pontos.text = "Pontos: " + str(pontos)

func resetar_perigo():
	# Diminuí de +600 para +400 para ficar logo ali embaixo da tela
	area_dano.position.y = player.position.y - 200

func criar_plataforma():
	var nova_plataforma = cena_plataforma.instantiate()
	# Usa o X fixo salvo lá no _ready! Acabaram as plataformas tortas.
	nova_plataforma.position = Vector2(posicao_x_plataformas, altura_proxima_plataforma)
	add_child(nova_plataforma)
	
	altura_proxima_plataforma -= distancia_pulo

func _on_perigo_encostou(body):
	if body.name == "Player":
		# Cria a tela de Game Over
		var tela_fim = cena_game_over.instantiate()
		
		# Adiciona a tela dentro do Hud (assim ela fica fixa na frente da câmera)
		$Hud.add_child(tela_fim)
		
		# Manda a pontuação para a tela exibir
		tela_fim.definir_pontos(pontos)
		
		# Pausa o jogo inteiro (congela o perigo, física e contas)
		get_tree().paused = true 

func _process(delta):
	# Aumentei a velocidade de subida de 30 para 100
	area_dano.position.y -= 50 * delta
	
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
