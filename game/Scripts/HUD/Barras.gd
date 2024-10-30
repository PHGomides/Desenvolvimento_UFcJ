extends Control

@onready var timer_barra: Timer = $timerbarra

var seconds = 0

@export_range(0,90) var default_seconds := 90

@onready var ef_bv_player_1: TextureProgressBar = $EF_BarraVidaPlayer1
@onready var bv_player_1: TextureProgressBar = $BarraVidaPlayer1

@onready var ef_bv_player_2: TextureProgressBar = $EF_BarraVidaPlayer2
@onready var bv_player_2: TextureProgressBar = $BarraVidaPlayer2

@onready var bp_power_player_1: TextureProgressBar = $Power_Player1
@onready var bp_power_player_2: TextureProgressBar = $Power_Player2


var barrasvida = []
@export var vidaMAX: int = 100
@export var vida_player1 = 0 : set = _set_vida_player1
@export var vida_player2 = 0 : set = _set_vida_player2

@export var powerMAX: int = 60
@export var power_player1 = 0 : set = _set_power_player1
@export var power_player2 = 0 : set = _set_power_player2



signal time_is_up()

func _set_vida_player1(nova_vida):
	nova_vida = clamp(nova_vida, 0, vidaMAX)  # Restringe o valor entre 0 e vidaMAX
	vida_player1 = nova_vida
	move_tween(bv_player_1, vida_player1, 0.1)
	timer_barra.start(1.0)
	await timer_barra.timeout
	move_tween(ef_bv_player_1, vida_player1, 0.2)
	

	
func _set_vida_player2(nova_vida):
	
	nova_vida = clamp(nova_vida, 0, vidaMAX)  # Restringe o valor entre 0 e vidaMAX
	vida_player2 = nova_vida
	move_tween(bv_player_2, vida_player2, 0.1)
	timer_barra.start(1.0)
	await timer_barra.timeout
	move_tween(ef_bv_player_2, vida_player2, 0.2)
	

func _set_power_player1(novo_power):
	novo_power = clamp(novo_power , 0, powerMAX)  # Restringe o valor entre 0 e powerMAX
	power_player1 = novo_power 
	move_tween(bp_power_player_1, power_player1, 0.5)
	
func _set_power_player2(novo_power):
	novo_power = clamp(novo_power , 0, powerMAX)  # Restringe o valor entre 0 e powerMAX
	power_player2 = novo_power 
	move_tween(bp_power_player_2, power_player2, 0.5)

func _ready() -> void:
	barrasvida = [ef_bv_player_1, ef_bv_player_2, bv_player_1, bv_player_2]
	_init_vida()

func _process(delta: float) -> void:
	pass
  
func _init_vida():
	vida_player1 = vidaMAX
	vida_player2 = vidaMAX
	for bar in barrasvida:
		bar.max_value = vidaMAX
		bar.value = vidaMAX

func move_tween(node, nova_vida, speed):
	var tween = node.create_tween()
	tween.set_parallel(true)
	tween.tween_property(node, "value", nova_vida, speed)
