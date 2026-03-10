extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS # Garante que os botões leiam os cliques mesmo no get_tree().paused!
	# Conecta os botões
	$Botoes/Reiniciar.pressed.connect(_on_reiniciar_pressionado)
	$Botoes/TelaInicial.pressed.connect(_on_tela_inicial_pressionada)

# Função que o Level vai chamar para entregar os pontos finais
func definir_pontos(pontuacao_final):
	$Pontos.text = "Pontos: " + str(pontuacao_final)

func _on_reiniciar_pressionado():
	get_tree().paused = false # Tira o jogo do pause antes de recarregar
	get_tree().reload_current_scene() # Recarrega o Level atual

func _on_tela_inicial_pressionada():
	get_tree().paused = false # Tira do pause
	# Substitua pelo caminho exato da sua Tela Inicial
	get_tree().change_scene_to_file("res://scenes/TelaInicial.tscn")
