extends Node2D

@onready var Player2Position = $MarkPlayer2
var Player2: CharacterBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player2 = load(Global.player2Diretorio).instantiate()
	Player2.global_position = Player2Position.global_position
	add_child(Player2)
