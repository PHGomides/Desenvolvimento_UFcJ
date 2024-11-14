extends TextureRect

var already_added = false #verifica se o nome do player já foi inserido
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player1 and not already_added:
		texture = Global.player1.ImageHud
		already_added = true
	pass
