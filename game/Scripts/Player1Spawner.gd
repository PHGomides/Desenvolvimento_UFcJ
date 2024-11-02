extends Node2D

@onready var Player1Position = $MarkPlayer1
@onready var Player2Position = $MarkPlayer2
var Player1: CharacterBody2D = null
var Player2: CharacterBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player1 = load(Global.player1Diretorio).instantiate()
	Player1.type_player = 2
	Player1.global_position = Player1Position.global_position
	Player1.add_to_group("players") #serve pra fazer a camera focar nele
	Global.player1 = Player1  # Armazena a referência no script global
	add_child(Player1)
	
	Player2 = load(Global.player2Diretorio).instantiate()
	Player2.type_player = 1
	Player2.global_position = Player2Position.global_position
	Player2.add_to_group("players")
	Global.player2 = Player2  # Armazena a referência no script global
	add_child(Player2)
