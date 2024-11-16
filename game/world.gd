extends Node2D


@onready var camera = $Camera2D

func _ready() -> void:
	$MusicaMapa1.play()
	for p in get_tree().get_nodes_in_group("players"):
		camera.add_target(p)

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:


	pass
