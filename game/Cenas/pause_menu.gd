extends CanvasLayer

func sound_button_down() -> void:
	$clickmenu.play()
	pass
	
func sound_entered_btn() -> void:
	$HitSound.play()
	pass
	
var master = AudioServer.get_bus_index("Master")
var sfx = AudioServer.get_bus_index("SFX")
var musica = AudioServer.get_bus_index("Musica")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	$opcoes/VBoxContainer/sliderMaster.value = AudioServer.get_bus_volume_db(master)
	$opcoes/VBoxContainer/sliderSFX.value = AudioServer.get_bus_volume_db(sfx)
	$opcoes/VBoxContainer/sliderMusic.value = AudioServer.get_bus_volume_db(musica)


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


func abrirOpcoesPause() -> void:
	$PauseMenuMain.visible = false
	$opcoes.visible = true
	pass # Replace with function body.


func voltarPauseMenuMain() -> void:
	$PauseMenuMain.visible = true
	$opcoes.visible = false
	pass # Replace with function body.




func _on_slider_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master,value)
	if value==-30:
		AudioServer.set_bus_mute(master,true)
	else:
		AudioServer.set_bus_mute(master,false)

	pass # Replace with function body.


func _on_slider_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx,value)
	if value==-30:
		AudioServer.set_bus_mute(sfx,true)
	else:
		AudioServer.set_bus_mute(sfx,false)
	pass # Replace with function body.


func _on_slider_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musica,value)
	if value==-30:
		AudioServer.set_bus_mute(musica,true)
	else:
		AudioServer.set_bus_mute(musica,false)
	pass # Replace with function body.
