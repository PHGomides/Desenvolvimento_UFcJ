extends Label

var already_added = false #verifica se o nome do player já foi inserido
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "ROUND " + str(Global.round)
