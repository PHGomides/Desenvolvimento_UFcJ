extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextureRect/Confronto1.text = Global.rodada_players[0]
	$TextureRect/Confronto2.text = Global.rodada_players[1]


func _on_btn_Sair_pressed() -> void:
	$Inputs/SairChaveamento.visible = not $Inputs/SairChaveamento.visible 
	pass # Replace with function body.


func _on_btn_sim_pressed() -> void:#acabar com o modo chaveamento
	$Inputs/SairChaveamento.visible = not $Inputs/SairChaveamento.visible 
	Global.chaveamento = false
	
	pass # Replace with function body.
