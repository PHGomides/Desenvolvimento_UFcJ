extends Area2D

@onready var hurtbox_area = self
@onready var player_2: CharacterBody2D = $".."
@onready var anim: AnimatedSprite2D = $"../anim"


func _ready():
	# Conecta o sinal para detectar quando outra área entra na hurtbox
	hurtbox_area.connect("area_entered", Callable(self, "_on_area_entered"))
	hurtbox_area.monitoring = true  # Ativa a detecção de colisões
	print("hurtbox_neemias.gd inicializado e monitoring ativado")

func _on_area_entered(area: Area2D) -> void:
	# Verifica se o nó de área tem o método para obter o tipo de golpe
	if area.has_method("get_hitbox_type"):
		var golpe_tipo = area.get_hitbox_type()
		print("Colisão detectada com:", golpe_tipo)
		
		# Ações baseadas no tipo do golpe
		if golpe_tipo == "punch1":
			print("Player 1 acertou o Player 2 com um soco!")
			
		elif golpe_tipo == "punch3":
			print("Player 1 acertou o Player 2 com um soco de cima pra baixo!")
			
