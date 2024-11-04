extends Control

@onready var MenuMain = $MenuMain
@onready var Menu1v1 = $MenuSelecaoPersonagens
@onready var MenuOpcao = $MenuOpcoes
@onready var MenuChaveamento = $MenuChaveamento
@onready var MenuSelecaoMapa = $MenuSelecaoMapa

# Called when the node enters the scene tree for the first time.

#sons de botões:

func sound_entered_btn() -> void:
	$HitSound.play()
	pass

func sound_button_down() -> void:
	$clickmenu.play()
	pass


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_1_vs_1_pressed() -> void:
	MenuMain.visible = false
	Menu1v1.visible = true
	pass # Replace with function body.


func _on_btn_chaveamento_pressed() -> void:
	MenuMain.visible = false
	MenuChaveamento.visible= true
	pass # Replace with function body.


func _on_btn_sair_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_btn_opcoes_pressed() -> void:
	MenuOpcao.visible = true
	MenuMain.visible = false
	pass # Replace with function body.

func _on_btn_voltar_pressed() -> void:
	MenuOpcao.visible = false
	Menu1v1.visible = false
	MenuMain.visible = true
	MenuChaveamento.visible= false
	MenuSelecaoMapa.visible = false
	pass # Replace with function body.

func voltarSelecaoMapa() -> void:
	Menu1v1.visible = true
	MenuSelecaoMapa.visible = false

func _on_btnEscolherMapa() -> void:
	if(Global.player1Diretorio != null && Global.player2Diretorio != null):
		Menu1v1.visible = false
		MenuSelecaoMapa.visible = true
	






var master = AudioServer.get_bus_index("Master")
var sfx = AudioServer.get_bus_index("SFX")
var musica = AudioServer.get_bus_index("Musica")


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
