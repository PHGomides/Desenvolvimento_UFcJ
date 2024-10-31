extends VBoxContainer
var Personagem1 = 0
var Personagem2 = 0

var Player1 = "res://Cenas/player.tscn"
var Player2 = "res://Cenas/player_2.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SelecionarPersonagem1(number: int)-> void:
	Personagem1 = number
	if(Personagem1 == 1):
		Global.player1Diretorio = Player1
	elif Personagem1 == 2:
		Global.player1Diretorio = Player2
	

func SelecionarPersonagem2(number: int)-> void:
	Personagem2 = number
	if(Personagem2 == 1):
		Global.player2Diretorio = Player1
	elif Personagem2 == 2:
		Global.player2Diretorio = Player2
