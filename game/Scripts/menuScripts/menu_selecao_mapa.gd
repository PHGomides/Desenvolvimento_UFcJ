extends Control
@export var mapa_atual=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#apertando botão pra seleção de mapa
func _on_mapaBtn_pressed(mapa_id: int) -> void:
	mapa_atual = mapa_id
	pass # Replace with function body.

func IniciarMapa() -> void:
	if(mapa_atual == 1):
		get_tree().change_scene_to_file("res://prefer/world.tscn")
	elif(mapa_atual == 2):
		get_tree().change_scene_to_file("res://prefer/fila_caj.tscn")
	elif(mapa_atual == 4):
		get_tree().change_scene_to_file("res://prefer/frente_ufj.tscn")
	elif(mapa_atual == 5):
		get_tree().change_scene_to_file("res://prefer/restaurante.tscn")
	else:
		print("aleatorio")
	pass # Replace with function body.
	
