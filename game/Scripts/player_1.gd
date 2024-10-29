extends CharacterBody2D

const SPEED = 700.0
@export var JUMP_VELOCITY=-2000
@export var typePlayer = 1
var GRAVITY = 5000.0 # Valor padrão da gravidade (você pode ajustar este valor)
@export var type_player = 2

@onready var control: Control = $"../HUD/control"


var COMBO_WINDOW_DURATION = 0.15  # Tempo para apertar o botão para continuar o combo inicialmente baixo pro golpe 1
var attack_state = 0  # Estado do ataque
var combo_window = 0.0 #tempo atual da janela de combo
var is_attacking = false

var combo_ready = false  # Indica se o próximo ataque do combo pode ser realizado
# Variável para pulo
var is_jumping = false
#limitador de pulos 2 segundos
var can_jump = true      # Indica se o jogador pode pular
var jump_cooldown_time = 1.0  # Tempo de cooldown para pular
var jump_timer = 0.0    # Temporizador para controlar o cooldown
# Variável booleana que indica se o personagem está atacando



# Variável para decidir se o especial pode ser usado
var using_special = false
var special_could = true

# Variável para controlar o ataque opcional
var opcional_attack = false
var current_direction = 1 #direção do personagem olhando pra direita

# Janela de combo (tempo permitido para encadear ataques)


# Referência ao nó AnimatedSrite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D
@onready var animationEspecial := $especial as AnimatedSprite2D
@onready var particula := preload("res://Cenas/particula.tscn")  # Carrega a cena de fumaça

# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:
		# Atualiza o temporizador de cooldown do pulo
	if not can_jump:
		jump_timer -= delta
		if jump_timer <= 0:
			can_jump = true  # Permite pular novamente após o cooldown
	# Adiciona a gravidade
	if not is_on_floor():
		
		velocity.y += GRAVITY * delta
	if type_player == 1 :
		# Lógica para o pulo com setas
		if Input.is_action_just_pressed("ui_cimaseta") and is_on_floor() and not is_attacking and can_jump:
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
	else:
		# Lógica para o pulo com w
		if Input.is_action_just_pressed("ui_w") and is_on_floor() and not is_attacking and can_jump:
			control.vida_player1 -= 10
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
	if combo_window > 0:
		combo_window -= delta
	else:
		combo_ready = false  # Reseta a habilidade de encadear combos
		if is_attacking and attack_state > 0:
			COMBO_WINDOW_DURATION = 0.15#resetando a janela de combo
			is_attacking = false  # Se o combo não for finalizado, retorna ao estado idle
			attack_state = 0  # Reseta o estado de ataque
			animation.play("idle")  # Volta à animação idle

	if type_player == 1:
		# Lógica para ataque com teclado numerico
		if Input.is_action_just_pressed("ui_punch") and (not is_attacking or combo_ready):
			print("1 foi pressionado")
			is_attacking = true  # Marca que o personagem está atacando
			velocity.x = 0  # Para o movimento horizontal durante o ataque
			
			# Alterna entre as animações de punch
			if attack_state == 0:
				animation.play("punch1")
				attack_state = 1 
			elif attack_state == 1:
				COMBO_WINDOW_DURATION=0.3
				animation.play("punch2")
				attack_state = 2
			else:
				animation.play("punch3")
				attack_state = 0
			
			combo_window = COMBO_WINDOW_DURATION  # Reinicia a janela de combo
			combo_ready = false  # Reseta combo_ready ao iniciar novo ataque
	else:
			# Lógica para ataque com J
		if Input.is_action_just_pressed("ui_J") and (not is_attacking or combo_ready):
			print("j foi pressionado")
			is_attacking = true  # Marca que o personagem está atacando
			velocity.x = 0  # Para o movimento horizontal durante o ataque
			
			# Alterna entre as animações de punch
			if attack_state == 0:
				animation.play("punch1")
				attack_state = 1 
			elif attack_state == 1:
				COMBO_WINDOW_DURATION=0.3
				animation.play("punch2")
				attack_state = 2
			else:
				animation.play("punch3")
				attack_state = 0
			
			combo_window = COMBO_WINDOW_DURATION  # Reinicia a janela de combo
			combo_ready = false  # Reseta combo_ready ao iniciar novo ataque
	if type_player == 1:
		# Lógica para o ataque opcional com teclado numerico
		if Input.is_action_just_pressed("ui_opcional") and not is_attacking and not opcional_attack:
			print("2 foi pressionado")
			animation.play("opcional")
			is_attacking = true
			opcional_attack = true  # Marca que o ataque opcional está em execução
			velocity.x = 0  # Para o movimento horizontal durante o ataque opcional
	else:
		#logica para atque opcional com K
		if Input.is_action_just_pressed("ui_K") and not is_attacking and not opcional_attack:
			print("k foi pressionado")
			animation.play("opcional")
			is_attacking = true
			opcional_attack = true  # Marca que o ataque opcional está em execução
			velocity.x = 0  # Para o movimento horizontal durante o ataque opcional
	if type_player == 1:
		# Lógica para o ataque especial com teclado numerico
		if Input.is_action_just_pressed("ui_especial") and is_on_floor() and not using_special and not is_attacking and special_could:
			print("3 foi pressionado")
			if current_direction == 1:
				animationEspecial.position.x = 691.109
			else:
				animationEspecial.position.x = -691.109
			
			animation.play("especial")
			animationEspecial.play("especialMichel")
			is_attacking = true
			using_special = true  # Marca o especial como usado
			velocity.x = 0  # Para o movimento horizontal durante o ataque especial
	else:
		#Logica para ataque especial com L
		if Input.is_action_just_pressed("ui_L") and is_on_floor() and not using_special and not is_attacking and special_could:
			print("3 foi pressionado")
			if current_direction == 1:
				animationEspecial.position.x = 691.109
			else:
				animationEspecial.position.x = -691.109
			
			animation.play("especial")
			animationEspecial.play("especialMichel")
			is_attacking = true
			using_special = true  # Marca o especial como usado
			velocity.x = 0  # Para o movimento horizontal durante o ataque especial
	if type_player == 1:
		# Movimento só é permitido se não estiver atacando
		if not is_attacking:
			var direction := Input.get_axis("ui_left", "ui_right")

			if direction != 0:
				current_direction = direction
				velocity.x = direction * SPEED
				# Corrigir apenas o sinal da escala, mantendo o valor absoluto constante
				animation.scale.x = abs(animation.scale.x) * direction
				if not is_jumping:
					animation.play("walk")
			elif is_jumping:
				animation.play("jump")
			else:
				animation.play("idle")
				velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_on_floor() and not is_attacking:
			animation.play("jump")
		move_and_slide()
	else:
		# Movimento só é permitido se não estiver atacando
		if not is_attacking:
			var direction := Input.get_axis("ui_A", "ui_D")

			if direction != 0:
				current_direction = direction
				velocity.x = direction * SPEED
				# Corrigir apenas o sinal da escala, mantendo o valor absoluto constante
				animation.scale.x = abs(animation.scale.x) * direction
				if not is_jumping:
					animation.play("walk")
			elif is_jumping:
				animation.play("jump")
			else:
				animation.play("idle")
				velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_on_floor() and not is_attacking:
			animation.play("jump")
		move_and_slide()

# Função que é chamada automaticamente quando a animação termina
func _on_anim_animation_finished() -> void:
	# Verifica se a animação que acabou de terminar é de ataque
	if animation.animation in ["punch1", "punch2", "punch3", "especial", "opcional"]:
		if animation.animation == "especial":
			print("special");
			using_special = false  # Permite o uso do especial novamente
		elif animation.animation == "opcional":
			opcional_attack = false  # Permite o uso do ataque opcional novamente
		
		if combo_window > 0:
			combo_ready = true  # Permite que o combo continue se o botão for pressionado no tempo certo
			
			
		else:
			is_attacking = false  # Permite que o personagem volte a se mover após o ataque, se o combo não foi encadeado
			animation.play("idle")
			COMBO_WINDOW_DURATION = 0.15
			
			#retirando as animações de particulas do personagem
	for child in get_parent().get_children():
		if child is Sprite2D:
			for grandchild in child.get_children():  # Itera sobre os filhos do Sprite2D
				grandchild.queue_free()
		
		if child is AnimatedSprite2D and child.animation == "fumaca_pulo":  # Verifica se é a animação de fumaça
			child.queue_free()  # Remove a animação do mundo		
			
			
