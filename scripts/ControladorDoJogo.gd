extends Node2D

var pontos: int = 0
@onready var hud_label_pontos = $HUD/LabelPontos # Caminho hipotético para o texto no seu HUD
@onready var jogador = $Player # Caminho para o nó do Player na cena principal

func _ready():
	atualizar_hud()

# Função que o botão da resposta certa vai chamar
func resposta_certa():
	pontos += 10 # Dá 10 pontos por acerto
	atualizar_hud()
	jogador.acertou_conta() # Avisa o Player para pular e avançar
	
	# Aqui depois entrará a função de gerar a próxima conta matemática

func resposta_errada():
	pontos -= 5 # Opcional: penalidade por errar
	if pontos < 0:
		pontos = 0
	atualizar_hud()
	# Opcional: fazer o perigo se aproximar mais rápido aqui

func atualizar_hud():
	if hud_label_pontos:
		hud_label_pontos.text = "Pontos: " + str(pontos)
