extends Node

var player1Diretorio = "res://Cenas/alisson.tscn" # depois tirar pois é pra teste só a variavel
var player2Diretorio = "res://Cenas/alisson.tscn"# depois tirar pois é pra teste manter só a variavel
var round = 1
var player2_round = 0
var player1_round = 0
var player1 = null
var player2 = null
var pos_incial_round_player1 
var pos_incial_round_player2
var mapaEscolhido = "res://prefer/world.tscn"

func resetar_round():
	round = 1
	player2_round = 0
	player1_round = 0
	player1 = null
	player2 = null
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

var vencedor_chaveamento = ""

func FimRodada(vencedor: String):
	if(rodada == 1):
		vencerdor_c1 = vencedor
		rodada+=1
	elif(rodada == 2):
		vencerdor_c2 = vencedor
		rodada+=1
	elif(rodada == 3):
		vencerdor_c3 = vencedor
		rodada+=1
	elif(rodada == 4):
		vencerdor_c4 = vencedor
		rodada+=1
	elif(rodada == 5):
		final_p1 = vencedor
		rodada+=1
	elif(rodada == 6):
		final_p2 = vencedor
		rodada+=1
	elif(rodada == 7):
		vencedor_chaveamento = vencedor
		
func Resetar_Chaveamento():
	chaveamento = false
	rodada = 1
	c_players = ["", "", "", "", "", "", "", ""]
	vencedor_chaveamento = ""
	final_p1 =""
	final_p2 =""
	rodada_players = ["",""]
	vencerdor_c1 = ""
	vencerdor_c2 = ""
	vencerdor_c3 = ""
	vencerdor_c4 = ""
	
		

func _process(delta: float) -> void:
	if(chaveamento):
		if(rodada == 1):
			rodada_players[0] = c_players[0]
			rodada_players[1] = c_players[1]
		elif(rodada == 2):
			rodada_players[0] = c_players[2]
			rodada_players[1] = c_players[3]
		elif(rodada == 3):
			rodada_players[0] = c_players[4]
			rodada_players[1] = c_players[5]
		elif(rodada == 4):
			rodada_players[0] = c_players[6]
			rodada_players[1] = c_players[7]
		elif(rodada == 5):
			rodada_players[0] = vencerdor_c1
			rodada_players[1] = vencerdor_c2
		elif(rodada == 6):
			rodada_players[0] = vencerdor_c3
			rodada_players[1] = vencerdor_c4
		elif(rodada == 7):
			rodada_players[0] = final_p1
			rodada_players[1] = final_p2
