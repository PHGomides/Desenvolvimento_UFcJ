extends Control


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.chaveamento):
		visible = true
		$Confronto1.text = Global.rodada_players[0]
		$Confronto2.text = Global.rodada_players[1]
	else:
		visible = false
		
	
