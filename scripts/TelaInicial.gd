extends Control 

# Use @onready para pegar a referência das caixinhas na sua cena
@onready var check_subtracao = $Fundo/CheckSubtracao
@onready var check_multiplicacao = $Fundo/CheckMultiplicacao
@onready var check_divisao = $Fundo/CheckDivisao

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

# --- FUNÇÕES DAS CAIXINHAS ---
# O Godot automaticamente passa a variável 'ligado' (true/false) quando a caixa é clicada
func _on_subtracao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_subtracao = ligado

func _on_multiplicacao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_multiplicacao = ligado

func _on_divisao_alterada(ligado: bool):
	GeradorDeEquacoes.usar_divisao = ligado

# --- BOTÃO INICIAR ---
func _on_iniciar_pressionado():
	# Substitua pelo caminho exato da sua cena principal
	get_tree().change_scene_to_file("res://scenes//Level.tscn")
