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
		if ((Global.player1.vida != vida_1) or (Global.player2.vida != vida_2) ):
			_update_health_bars(Global.player1.vida,Global.player2.vida)
			_update_power_bars(Global.player1.power,Global.player2.power)
		if ((Global.player1.power != power_1) or (Global.player2.power != power_2) ):
			_update_power_bars(Global.player1.power,Global.player2.power)
	

func _init_vida():
	# Definir as barras de vida máximas
	for bar in [bv_player_1, bv_player_2, ef_bv_player_1, ef_bv_player_2]:
		bar.max_value = vidaMAX
		bar.value = vidaMAX

func _update_health_bars(nova_vida1 : int, nova_vida2 : int):
	# Acessa as vidas dos jogadores diretamente
	nova_vida1 = clamp(nova_vida1, 0, vidaMAX)  # Restringe o valor entre 0 e vidaMAX
	vida_1 = nova_vida1
	
	nova_vida2 = clamp(nova_vida2, 0, vidaMAX)  # Restringe o valor entre 0 e vidaMAX
	vida_2 = nova_vida2
	
	move_tween(bv_player_1, vida_1, 0.1)
	move_tween(bv_player_2, vida_2, 0.1)
	timer_barra.start(1.0)
	await timer_barra.timeout
	move_tween(ef_bv_player_1, vida_1, 0.1)
	move_tween(ef_bv_player_2, vida_2, 0.1)

func _update_power_bars(novo_power1 : int, novo_power2 : int):
# Acessa o poder dos jogadores diretamente
	novo_power1 = clamp(novo_power1, 0, powerMAX)  # Restringe o valor entre 0 e vidaMAX
	power_1 = novo_power1
	
	novo_power2 = clamp(novo_power2, 0, powerMAX)  # Restringe o valor entre 0 e vidaMAX
	power_2 = novo_power2
	
	move_tween(bp_power_player_1, power_1, 0.2)
	move_tween(bp_power_player_2, power_2, 0.2)
	
func move_tween(node, nova_vida, speed):
	var tween = node.create_tween()
	tween.set_parallel(true)
	tween.tween_property(node, "value", nova_vida, speed)
