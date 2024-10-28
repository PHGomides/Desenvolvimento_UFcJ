extends Control

@onready var clocktimer: Timer = $clocktimer

@onready var ef_bv_player_1: TextureProgressBar = $EF_BarraVidaPlayer1
@onready var bv_player_1: TextureProgressBar = $BarraVidaPlayer1

@onready var ef_bv_player_2: TextureProgressBar = $EF_BarraVidaPlayer2
@onready var bv_player_2: TextureProgressBar = $BarraVidaPlayer2

@export var vidaMAX: int
@export var vida_player1 = 0 : set = _set_vida
@export var vida_player2 = 0 : set = _set_vida

func _set_vida(nova_vida):
	return	





func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
