extends Label

var already_added = false #verifica se o nome do player já foi inserido
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player2 and not already_added:
		text = Global.player2.name_player
		already_added = true
	pass
