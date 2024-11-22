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
	
	#verificaçao que altera a direçao do personagem quando ele apanha de costas
	if(area.global_position.x-global_position.x)>0:
		if(get_parent().current_direction == -1):
			get_parent().VirarDeLado()
		print("direita")
	else:
		
		if(get_parent().current_direction == 1):
			get_parent().VirarDeLado()
		print("esquerda")
		
	if(get_parent().can_take_damege == false):#verifica se o personagem pode levar dano
		return
	# Verifica se o nó de área tem o método para obter o tipo de golpe
	if area.has_method("poderNome"):#ADICIONANDO HURTBOX DO PODER OPICIONAL

		get_parent()._damage(7,"poderOpicional")
		$"../Dano2sfx".play()
		get_parent().KnockBack(2000)
	if area.has_method("get_hitbox_type"):
		var golpe_tipo = area.get_hitbox_type()
		print("Colisão detectada com:", golpe_tipo)
		
		# Ações baseadas no tipo do golpe
		if golpe_tipo == "punch1":
			print("Player 2 acertou o Player 1 com um soco!")

			$"../Dano1sfx".play()
			
			get_parent()._damage(5,golpe_tipo)
			
		elif golpe_tipo == "punch2":

			$"../Dano1sfx".play()
			print("Player 2 acertou o Player 1 com um soco girando!")
			get_parent()._damage(5,golpe_tipo)
			#
		elif golpe_tipo == "punch3":
			print("Player 2 acertou o Player 1 com um gancho!")

			$"../Dano2sfx".play()
			get_parent()._damage(7,golpe_tipo)
			get_parent().KnockBack(1700)

		elif golpe_tipo == "especialShape":
			print("Player 2 acertou o Player 1 com o especial!")

			get_parent()._damage(30,golpe_tipo)
			$"../Dano2sfx".play()
			get_parent().KnockBack(2500)

			
