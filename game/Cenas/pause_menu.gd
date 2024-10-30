extends CanvasLayer

func sound_button_down() -> void:
	$clickmenu.play()
	pass
	
func sound_entered_btn() -> void:
	$HitSound.play()
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		sound_button_down()
		if(visible == false):
			visible = true
			get_tree().paused = true
		else:
			visible = false
			get_tree().paused = false

func voltarMenuPrincipal() -> void:
	get_tree().paused = false
	queue_free()  # Libera a cena de carregamento
	var carregamento = load("res://Cenas/Carregamento.tscn").instantiate()
	carregamento.cenaCarregada = "res://Cenas/main_menu.tscn"  # Passa o caminho do mapa
	get_tree().root.add_child(carregamento)


func Despausar() -> void:
	visible = false
	get_tree().paused = false
	pass # Replace with function body.
