extends Control

var Personagem1 = 0
var Personagem2 = 0

var Player1 = "res://Cenas/michel.tscn"
var Player2 = "res://Cenas/neemias.tscn"
var Pedro = "res://Cenas/Pedro.tscn"
var Gabriel = "res://Cenas/Gabriel.tscn"
var Alisson = "res://Cenas/alisson.tscn"
var Walisson = "res://Cenas/Walisson.tscn"
var Franch = "res://Cenas/Frances.tscn"
@onready var AnimacaoP1Menu = $AnimacaoP1Menu
@onready var AnimacaoP2Menu = $AnimacaoP2Menu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func SelecionarPersonagem1(number: int)-> void:
	Personagem1 = number
	$HBoxContainer/PersonagensP1/ProntoBtn.grab_focus()
	if(Personagem1 == 1):
		Global.player1Diretorio = Player1
		AnimacaoP1Menu.play("Michel")
		
	elif Personagem1 == 2:
		Global.player1Diretorio = Player2
		AnimacaoP1Menu.play("Neemias")
	elif Personagem1 == 3:
		Global.player1Diretorio = Gabriel
		AnimacaoP1Menu.play("Gabriel")
	elif Personagem1 == 4:
		Global.player1Diretorio = Franch
		AnimacaoP1Menu.play("Franch")
	elif Personagem1 == 5:
		Global.player1Diretorio = Pedro
		AnimacaoP1Menu.play("Pedro")
	elif Personagem1 == 6:
		Global.player1Diretorio = Alisson
		AnimacaoP1Menu.play("Alisson")
	elif Personagem1 == 7:
		Global.player1Diretorio = Walisson
		AnimacaoP1Menu.play("Walisson")

func SelecionarPersonagem2(number: int)-> void:
	Personagem2 = number
	$HBoxContainer/PersonagensP2/ProntoBtn.grab_focus()
	if(Personagem2 == 1):
		Global.player2Diretorio = Player1
		AnimacaoP2Menu.play("Michel")
	elif Personagem2 == 2:
		Global.player2Diretorio = Player2
		AnimacaoP2Menu.play("Neemias")
	elif Personagem2 == 3:
		Global.player2Diretorio = Gabriel
		AnimacaoP2Menu.play("Gabriel")
	elif Personagem2 == 5:
		Global.player2Diretorio = Pedro
		AnimacaoP2Menu.play("Pedro")
	elif Personagem1 == 4:
		Global.player2Diretorio = Franch
		AnimacaoP2Menu.play("Franch")
	elif Personagem2 == 6:
		Global.player2Diretorio = Alisson
		AnimacaoP2Menu.play("Alisson")
	elif Personagem2 == 7:
		Global.player2Diretorio = Walisson
		AnimacaoP2Menu.play("Walisson")
