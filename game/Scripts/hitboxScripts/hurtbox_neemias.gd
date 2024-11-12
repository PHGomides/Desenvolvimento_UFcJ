extends Area2D

@onready var hurtbox_area = self
@onready var anim: AnimatedSprite2D = $"../anim"


func _ready():
	# Conecta o sinal para detectar quando outra área entra na hurtbox
	hurtbox_area.connect("area_entered", Callable(self, "_on_area_entered"))
	hurtbox_area.monitoring = true  # Ativa a detecção de colisões
	print("hurtbox_neemias.gd inicializado e monitoring ativado")

func _on_area_entered(area: Area2D) -> void:
	#verificaçao que altera a direçao do personagem quando ele apanha de costas
	if(area.global_position.x-global_position.x)>0:
		if(get_parent().current_direction == -1):
			get_parent().VirarDeLado()
		print("direita")
	else:
		
		if(get_parent().current_direction == 1):
			get_parent().VirarDeLado()
		print("esquerda")
	# Verifica se o nó de área tem o método para obter o tipo de golpe
	
	if area.has_method("get_hitbox_type"):
		var golpe_tipo = area.get_hitbox_type()
		print("Colisão detectada com:", golpe_tipo)
		
		# Ações baseadas no tipo do golpe
		if golpe_tipo == "punch1" || golpe_tipo == "punch2" :
			print("Player 1 acertou o Player 2 com um soco!")
			get_parent()._damage(10)
			
		elif golpe_tipo == "punch3":
			print("Player 1 acertou o Player 2 com um soco de cima pra baixo!")
			get_parent()._damage(10)
			
