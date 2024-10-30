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
	print("Mapa " + str(mapa_id) + " selecionado")
	mapa_atual = mapa_id
	pass # Replace with function body.
