extends Sprite2D

@onready var powerOpitionalArea = $powerOpitional

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(get_parent().current_direction == 1):
		position.x = 142.54
		$AnimatedSprite2D.flip_v = false
	else:
		position.x = -140.11
		$AnimatedSprite2D.flip_v = true
	pass
