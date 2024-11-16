extends Sprite2D

@onready var powerOpitionalArea = $powerOpitionalArea

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(visible == false):
	
		if(get_parent().current_direction == 1):
			position.x = 146.11
			$AnimatedSprite2D.flip_h = false
		else:
			position.x = -140.11
			$AnimatedSprite2D.flip_h = true
