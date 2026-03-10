extends Control 

# Use @onready para pegar a referência das caixinhas na sua cena
@onready var check_subtracao = $Fundo/CheckSubtracao
@onready var check_multiplicacao = $Fundo/CheckMultiplicacao
@onready var check_divisao = $Fundo/CheckDivisao

@onready var btn_veloc35 = $Fundo/Velocidades/BtnVeloc35
@onready var btn_veloc50 = $Fundo/Velocidades/BtnVeloc50
@onready var btn_veloc65 = $Fundo/Velocidades/BtnVeloc65

# valor selecionado pelo jogador (usado ao iniciar o Level)
var escolha_velocidade := 50

func _ready():
	# Conecta o botão de Play
	$Iniciar.pressed.connect(_on_iniciar_pressionado)
	
	# Conecta o sinal 'toggled' de cada caixinha para as funções abaixo
	check_subtracao.toggled.connect(_on_subtracao_alterada)
	check_multiplicacao.toggled.connect(_on_multiplicacao_alterada)
	check_divisao.toggled.connect(_on_divisao_alterada)
	
	# Garante que as caixinhas comecem com o visual correto de acordo com o Global
	check_subtracao.button_pressed = GeradorDeEquacoes.usar_subtracao
	check_multiplicacao.button_pressed = GeradorDeEquacoes.usar_multiplicacao
	check_divisao.button_pressed = GeradorDeEquacoes.usar_divisao

	# ButtonGroup para selecionar dificuldade
	var grupo = ButtonGroup.new()
	btn_veloc35.button_group = grupo
	btn_veloc50.button_group = grupo
	btn_veloc65.button_group = grupo

	btn_veloc35.toggle_mode = true
	btn_veloc50.toggle_mode = true
	btn_veloc65.toggle_mode = true

	# conecta sinais para atualizar escolha de velocidade
	btn_veloc35.pressed.connect(func(): _on_velocidade_escolhida(25))
	btn_veloc50.pressed.connect(func(): _on_velocidade_escolhida(50))
	btn_veloc65.pressed.connect(func(): _on_velocidade_escolhida(75))

	# Recupera a dificuldade global salva na memória
	escolha_velocidade = GeradorDeEquacoes.velocidade_jogo
	
	if escolha_velocidade == 25:
		btn_veloc35.button_pressed = true
	elif escolha_velocidade == 50:
		btn_veloc50.button_pressed = true
	elif escolha_velocidade == 75:
		btn_veloc65.button_pressed = true

# --- FUNÇÕES DAS CAIXINHAS ---
# O Godot automaticamente passa a variável 'ligado' (true/false) quando a caixa é clicada
func _on_subtracao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_subtracao = ligado

func _on_multiplicacao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_multiplicacao = ligado

func _on_divisao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_divisao = ligado

# --- FUNÇÕES DE VELOCIDADE ---
func _on_velocidade_escolhida(v):
	escolha_velocidade = v
	print("[TelaInicial] velocidade escolhida =", escolha_velocidade)

# --- BOTÃO INICIAR ---
func _on_iniciar_pressionado():
	GeradorDeEquacoes.velocidade_jogo = escolha_velocidade
	get_tree().change_scene_to_file("res://scenes/Level.tscn")
