extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.rodada >= 7:
		$bgFinal.visible = true
		$bgNormal.visible = false
	else:
		$bgNormal.visible = true
		$bgFinal.visible = false
		

		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Confronto1.text = Global.rodada_players[0]
	$Confronto2.text = Global.rodada_players[1]


func _on_btn_Sair_pressed() -> void:
	$SairChaveamento.visible = not $SairChaveamento.visible 
	if($SairChaveamento.visible):
		$SairChaveamento/HBoxContainer/btnSim.grab_focus()
	else:
		$buttons/btnSair.grab_focus()
	pass # Replace with function body.
