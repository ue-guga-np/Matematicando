extends CharacterBody2D

var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var forca_do_pulo = -800.0 # No Godot, valor negativo faz subir (ir para o topo da tela)

@onready var sprite_parado = $SpriteParado
@onready var sprite_pulo = $SpritePulo

func _physics_process(delta):
	# A gravidade puxa ele para baixo constantemente
	velocity.y += gravidade * delta
	
	# Se estiver subindo mostra o sprite de pulo
	if velocity.y < 0:
		sprite_parado.visible = false
		sprite_pulo.visible = true
	
	# Se estiver caindo ou parado volta para o sprite parado
	if velocity.y >= 0:
		sprite_parado.visible = true
		sprite_pulo.visible = false
	
	move_and_slide()

# Essa função será chamada pelo controlador do jogo quando a criança acertar
func acertou_conta():
	# Joga o personagem para cima (não usamos is_on_floor() porque ele vai pular no "ar" infinito)
	velocity.y = forca_do_pulo
	velocity.x = 0 # Garante que ele não vai para os lados
