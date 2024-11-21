extends Node

var player1Diretorio = "res://Cenas/michel.tscn" # depois tirar pois é pra teste só a variavel
var player2Diretorio = "res://Cenas/neemias.tscn"# depois tirar pois é pra teste manter só a variavel
var round = 1
var player2_round = 0
var player1_round = 0
var player1 = null
var player2 = null
var pos_incial_round_player1 
var pos_incial_round_player2
var mapaEscolhido = "res://prefer/world.tscn"

func reseta_round():
	pass

#modo chaveamento

var chaveamento = false
var rodada = 1
var rodada_players = ["",""]
#nome dos players
var c_players = ["", "", "", "", "", "", "", ""]

var vencerdor_c1 = ""
var vencerdor_c2 = ""
var vencerdor_c3 = ""
var vencerdor_c4 = ""

var final_p1 =""
var final_p2 =""

func _process(delta: float) -> void:
	if(chaveamento):
		if(rodada == 1):
			rodada_players[0] = c_players[0]
			rodada_players[1] = c_players[1]
