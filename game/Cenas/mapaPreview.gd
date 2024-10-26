extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mapa_atual()
	pass

func mapa_atual()-> void:
	var parent = get_parent()
	if parent.mapa_atual == 1:
		print(parent.mapa_atual)	
	pass
