extends Control


var player2_round = 0
var player1_round = 0

@onready var tempo: Control = $"../Tempo"
@onready var barras: Control = $"../Barras"


func _ready() -> void:
	tempo.connect("time_is_up", Callable(self, "_on_time_is_up"))
	_init_round()


func _process(delta: float) -> void:
	pass
	
func _init_round():
# Exibe a mensagem do round atual (ex: "Round 1")
	print("Round ", Global.round)
	
	
	# Inicia a contagem regressiva de "3, 2, 1, Fight!"

	# Reinicia o relógio e permite que os jogadores se movam
	  # Sinal de início de round

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
	 
	
	
