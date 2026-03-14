extends Control

@onready var btn_reiniciar = $Botoes/Reiniciar
@onready var btn_tela_inicial = $Botoes/TelaInicial
@onready var label_pontos = $Pontos

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	btn_reiniciar.pressed.connect(_on_reiniciar_pressionado)
	btn_tela_inicial.pressed.connect(_on_tela_inicial_pressionada)

func definir_pontos(pontuacao_final):
	label_pontos.text = "Pontos: " + str(pontuacao_final)
	
	# Se a pontuação dessa partida for maior que o recorde salvo, atualiza o global
	if pontuacao_final > GeradorDeEquacoes.recorde_sessao:
		GeradorDeEquacoes.recorde_sessao = pontuacao_final

func _on_reiniciar_pressionado():
	get_tree().paused = false # Tira o jogo do pause antes de recarregar
	get_tree().reload_current_scene() # Recarrega o Level atual

func _on_tela_inicial_pressionada():
	get_tree().paused = false # Tira do pause
	# Substitua pelo caminho exato da sua Tela Inicial
	get_tree().change_scene_to_file("res://scenes/TelaInicial.tscn")
