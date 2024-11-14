extends Control

@onready var _1: TextureRect = $"1"
@onready var _2: TextureRect = $"2"
@onready var _3: TextureRect = $"3"
@onready var fight: TextureRect = $Fight
var player2_round = 0
var player1_round = 0

@onready var player: CharacterBody2D = $"../../player"
@onready var player_2: CharacterBody2D = $"../../player2"
@onready var tempo: Control = $"../Tempo"
@onready var barras: Control = $"../Barras"


func _ready() -> void:
	tempo.connect("time_is_up", Callable(self, "_on_time_is_up"))	
	barras.connect("vida_zero", Callable(self, "_on_time_is_up"))
	_init_round()
	


func _process(delta: float) -> void:
	pass
	
func _init_round():
	print("Round ", Global.round)
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
	ativar_controle_jogadores()

func _on_time_is_up():
	if Global.player1.vida > Global.player2.vida:
		player1_round += 1
		Global.round +=1
	elif Global.player2.vida > Global.player1.vida:
		player2_round += 1
		Global.round += 1
	else:
		print("Empate") 
		
	
	if player1_round >= 3:
		print("Player 1 Wins!")
	elif player2_round >= 3:
		print("Player 2 Wins!")
	else:
		Global.round += 1
		_init_round()
	 
func desativar_controle_jogadores():
		Global.player1._start_round()
		Global.player2._start_round()

func ativar_controle_jogadores():
		Global.player1._desativar_start_round()
		Global.player2._desativar_start_round()
	
