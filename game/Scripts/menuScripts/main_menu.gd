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
	#get_tree().root.mode = Window.MODE_FULLSCREEN
	#get_tree().root.borderless = true
	
	$MenuOpcoes/VBoxContainer/sliderMaster.value = AudioServer.get_bus_volume_db(master)
	$MenuOpcoes/VBoxContainer/sliderSFX.value = AudioServer.get_bus_volume_db(sfx)
	$MenuOpcoes/VBoxContainer/sliderMusic.value = AudioServer.get_bus_volume_db(musica)
	pass # Replace with function body.
	$MenuMain/btn1vs1.grab_focus()
	Global.player1Diretorio = null
	Global.player2Diretorio = null
	if(Global.chaveamento == true):
		$MenuMain.visible = false
		$MenuChaveamentoIniciado.visible = true
		if(Global.vencedor_chaveamento != ""):
			$MenuChaveamentoIniciado/vencedorTela.visible = true
			$MenuChaveamentoIniciado/vencedorTela/vencedorTela/Confronto1.text = Global.vencedor_chaveamento
			$MenuChaveamentoIniciado/vencedorTela/vencedorTela/btnSair.grab_focus()
		else:
			
			$MenuChaveamentoIniciado/buttons/btnIniciar.grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back_menu"):  # Verifica se a ação 'ui_b' foi pressionada.
		if $MenuSelecaoPersonagens.visible == true:
			if(Global.chaveamento == true):
				$MenuMain.visible = false
				$MenuSelecaoPersonagens.visible = false
				
				$MenuChaveamentoIniciado.visible = true
				$MenuChaveamentoIniciado/buttons/btnIniciar.grab_focus()

				sound_button_down()
			else:
				$MenuMain.visible = true
				$MenuSelecaoPersonagens.visible = false
				$MenuMain/btn1vs1.grab_focus()
				sound_button_down()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($Creditos.is_playing()):
		$MenuOpcoes/VBoxContainer/buttons/btnCreditos.grab_focus()
	pass


func _on_btn_1_vs_1_pressed() -> void:
	MenuOpcao.visible = false
	$MenuChaveamentoIniciado.visible = false
	MenuSelecaoPersonagens.visible = true
	MenuMain.visible = false
	MenuChaveamento.visible= false
	MenuSelecaoMapa.visible = false
	$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.grab_focus()
	pass # Replace with function body.


func _on_btn_chaveamento_pressed() -> void:
	MenuMain.visible = false
	MenuChaveamento.visible= true
	$MenuChaveamento/buttons/btnIniciar.grab_focus()
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



func _on_btnEscolherMapa() -> void:
	if(Global.player1Diretorio != null && Global.player2Diretorio != null):
		$MenuSelecaoMapa/HBoxContainer/mapa1.grab_focus()
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
	$MenuControles/btnVoltar.grab_focus()
	pass # Replace with function body.


func mudar_de_controles_para_Opcoes() -> void:
	$MenuOpcoes.visible = true
	$MenuControles.visible = false
	$MenuOpcoes/VBoxContainer/buttons/btnControles.grab_focus()
	pass # Replace with function body.


func _on_btn_voltar_escolha_de_personagem_pressed() -> void:
	if(Global.chaveamento):
		$MenuSelecaoPersonagens.visible = false
		$MenuChaveamentoIniciado.visible = true
		$MenuChaveamentoIniciado/buttons/btnIniciar.grab_focus()
	else:
		_on_btn_voltar_pressed()
	pass # Replace with function body.


func ProntoPlayer1() -> void:
	sound_button_down()
	if(Global.player1Diretorio):
		$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.grab_focus()
	pass # Replace with function body.


func ProntoPlayer2() -> void:
	sound_button_down()
	if(Global.player2Diretorio):
		$MenuSelecaoPersonagens/buttons/btnIniciar.grab_focus()
	pass # Replace with function body.


func Mostrar_Creditos() -> void:
	if($Creditos.visible==false):
		$Creditos.visible = true
		$Creditos.play()
	else:
		$Creditos.visible = false
		$Creditos.stop()
	pass # Replace with function body.


func sairChaveamento() -> void:
	_on_btn_voltar_pressed()
	Global.Resetar_Chaveamento()
	$MenuChaveamentoIniciado/vencedorTela.visible = false
	$MenuChaveamentoIniciado/SairChaveamento.visible = false
	$MenuChaveamentoIniciado/Inputs/vencedor_chave1.text = ""
	$MenuChaveamentoIniciado/Inputs/vencedor_chave2.text = ""
	$MenuChaveamentoIniciado/Inputs/vencedor_chave3.text = ""
	$MenuChaveamentoIniciado/Inputs/vencedor_chave4.text = ""
	$MenuChaveamentoIniciado/Inputs/Final1.text = ""
	$MenuChaveamentoIniciado/Inputs/Final2.text = ""
	$MenuChaveamentoIniciado/bgFinal.visible = false 
	$MenuChaveamentoIniciado/bgNormal.visible = true
	pass # Replace with function body.
