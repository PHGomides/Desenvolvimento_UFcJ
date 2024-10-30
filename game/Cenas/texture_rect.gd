extends TextureRect

# Variáveis exportadas para armazenar as texturas (imagens)
@export var imagem1: Texture
@export var imagem2: Texture
@export var imagem3: Texture
@export var imagem4: Texture
@export var imagem5: Texture

# Chamado a cada frame. 'delta' é o tempo decorrido desde o frame anterior.
func _process(delta: float) -> void:
	mapa_atual()

func mapa_atual() -> void:
	var parent = get_parent()
	match parent.mapa_atual:
		1:
			texture = imagem1
		2:
			texture = imagem2
		3:
			texture = imagem3
		4:
			texture = imagem4
		5:
			texture = imagem5
