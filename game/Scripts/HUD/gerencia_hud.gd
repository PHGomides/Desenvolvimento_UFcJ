extends Control

@onready var tempo_label = $MarginContainer/Tempo_container/Tempo_label as Label
@onready var clocktimer = $clocktimer as Timer

var seconds = 0

@export_range(0,90) var default_seconds := 90

@onready var ef_bv_player_1: TextureProgressBar = $EF_BarraVidaPlayer1
@onready var bv_player_1: TextureProgressBar = $BarraVidaPlayer1

@onready var ef_bv_player_2: TextureProgressBar = $EF_BarraVidaPlayer2
@onready var bv_player_2: TextureProgressBar = $BarraVidaPlayer2

var barras = []
@export var vidaMAX: int = 100
@export var vida_player1 = 0 : set = _set_vida_player1
@export var vida_player2 = 0 : set = _set_vida_player2

signal time_is_up()

func _set_vida_player1(nova_vida):
	if nova_vida <= 0:
		vida_player1 = 0
		ef_bv_player_1.value = vida_player1
		bv_player_1.value = vida_player1
		return	
	
	if nova_vida >= vidaMAX:
		nova_vida = vidaMAX
		
	
	else:
		vida_player1 = nova_vida
		move_tween(ef_bv_player_1, vida_player1,0.1)
		move_tween(bv_player_1, vida_player1,0.2)
		
	
func _set_vida_player2(nova_vida):
	if nova_vida <= 0:
		vida_player2 = 0
		ef_bv_player_2.value = vida_player2
		bv_player_2.value = vida_player2
		return	
	
	if nova_vida >= vidaMAX:
		nova_vida = vidaMAX
		
	
	else:
		vida_player2 = nova_vida
		move_tween(ef_bv_player_2, vida_player2,0.1)
		move_tween(bv_player_2, vida_player2,0.2)
		
		
		

func _ready() -> void:
	barras = [ef_bv_player_1, ef_bv_player_2, bv_player_1, bv_player_2]
	_init_vida()
	tempo_label.text = str("%02d" % default_seconds)
	reset_clock_timer()

func _process(delta: float) -> void:
	pass
  
func _init_vida():
	vida_player1 = vidaMAX
	vida_player2 = vidaMAX
	for bar in barras:
		bar.max_value = vidaMAX
		bar.value = vidaMAX

func _on_clocktimer_timeout() -> void:
	seconds -= 1
	tempo_label.text = str("%02d" % seconds)
	
func reset_clock_timer():
	seconds = default_seconds
	
func move_tween(node, nova_vida, speed):
	var tween = node.create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(node, "value", nova_vida, speed)
