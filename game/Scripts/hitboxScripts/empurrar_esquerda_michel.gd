extends Area2D

var player2Diretorio = "res://Cenas/neemias.tscn"
@onready var player: CharacterBody2D = $".."

var is_colliding: bool = false  # Variável de controle para indicar colisão

@onready var empurrar_direita: Area2D = $"../empurrarDireita"

func _on_body_entered(body: Node) -> void:
	if body.name == "player2":
		print("Colisão com empurrarEsquerda")
		is_colliding = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player2":
		print("Parou a colisão com empurrarEsquerda")
		is_colliding = false


func _process(delta: float) -> void:
	# Incrementa enquanto estiver colidindo
	if is_colliding:
		if empurrar_direita.is_colliding:
			# Resolve conflito se ambas as áreas estão ativas
			if randi() % 2 == 1:  # Escolha aleatória (50% de chance)
				player.position.x -= 1 * delta * 1000
			print("colidiu com esquerda e direita e foi para um lado aleatório")
		else:
			# Se apenas empurrarDireita está ativa
			player.position.x -= 1 * delta * 1000
