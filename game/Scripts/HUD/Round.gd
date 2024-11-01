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
	_init_round()


func _process(delta: float) -> void:
	pass
	
func _init_round():
	print("Round ", Global.round)
	_1.visible = false
	_2.visible = false
	_3.visible = false
	fight.visible = false
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
	if barras.vida_player1 > barras.vida_player2:
		player1_round += 1
		Global.round +=1
	elif barras.vida_player2 > barras.vida_player1:
		player2_round += 1
		Global.round += 1
	else:
		print("Empate") 
		
	
	if player1_round >= 3:
		print("Player 1 Wins!")
	elif player2_round >= 3:
		print("Player 2 Wins!")
	else:
		# Caso ninguém tenha vencido, inicia o próximo round
		Global.round += 1
		_init_round()
	 
func desativar_controle_jogadores():
	player.is_round = true
	player_2.is_round = true

func ativar_controle_jogadores():
	player.is_round = false
	player_2.is_round = false
	
