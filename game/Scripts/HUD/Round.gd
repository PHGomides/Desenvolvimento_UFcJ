extends Control

@onready var _1: TextureRect = $"1"
@onready var _2: TextureRect = $"2"
@onready var _3: TextureRect = $"3"
@onready var fight: TextureRect = $Fight

@onready var mark_player_1: Marker2D = $"../../Players/MarkPlayer1"
@onready var mark_player_2: Marker2D = $"../../Players/MarkPlayer2"

@onready var round_player_1_1: TextureRect = $Round_player1_1
@onready var round_player_1_2: TextureRect = $Round_player1_2
@onready var round_player_2_1: TextureRect = $Round_player2_1
@onready var round_player_2_2: TextureRect = $Round_player2_2


@onready var player: CharacterBody2D = $"../../player"
@onready var player_2: CharacterBody2D = $"../../player2"
@onready var tempo: Control = $"../Tempo"
@onready var barras: Control = $"../Barras"
@onready var round: Label = $round

@onready var control: CanvasLayer = $"../../Control"



signal iniciar_time()
signal reset_time()

func _ready() -> void:
	round_player_1_1.visible = false
	round_player_1_2.visible = false
	round_player_2_1.visible = false
	round_player_2_2.visible = false
	tempo.connect("time_is_up", Callable(self, "_on_time_is_up"))	
	barras.connect("vida_zero", Callable(self, "_on_time_is_up"))
	_init_round()
	

	
func _init_round():
	
	print("Round ", Global.round)
	round.text = "ROUND " + str(Global.round)
	emit_signal("reset_time")
	_1.visible = false
	_2.visible = false
	_3.visible = false
	fight.visible = false
	await get_tree().create_timer(0.5).timeout
	Global.player1.vida = 100
	Global.player2.vida = 100 
	desativar_controle_jogadores()
	
	_3.visible = true
	await get_tree().create_timer(1).timeout
	_3.visible = false

	_2.visible = true
	await get_tree().create_timer(1).timeout
	_2.visible = false

	_1.visible = true
	await get_tree().create_timer(1).timeout
	_1.visible = false

	fight.visible = true
	await get_tree().create_timer(1).timeout
	fight.visible = false
	emit_signal("iniciar_time")
	ativar_controle_jogadores()

func _on_time_is_up():
	if Global.player1.vida > Global.player2.vida:
		Global.player1_round += 1
		if Global.player1_round == 1: round_player_1_1.visible = true
		if Global.player1_round == 2: round_player_1_2.visible = true
	elif Global.player2.vida > Global.player1.vida:
		Global.player2_round += 1
		if Global.player2_round == 1: round_player_2_1.visible = true
		if Global.player2_round == 2: round_player_2_2.visible = true
	else:
		print("Empate") 
		Global.round -= 1	

	if Global.player1_round == 2:
		print("Player 1 Wins!")
		control.voltarMenuPrincipal()
		
	elif Global.player2_round == 2:
		print("Player 2 Wins!")
		control.voltarMenuPrincipal()
		
	else:
		Global.round += 1
		_init_round()
		Global.player1.global_position = Global.pos_incial_round_player1 
		Global.player2.global_position = Global.pos_incial_round_player2
	 
func desativar_controle_jogadores():
		Global.player1._start_round()
		Global.player2._start_round()

func ativar_controle_jogadores():
		Global.player1._desativar_start_round()
		Global.player2._desativar_start_round()
	
