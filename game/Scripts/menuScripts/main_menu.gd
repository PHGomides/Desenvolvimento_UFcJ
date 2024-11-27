extends Control

@onready var MenuMain = $MenuMain
@onready var MenuSelecaoPersonagens = $MenuSelecaoPersonagens
@onready var MenuOpcao = $MenuOpcoes
@onready var MenuChaveamento = $MenuChaveamento
@onready var MenuSelecaoMapa = $MenuSelecaoMapa
var personagem_escolhido_p1 = 1
var personagem_escolhido_p2 = 1
var p2_pode_selecionar = true
var p1_pode_selecionar = true
var is_on_player_selector = false
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
	$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.set_pressed(true)
	$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.set_pressed(true)
	
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
			$YeahGanhadorChaveamento.play()
			$MenuChaveamentoIniciado/vencedorTela.visible = true
			$MenuChaveamentoIniciado/vencedorTela/vencedorTela/Confronto1.text = Global.vencedor_chaveamento
			$MenuChaveamentoIniciado/vencedorTela/vencedorTela/btnSair.grab_focus()
		else:
			
			$MenuChaveamentoIniciado/buttons/btnIniciar.grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back_menu"):  # Verifica se a ação 'ui_b' foi pressionada.
		if($MenuSelecaoMapa.visible == true):
			_on_btn_1_vs_1_pressed()
			
		if $MenuSelecaoPersonagens.visible == true and p2_pode_selecionar and p1_pode_selecionar :
			if(Global.chaveamento == true):
				$MenuMain.visible = false
				$MenuSelecaoPersonagens.visible = false
				
				$MenuChaveamentoIniciado.visible = true
				$MenuChaveamentoIniciado/buttons/btnIniciar.grab_focus()
				sair_selecao_personagem()
				sound_button_down()
			else:
				_on_btn_voltar_pressed()
#P1
	if(event.is_action_pressed("select_player_p1_up")):
		if(p1_pode_selecionar and is_on_player_selector):
			sound_entered_btn()
			if(personagem_escolhido_p1 == 1):
				personagem_escolhido_p1 = 8
			personagem_escolhido_p1-=1
			if(personagem_escolhido_p1 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Michel")
			elif(personagem_escolhido_p1 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Neemias.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Neemias")
			elif(personagem_escolhido_p1 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Oka.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Gabriel")
			elif(personagem_escolhido_p1 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Frances.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Franch")
			elif(personagem_escolhido_p1 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Pedro.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Pedro")
			elif(personagem_escolhido_p1 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Alisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Alisson")
			elif(personagem_escolhido_p1 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Walisson.set_pressed(true)	
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Walisson")
			
	if(event.is_action_pressed("select_player_p1_down")):

		if(p1_pode_selecionar and is_on_player_selector):
			sound_entered_btn()
			if(personagem_escolhido_p1 == 7):
				personagem_escolhido_p1 = 0
			personagem_escolhido_p1+=1
			if(personagem_escolhido_p1 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Michel")
			elif(personagem_escolhido_p1 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Neemias.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Neemias")
			elif(personagem_escolhido_p1 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Oka.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Gabriel")
			elif(personagem_escolhido_p1 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Frances.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Franch")
			elif(personagem_escolhido_p1 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Pedro.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Pedro")
			elif(personagem_escolhido_p1 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Alisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Alisson")
			elif(personagem_escolhido_p1 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Walisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP1Menu.play("Walisson")
	if(event.is_action_pressed("confirm_p1_selection")):
		if(is_on_player_selector and p1_pode_selecionar):
			p1_pode_selecionar = false
			if(personagem_escolhido_p1 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Neemias.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Oka.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Frances.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Pedro.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Alisson.emit_signal("pressed")
			elif(personagem_escolhido_p1 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Walisson.emit_signal("pressed")	
			Personagens_foram_escolhidos()
	if(event.is_action_pressed("cancelar_selecao_p1")):
		if(is_on_player_selector):
			p1_pode_selecionar = true
			sound_entered_btn()		
			Personagens_foram_escolhidos()
				
#P2
	if(event.is_action_pressed("select_player_p2_up")):
		if(p2_pode_selecionar and is_on_player_selector):
			sound_entered_btn()
			if(personagem_escolhido_p2 == 1):
				personagem_escolhido_p2 = 8
			personagem_escolhido_p2-=1
			if(personagem_escolhido_p2 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Michel")
			elif(personagem_escolhido_p2 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Neemias.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Neemias")
			elif(personagem_escolhido_p2 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Oka.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Gabriel")
			elif(personagem_escolhido_p2 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Frances.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Franch")
			elif(personagem_escolhido_p2 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Pedro.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Pedro")
			elif(personagem_escolhido_p2 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Alisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Alisson")
			elif(personagem_escolhido_p2 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Walisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Walisson")	
	if(event.is_action_pressed("select_player_p2_down")):

		if(p2_pode_selecionar and is_on_player_selector):
			sound_entered_btn()
			if(personagem_escolhido_p2 == 7):
				personagem_escolhido_p2 = 0
			personagem_escolhido_p2+=1
			if(personagem_escolhido_p2 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Michel")
			elif(personagem_escolhido_p2 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Neemias.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Neemias")
			elif(personagem_escolhido_p2 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Oka.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Gabriel")
			elif(personagem_escolhido_p2 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Frances.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Franch")
			elif(personagem_escolhido_p2 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Pedro.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Pedro")
			elif(personagem_escolhido_p2 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Alisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Alisson")
			elif(personagem_escolhido_p2 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Walisson.set_pressed(true)
				$MenuSelecaoPersonagens/AnimacaoP2Menu.play("Walisson")
	if(event.is_action_pressed("confirm_p2_selection")):
		if(is_on_player_selector and p2_pode_selecionar):
			p2_pode_selecionar = false
			if(personagem_escolhido_p2 == 1):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 2):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Neemias.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 3):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Oka.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 4):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Frances.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 5):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Pedro.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 6):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Alisson.emit_signal("pressed")
			elif(personagem_escolhido_p2 == 7):
				$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Walisson.emit_signal("pressed")	
			Personagens_foram_escolhidos()
	if(event.is_action_pressed("cancelar_selecao_p2")):
		if(is_on_player_selector):
			p2_pode_selecionar = true
			Personagens_foram_escolhidos()
			sound_entered_btn()
func Personagens_foram_escolhidos():
	if(not p2_pode_selecionar and not p1_pode_selecionar):
		await get_tree().create_timer(0.2).timeout
		$MenuSelecaoPersonagens/buttons/btnIniciar.grab_focus()
	else:
		$MenuSelecaoPersonagens/buttons/btnIniciar.release_focus()

func sair_selecao_personagem():
	p2_pode_selecionar = true
	p1_pode_selecionar = true
	is_on_player_selector = false
	personagem_escolhido_p2 = 1
	personagem_escolhido_p1 = 1
	$MenuSelecaoPersonagens/AnimacaoP1Menu.play("addPerson")
	$MenuSelecaoPersonagens/AnimacaoP2Menu.play("addPerson")
	$MenuSelecaoPersonagens/HBoxContainer/PersonagensP1/Player1Michel.set_pressed(true)
	$MenuSelecaoPersonagens/HBoxContainer/PersonagensP2/Player2Michel.set_pressed(true)
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

	is_on_player_selector = true
	await get_tree().create_timer(0.2).timeout
	p1_pode_selecionar = true
	p2_pode_selecionar = true
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
	sair_selecao_personagem()
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
		is_on_player_selector = false
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
