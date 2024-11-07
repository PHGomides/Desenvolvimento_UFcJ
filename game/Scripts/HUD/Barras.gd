extends Control

@onready var timer_barra: Timer = $timerbarra

@export_range(0, 90) var default_seconds := 90

@onready var ef_bv_player_1: TextureProgressBar = $EF_BarraVidaPlayer1
@onready var bv_player_1: TextureProgressBar = $BarraVidaPlayer1

@onready var ef_bv_player_2: TextureProgressBar = $EF_BarraVidaPlayer2
@onready var bv_player_2: TextureProgressBar = $BarraVidaPlayer2

@onready var bp_power_player_1: TextureProgressBar = $Power_Player1
@onready var bp_power_player_2: TextureProgressBar = $Power_Player2

@export var vidaMAX: int = 100
@export var vida_1: int = 100
@export var vida_2: int = 100

@export var power_1: int = 0
@export var power_2: int = 0
@export var powerMAX: int = 60


signal time_is_up()

func _ready() -> void:
	# Inicializa as barras de vida
	_init_vida()

func _process(delta: float) -> void:
	# Atualiza as barras de vida com a vida atual dos jogadores
	if Global.player1 and Global.player2:
		if (Global.player1.vida != vida_1):
			_set_vida1(Global.player1.vida)
		if (Global.player2.vida != vida_2):
			_set_vida2(Global.player2.vida)
		if (Global.player1.power != power_1):
			_set_power1(Global.player1.power)
		if (Global.player2.power != power_2):
			_set_power2(Global.player2.power)
	

func _init_vida():
	# Definir as barras de vida máximas
	for bar in [bv_player_1, bv_player_2, ef_bv_player_1, ef_bv_player_2]:
		bar.max_value = vidaMAX
		bar.value = vidaMAX
		
	bp_power_player_1.max_value = powerMAX
	bp_power_player_2.max_value = powerMAX
	
	

func _set_vida1(nova_vida1 : int):
	vida_1 = nova_vida1
	move_tween(bv_player_1, vida_1, 0.1)
	timer_barra.start(1.0)
	await timer_barra.timeout
	move_tween(ef_bv_player_1, vida_1, 0.1)
	
	
func _set_vida2(nova_vida2 : int):
	vida_2 = nova_vida2
	move_tween(bv_player_2, vida_2, 0.1)
	timer_barra.start(1.0)
	await timer_barra.timeout
	move_tween(ef_bv_player_2, vida_2, 0.1)

func _set_power1(novo_power1 : int):
	power_1 = novo_power1
	move_tween(bp_power_player_1, power_1, 0.2)


func _set_power2(novo_power2 : int):
	power_2 = novo_power2
	move_tween(bp_power_player_2, power_2, 0.2)
	
func move_tween(node, nova_vida, speed):
	var tween = node.create_tween()
	tween.set_parallel(true)
	tween.tween_property(node, "value", nova_vida, speed)
