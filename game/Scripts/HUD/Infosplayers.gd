extends Node

var already_added1 = false 
var already_added2 = false 

@onready var nome_player_1: Label = $NomePlayer1
@onready var nome_player_2: Label = $NomePlayer2
@onready var foto_player_1: TextureRect = $FotoPlayer1
@onready var foto_player_2: TextureRect = $FotoPlayer2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player1 and not already_added1:
		nome_player_1.text = Global.player1.name_player
		foto_player_1.texture = Global.player1.ImageHud
		already_added1= true
		
	if Global.player2 and not already_added2:
		nome_player_2.text = Global.player2.name_player
		foto_player_2.texture = Global.player2.ImageHud
		already_added2 = true
	
