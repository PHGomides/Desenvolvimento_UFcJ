extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_btn_iniciar_pressed() -> void:
	randomize()
	var players = [
		$VBoxContainer/LineEdit1.text,
		$VBoxContainer/LineEdit2.text,
		$VBoxContainer/LineEdit3.text,
		$VBoxContainer/LineEdit4.text,
		$VBoxContainer/LineEdit5.text,
		$VBoxContainer/LineEdit6.text,
		$VBoxContainer/LineEdit7.text,
		$VBoxContainer/LineEdit8.text
	]
	for player in players:
		if player.strip_edges() == "":
			print("Erro: Todos os campos devem estar preenchidos!")
			return # Sai da função se houver um campo vazio
	players.shuffle()
	Global.c_players[0] = players[0]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit1".text = Global.c_players[0]
	Global.c_players[1] = players[1]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit2".text = Global.c_players[1]
	Global.c_players[2] = players[2]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit3".text = Global.c_players[2]
	Global.c_players[3] = players[3]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit4".text = Global.c_players[3]
	Global.c_players[4] = players[4]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit5".text = Global.c_players[4]
	Global.c_players[5] = players[5]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit6".text = Global.c_players[5]
	Global.c_players[6] = players[6]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit7".text = Global.c_players[6]
	Global.c_players[7] = players[7]
	$"../MenuChaveamentoIniciado/Inputs/LineEdit8".text = Global.c_players[7]
	
	Global.chaveamento = true
	
	$"../MenuChaveamentoIniciado".visible = true
	visible = false
