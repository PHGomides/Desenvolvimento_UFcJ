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
@export var powerMAX: int = 100

signal time_is_up()

func _ready() -> void:
	# Inicializa as barras de vida
	_init_vida()

func _process(delta: float) -> void:
	# Atualiza as barras de vida com a vida atual dos jogadores
	if Global.player1 and Global.player2:
		_update_health_bars()
		_update_power_bars()

func _init_vida():
	# Definir as barras de vida máximas
	for bar in [bv_player_1, bv_player_2, ef_bv_player_1, ef_bv_player_2]:
		bar.max_value = vidaMAX
		bar.value = vidaMAX

func _update_health_bars():
	# Acessa as vidas dos jogadores diretamente
	var vida_player1 = Global.player1.get_current_health()  # Método para obter a vida atual do jogador 1
	var vida_player2 = Global.player2.get_current_health()  # Método para obter a vida atual do jogador 2
	
	move_tween(bv_player_1, vida_player1, 0.1)
	move_tween(bv_player_2, vida_player2, 0.1)

func _update_power_bars():
# Acessa o poder dos jogadores diretamente
	var power_player1 = Global.player1.get_current_power()  # Método para obter o poder atual do jogador 1
	var power_player2 = Global.player2.get_current_power()  # Método para obter o poder atual do jogador 2
	move_tween(bp_power_player_1, power_player1, 0.1)
	move_tween(bp_power_player_2, power_player2, 0.1)
	
func move_tween(node, nova_vida, speed):
	var tween = node.create_tween()
	tween.set_parallel(true)
	tween.tween_property(node, "value", nova_vida, speed)
