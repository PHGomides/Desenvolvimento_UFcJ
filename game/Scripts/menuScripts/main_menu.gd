extends Control

@onready var MenuMain = $MenuMain
@onready var MenuSelecaoPersonagens = $MenuSelecaoPersonagens
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
	$MenuOpcoes/VBoxContainer/sliderMaster.value = AudioServer.get_bus_volume_db(master)
	$MenuOpcoes/VBoxContainer/sliderSFX.value = AudioServer.get_bus_volume_db(sfx)
	$MenuOpcoes/VBoxContainer/sliderMusic.value = AudioServer.get_bus_volume_db(musica)
	pass # Replace with function body.
	$MenuMain/btn1vs1.grab_focus()
	
	if(Global.chaveamento == true):
		$MenuMain.visible = false
		$MenuChaveamentoIniciado.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_1_vs_1_pressed() -> void:
	MenuOpcao.visible = false
	$MenuChaveamentoIniciado.visible = false
	MenuSelecaoPersonagens.visible = true
	MenuMain.visible = false
	MenuChaveamento.visible= false
	MenuSelecaoMapa.visible = false
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
	$MenuOpcoes/VBoxContainer/buttons/btnControles.grab_focus()
	
	pass # Replace with function body.

func _on_btn_voltar_pressed() -> void:
	MenuOpcao.visible = false
	MenuSelecaoPersonagens.visible = false
	MenuMain.visible = true
	$MenuChaveamentoIniciado.visible = false
	MenuChaveamento.visible= false
	MenuSelecaoMapa.visible = false
	$MenuMain/btn1vs1.grab_focus()
	pass # Replace with function body.

func voltarSelecaoMapa() -> void:
	MenuSelecaoPersonagens.visible = true
	MenuSelecaoMapa.visible = false

func _on_btnEscolherMapa() -> void:
	if(Global.player1Diretorio != null && Global.player2Diretorio != null):
		MenuSelecaoPersonagens.visible = false
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


func mostrarControles() -> void:
	$MenuOpcoes.visible = false
	$MenuControles.visible = true
	pass # Replace with function body.


func mudar_de_controles_para_Opcoes() -> void:
	$MenuOpcoes.visible = true
	$MenuControles.visible = false
	pass # Replace with function body.


func _on_btn_voltar_escolha_de_personagem_pressed() -> void:
	if(Global.chaveamento):
		$MenuSelecaoPersonagens.visible = false
		$MenuChaveamentoIniciado.visible = true
	else:
		_on_btn_voltar_pressed()
	pass # Replace with function body.
