extends CharacterBody2D
#Pedro
const SPEED = 700.0
@export var JUMP_VELOCITY=-2000
var GRAVITY = 5000.0 # Valor padrão da gravidade (você pode ajustar este valor)
@export var type_player: int = 2
var name_player = "Pedro"
@export var ImageHud: Texture
@onready var powerOptional = $PoderOpicional
var can_launch_Opitional_Power = false
var powerOpitional_cooldown_time = 3.0
var poweropitional_timer = 0.0
#VIDA
var vida_maxima: int = 100  # Saúde máxima
var vida: int = 100  # Saúde máxima
var is_alive = true #verifica se está vivo
var player_was_murder = false #variavel pra matar o player
var can_punch = true #faz com que o personagem só possa bater dps que terminar a animação
var can_take_damege = false # o jogador não vai conseguir tomar dano, é usado pra evitar que o player tome 2 danos quando a partida reenicia
#PODER
var MaxPower: int = 60
var power: int = 0
var altura_Poder = 0  # O valor de deslocamento que você deseja na direção vertical

signal punch_activated(state: String)  # Definindo um sinal para cada estado de ataque do combo

var COMBO_WINDOW_DURATION = 0.5  # Tempo para apertar o botão para continuar o combo inicialmente baixo pro golpe 1
var attack_state = 0  # Estado do ataque
var combo_window = 0.0 #tempo atual da janela de combo

# Variável booleana que indica se o personagem está atacando
var is_attacking = false
var is_suffering_damage = false #está sofrendo dano
var is_round = true #player não pode mecher se tiver verdadeiro, serve pra pausar os movimentos do player enquanto estiver passando os componentes de round na tela
var combo_ready = false  # Indica se o próximo ataque do combo pode ser realizado

# Variável para pulo
var is_jumping = false

#limitador de pulos 2 segundos
var can_jump = true      # Indica se o jogador pode pular
var jump_cooldown_time = 1.0  # Tempo de cooldown para pular
var jump_timer = 0.0    # Temporizador para controlar o cooldown



# Definição da variável para indicar se o jogador está defendendo
var is_defending = false
var break_defense = false
# Variável para decidir se o especial pode ser usado
var using_special = false
var special_could = true

# Variável para controlar o ataque opcional
var opcional_attack = false
var current_direction #direção do personagem olhando pra direita

# Janela de combo (tempo permitido para encadear ataques)

var controles

#DASH

const DASH_SPEED = 2000.0
var dashing = false
var can_dash = true
var dashing_cooldown_time = 0.7  # Tempo de cooldown para pular
var dashing_timer = 0.0    # Temporizador para controlar o cooldown
var isWalking = false


var escala_personagem = 1.3 #tamanho do personagem
# Referência ao nó AnimatedSrite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D
@onready var animationEspecial := $especial as AnimatedSprite2D
@onready var particula := preload("res://Cenas/particula.tscn")  # Carrega a cena de fumaça

func _ready() -> void:
	
	controles = {
		"jump": "ui_cimaseta",
		"move_left": "ui_esquerda_P2",
		"move_right": "ui_direita_P2",
		"punch": "ui_punch",
		"special": "ui_especial",
		"optional": "ui_opcional",
		"defense": "ui_defesa",
		"dash": "dash_p2"
	}if type_player == 1 else {
		"jump": "ui_w",
		"move_left": "ui_A",
		"move_right": "ui_D",
		"punch": "ui_J",
		"special": "ui_L",
		"optional": "ui_K",
		"defense": "ui_U",
		"dash": "dash_p1"
	}
	
# Garante que o personagem esteja virado para a direita
	if(type_player == 1):
		animation.scale.x = -abs(animation.scale.x)  # Define a escala positiva, garantindo que olhe para a direita
		current_direction = 1  # Define a direção atual para a direita
	else:
		animation.scale.x = abs(animation.scale.x)  # Define a escala positiva, garantindo que olhe para a direita
		current_direction = -1  # Define a direção atual para a direita
	VirarDeLado() 
	




# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:

	if(using_special and not is_attacking):
		using_special = false
	if(opcional_attack and not is_attacking):
		opcional_attack = false
	
	if(not is_attacking):
		is_suffering_damage = false

		# Atualiza o temporizador de cooldown do pulo
	scale.x = escala_personagem
	scale.y = escala_personagem
	if not can_launch_Opitional_Power:
		poweropitional_timer -= delta
		if poweropitional_timer <= 0:
			can_launch_Opitional_Power = true  # Permite pular novamente após o cooldown
			
	if not can_jump:
		jump_timer -= delta
		if jump_timer <= 0:
			can_jump = true  # Permite pular novamente após o cooldown

	if not can_dash:
		dashing_timer -= delta
		if dashing_timer <= 0:
			can_dash = true  # Permite pular novamente após o cooldown
	# Adiciona a gravidade
	if not is_on_floor():
		
		velocity.y += GRAVITY * delta
		# Lógica para o pulo 
	if Input.is_action_just_pressed(controles["jump"]) and is_on_floor() and not is_attacking and can_jump and not is_round and not is_suffering_damage and not is_defending:

		is_jumping = true
		velocity.y = JUMP_VELOCITY
		can_jump = false  # Impede pulos até que o cooldown termine
		jump_timer = jump_cooldown_time  # Reseta o temporizador para o cooldown
				
			#adicionando animação de fumaça quando pular
		var particulaPulo = particula.instantiate()  # Instancia a cena de fumaça
		get_parent().add_child(particulaPulo)
		particulaPulo.global_position = self.global_position  # Define a posição no local do jogador
		var fumaca_pulo = particulaPulo.get_node("fumaca_pulo")
		fumaca_pulo.play("fumaca_pulo")  # Substitua pelo nome da animação correta
	elif is_on_floor():
		is_jumping = false


	# Atualiza a janela de combo, se aplicável
	if animation.animation != "comemoracao":
		if combo_window > 0:
			combo_window -= delta
		else:
			combo_ready = false  # Reseta a habilidade de encadear combos
			if is_attacking and attack_state > 0:
				is_attacking = false  # Se o combo não for finalizado, retorna ao estado idle
				can_punch = true
				attack_state = 0  # Reseta o estado de ataque
				animation.play("idle")  # Volta à animação idle

	
	if Input.is_action_just_pressed(controles["punch"]) and (not is_attacking or combo_ready) and not is_round and not is_suffering_damage and not is_defending and can_punch: # Lógica para ataque
		print("j foi pressionado")
		is_attacking = true  # Marca que o personagem está atacando
		velocity.x = 0  # Para o movimento horizontal durante o ataque

			# Alterna entre as animações de punch
		if attack_state == 0:
			can_punch = false
			animation.play("punch1")
			attack_state = 1 
			emit_signal("punch_activated", "state1")  # Emite sinal para ativar colisões de punch1
			is_suffering_damage = false
			isWalking = false
			
		elif attack_state == 1:
			can_punch = false
			animation.play("punch2")
			attack_state = 2
			await get_tree().create_timer(0.1).timeout
			emit_signal("punch_activated", "state2")  # Emite sinal para ativar colisões de punch2 
			is_suffering_damage = false
			isWalking = false
			
		else:
			can_punch = false
			animation.play("punch3")
			attack_state = 0
			#criando um Timer dinamicamente para o atack3 , esse foi o unico timer que funcionou
			var attack_timer = Timer.new()
			add_child(attack_timer)  # Adiciona o Timer como filho do nó atual
			attack_timer.wait_time = 0.3  # Define o tempo de espera
			attack_timer.one_shot = true  # Garante que dispare apenas uma vez
			attack_timer.connect("timeout", Callable(self, "_on_attack3_timer_timeout"))
			attack_timer.start()  # Inicia o Timer
			is_suffering_damage = false
			isWalking = false
			
			
		combo_window = COMBO_WINDOW_DURATION  # Reinicia a janela de combo
		combo_ready = false  # Reseta combo_ready ao iniciar novo ataque

		
		# Lógica para o ataque opcional com teclado numerico
	if Input.is_action_just_pressed(controles["optional"]) and not is_attacking and not opcional_attack and can_launch_Opitional_Power and not is_round and not is_defending and not is_suffering_damage: 
		print("2 foi pressionado")
		emit_signal("punch_activated", "opcional") # Emite sinal para ativar colisões de opcional
		animation.play("opcional")
		SoltarPoder()
		poweropitional_timer = powerOpitional_cooldown_time
		can_launch_Opitional_Power = false
		is_attacking = true
		opcional_attack = true  # Marca que o ataque opcional está em execução
		velocity.x = 0  # Para o movimento horizontal durante o ataque opcional
		is_suffering_damage = false
			

		#Logica para ataque especial com L
	if Input.is_action_just_pressed(controles["special"]) and is_on_floor() and not using_special and not is_attacking and special_could and not is_round and not is_suffering_damage and not is_defending:
		print("L foi pressionado")
		
		if(power >= MaxPower): #Verificar se a barra de power ta cheia
			$EspecialActiveteSfx.play()
			if current_direction == 1:
				animationEspecial.position.x = 630
				animationEspecial.flip_h = false
			else:
				animationEspecial.position.x = -599.175
				animationEspecial.flip_h = true
				
			power = 0
			animation.play("especial")
			SoltarEspecial()
			$Especial_SFX.play()

			animationEspecial.play("especial")
			is_attacking = true
			using_special = true  # Marca o especial como usado
			velocity.x = 0  # Para o movimento horizontal durante o ataque especial
	# Lógica para animação de defesa
	if Input.is_action_pressed(controles["defense"])and is_on_floor() and break_defense ==false and not is_round and not is_suffering_damage and not is_attacking:
		if(using_special or opcional_attack):
			return
		is_defending = true
		velocity.x = 0  # Impede movimento enquanto defende
		animation.play("defesa", false)  # Reproduz a animação de defesa sem looping
	else:
		is_defending = false  # Para a defesa quando a tecla for solta
	
	#logica de dash
	if(Input.is_action_just_pressed(controles["dash"]) and can_dash and isWalking and not using_special):
		
		$DashSfx.play()
		$dashAnimation.play("dash")
		dashing = true
		can_dash = false
		dashing_timer = dashing_cooldown_time
		$dash_timer.start()
		
	
	if not is_round: #logica de Movimenção

		if not is_attacking and not is_defending and not opcional_attack and not using_special:
			var direction: int = sign(Input.get_axis(controles["move_left"], controles["move_right"]))
			if direction != 0:
				current_direction = direction
				
				if(dashing):
					
					velocity.x = direction * DASH_SPEED
				else:
					velocity.x = direction * SPEED
					# Corrigir apenas o sinal da escala, mantendo o valor absoluto constante
				animation.scale.x = abs(animation.scale.x) * direction
				if not is_jumping:
					animation.play("walk")
					is_attacking = false
					isWalking = true
					
			elif is_jumping:
				animation.play("jump")
				isWalking = false
			else:
				isWalking = false
				animation.play("idle")
				velocity.x = move_toward(velocity.x, 0, SPEED)
	elif is_round and vida <= 0 and is_alive:
		animation.play("morrer")
	elif not is_alive:
		animation.play("invisivel")
	else:
		if animation.animation != "comemoracao":
			animation.play("idle")
			
	if not is_on_floor() and not is_attacking:
		animation.play("jump")
	move_and_slide()
		
	if current_direction == 1: 
		$hitbox/punch1e2.position.x = 95.109
		$hitbox/punch3eopcional.position.x = 95.484
		$hitbox/especialShape.position.x = 1023.109
		$dashAnimation.position.x = -165.211
		$dashAnimation.flip_h = true
	elif current_direction == -1:
		$hitbox/punch1e2.position.x = -109.891
		$hitbox/punch3eopcional.position.x = -108.891
		$hitbox/especialShape.position.x = -1023.109
		$dashAnimation.position.x = 185.109
		$dashAnimation.flip_h = false

func parar_movimento():
	velocity = Vector2.ZERO		
func _on_attack3_timer_timeout(): #função pra colocar delay de dano no attack3
	emit_signal("punch_activated", "state3")
	
func SoltarPoder():
	isWalking = false
	$PoderOpicionalAudio.play()
	powerOptional.visible = true
	powerOptional.powerOpitionalArea.powerColision.disabled = false
	var start_position = powerOptional.global_position
	var end_position

	if current_direction == 1:
		end_position = start_position + Vector2(2500, 0)  # Ajuste a distância conforme necessário
	else:
		end_position = start_position + Vector2(-2500, 0)  # Ajuste a distância conforme necessário

	# Cria o Tween para movimentação suave
	var tween = create_tween()
	# Move para a posição final usando `global_position`
	tween.tween_property(powerOptional, "global_position", end_position, 1.5)
	tween.finished.connect(func(): reset_power())

func reset_power():
	# Ajuste a altura, somando um valor no eixo Y

	powerOptional.global_position = position + Vector2(0, altura_Poder)  # Deslocando na direção Y
	powerOptional.visible = false
	powerOptional.powerOpitionalArea.powerColision.disabled = true
	

func VirarDeLado() -> void:
	current_direction = current_direction*-1
	animation.scale.x = abs(animation.scale.x) * current_direction

func KnockBack(force: float = 500.0) -> void:
	isWalking = false
	if(vida<=0 || using_special):
		return
	# Define a direção contrária ao dano para aplicar o knockback
	var knockback_direction = -current_direction
	velocity.x = knockback_direction * force  # Aplica a força de knockback inicial

	# Cria um Timer para reduzir gradualmente a velocidade
	var knockback_timer = Timer.new()
	knockback_timer.wait_time = 0.1
	knockback_timer.one_shot = false  # Timer contínuo para reduzir o knockback aos poucos
	add_child(knockback_timer)
	
	knockback_timer.connect("timeout", Callable(self, "_reduce_knockback"))
	knockback_timer.start()

func _reduce_knockback(timer: Timer) -> void:
	# Diminui gradativamente a velocidade até que seja nula
	velocity.x = lerp(velocity.x, 0, 0.2)  # Suaviza a velocidade horizontal
	

	# Para o knockback quando a velocidade é quase zero
	if abs(velocity.x) < 10:
		velocity.x = 0
		timer.stop()  # Para o Timer quando o knockback é reduzido totalmente
		timer.queue_free()  # Remove o Timer
		parar_movimento()

func SoltarEspecial() -> void:
	isWalking = false
	# Cria um timer temporário e adiciona ao personagem
	var timer = Timer.new()
	timer.wait_time = 1.0  # Define o tempo de espera para 1 segundo
	timer.one_shot = true  # O timer deve disparar apenas uma vez
	add_child(timer)
	
	# Conecta o sinal timeout do timer à função que emitirá o sinal
	timer.connect("timeout", Callable(self, "_emit_special_signal"))
	
	# Inicia o timer
	timer.start()

# Função auxiliar para emitir o sinal após o timer terminar
func _emit_special_signal() -> void:
	emit_signal("punch_activated", "state4")

func _damage(damegeValue: int, tipoGolpe: String) -> void:
	is_suffering_damage = false
	can_punch = true
	parar_movimento()

	opcional_attack = false
	isWalking = false
	if(using_special):
		return

	if(is_defending== false):
		is_attacking = true
		vida-= damegeValue
		power += 7
		power = clamp(power, 0, MaxPower)
		IncrementarEspecialInimigo()
		animation.play("damage")
		is_suffering_damage = true
		$SangrarAnimationSprite.play("sangrar")
		if(attack_state >= 1):
			attack_state = 0
			KnockBack(1300)
			
	elif(tipoGolpe == "punch3"):
		break_defense = true
		is_defending = false
		print("sofri dano defendeeeeendo")
		is_attacking = true
		vida-= damegeValue
		power += 7
		power = clamp(power, 0, MaxPower)
		IncrementarEspecialInimigo()
		animation.play("damage")
		is_suffering_damage = true
		$SangrarAnimationSprite.play("sangrar")
		if(attack_state >= 1):
			attack_state = 0
			KnockBack(1300)
		
			
	elif(tipoGolpe == "especialShape"):
		break_defense = true
		is_defending = false
		print("sofri dano defendeeeeendo")
		is_attacking = true
		vida-= damegeValue/2
		power += 7
		power = clamp(power, 0, MaxPower)
		IncrementarEspecialInimigo()
		animation.play("damage")
		is_suffering_damage = true
		$SangrarAnimationSprite.play("sangrar")
		
		
	else:
		$DefesaSfx.play()
		
	
		

func IncrementarEspecialInimigo():
	if(type_player ==1):
		Global.player1.power += 3
	else:
		Global.player2.power += 3

func _start_round() -> void: 
	is_round = true
	can_take_damege = false
	isWalking = false
	poweropitional_timer = 6.0
	can_launch_Opitional_Power = false
	parar_movimento()

func _desativar_start_round() -> void: 
	is_round = false
	can_take_damege = true
	can_punch = true
	using_special = false
	parar_movimento()

	

func vitoria()-> void:
	animation.stop()
	animation.play("comemoracao")
	$especial.visible = false
	$luz_vitoria.visible = true
	await get_tree().create_timer(2).timeout

# Função que é chamada automaticamente quando a animação termina
func _on_anim_animation_finished() -> void:
	# Verifica se a animação que acabou de terminar é de ataque
	if animation.animation in ["punch1", "punch2", "punch3", "especial", "opcional", "damage","comemoracao","morrer"]:
		if animation.animation == "especial":
			print("special");
			is_attacking = false
			using_special = false  # Permite o uso do especial novamente
		elif animation.animation == "opcional":
			
			opcional_attack = false  # Permite o uso do ataque opcional novamente
		elif animation.animation == "damage":
			is_suffering_damage = false
			break_defense = false
			is_attacking = false
		elif animation.animation == "punch3":
			is_attacking = false
		elif animation.animation == "morrer":
			animation.play("invisivel")
			is_alive = false
			return
		if animation.animation != "comemoracao":
			if combo_window > 0:
				combo_ready = true  # Permite que o combo continue se o botão for pressionado no tempo certo
				can_punch = true
			else:
				is_attacking = false  # Permite que o personagem volte a se mover após o ataque, se o combo não foi encadeado
				animation.play("idle")
				#retirando as animações de particulas do personagem
				is_suffering_damage = false
				
				can_punch = true

		
	for child in get_parent().get_children():
		if child is Sprite2D:
			for grandchild in child.get_children():  # Itera sobre os filhos do Sprite2D
				grandchild.queue_free()
		
		if child is AnimatedSprite2D and child.animation == "fumaca_pulo":  # Verifica se é a animação de fumaça
			child.queue_free()  # Remove a animação do mundo		
			
			


func _on_dash_timer_timeout() -> void:
	dashing = false
	pass # Replace with function body.
