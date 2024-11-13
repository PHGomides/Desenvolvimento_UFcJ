extends Area2D

@onready var hurtbox_area = self
@onready var player: CharacterBody2D = $".."
@onready var anim: AnimatedSprite2D = $"../anim"


func _ready():
	# Conecta o sinal para detectar quando outra área entra na hurtbox
	hurtbox_area.connect("area_entered", Callable(self, "_on_area_entered"))
	hurtbox_area.monitoring = true  # Ativa a detecção de colisões
	print("hurtbox_michel.gd inicializado e monitoring ativado")
	

	
func _on_area_entered(area: Area2D) -> void:
	print(area)
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
		if golpe_tipo == "punch1":
			print("Player 2 acertou o Player 1 com um soco!")
			
			get_parent()._damage(10)
			
		elif golpe_tipo == "punch2":
			print("Player 2 acertou o Player 1 com um soco girando!")
			get_parent()._damage(10)
			#
		elif golpe_tipo == "punch3":
			print("Player 2 acertou o Player 1 com um gancho!")
			get_parent()._damage(10)
			get_parent().KnockBack(800)

		elif golpe_tipo == "especialShape":
			print("Player 2 acertou o Player 1 com o especial!")
			get_parent()._damage(50)
			get_parent().KnockBack(1200)

			
