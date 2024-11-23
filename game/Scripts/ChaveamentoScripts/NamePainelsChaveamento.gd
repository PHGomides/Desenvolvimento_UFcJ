extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(Global.chaveamento):
		$LineEdit1.text = Global.c_players[0]
		$LineEdit2.text = Global.c_players[1]
		$LineEdit3.text = Global.c_players[2]
		$LineEdit4.text = Global.c_players[3]
		$LineEdit5.text = Global.c_players[4]
		$LineEdit6.text = Global.c_players[5]
		$LineEdit7.text = Global.c_players[6]
		$LineEdit8.text = Global.c_players[7]
	if(Global.rodada >= 1):
		$vencedor_chave1.text = Global.vencerdor_c1
	if(Global.rodada >= 2):
		$vencedor_chave2.text = Global.vencerdor_c2
	if(Global.rodada >= 3):
		$vencedor_chave3.text = Global.vencerdor_c3
	if(Global.rodada >= 4):
		$vencedor_chave4.text = Global.vencerdor_c4
	if(Global.rodada >= 5):
		$Final1.text = Global.final_p1
	if(Global.rodada >= 6):
		$Final2.text = Global.final_p2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
