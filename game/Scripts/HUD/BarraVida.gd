extends Control


@onready var barra_player1: TextureProgressBar = $TextureProgressBar_play1
@onready var barra_player2: TextureProgressBar = $TextureProgressBar_play2
@onready var timer: Timer = $clocktimer

@export var vida_maxima : int
@export var vida = 0 : set = _set_vida


func _set_vida(nova_vida,tipo_player):
	if nova_vida <=0:
		queue_free()
		return
	if  nova_vida >= vida_maxima:
		nova_vida = vida_maxima
	if  nova_vida >= barra_player1
	
	
	
func _ready() -> void:
	pass # Replace with function body.


 
func _process(delta: float) -> void:
	pass
