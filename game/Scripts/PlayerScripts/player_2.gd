extends CharacterBody2D
#Neemias
const SPEED = 700.0
@export var JUMP_VELOCITY = -2000.0
var GRAVITY = 5000.0 # Valor padrão da gravidade (você pode ajustar este valor)
@export var type_player: int = 1

#VIDA
var vida_maxima: int = 100  # Saúde máxima
var vida: int = 100  # Saúde máxima


#PODER
var MaxPower: int = 60
var power: int = 60


signal punch_activated_p2(state: String)  # Definindo um sinal para cada estado de ataque do combo
# Janela de combo (tempo permitido para encadear ataques)
var COMBO_WINDOW_DURATION = 0.4  # Tempo para apertar o botão para continuar o combo inicialmente baixo pro golpe 1
var attack_state = 0  # Estado do ataque
var combo_window = 0.0 #tempo atual da janela de combo
var is_attacking = false
var is_round = false

var combo_ready = false  # Indica se o próximo ataque do combo pode ser realizado
# Variável para pulo
var is_jumping = false
var can_jump = true      # Indica se o jogador pode pular
var jump_cooldown_time = 1.0  # Tempo de cooldown para pular
var jump_timer = 0.0    # Temporizador para controlar o cooldo
# Variável booleana que indica se o personagem está atacando



# Variável para decidir se o especial pode ser usado
var using_special = false
var special_could = true

# Variável para controlar o ataque opcional
var opcional_attack = false
var current_direction = -1 #direção do personagem olhando pra esquerda

# Definição da variável para indicar se o jogador está defendendo
var is_defending = false

@onready var especialHitbox = $hitbox_neemias/especialShape



# Referência ao nó AnimatedSrite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D
@onready var animationEspecial := $especial as AnimatedSprite2D

@onready var particula := preload("res://Cenas/particula.tscn")  # Carrega a cena de fumaça

	
func _ready() -> void:

# Garante que o personagem esteja virado para a direita
	if(type_player == 1):
		animation.scale.x = -abs(animation.scale.x)  # Define a escala positiva, garantindo que olhe para a direita
		current_direction = 1  # Define a direção atual para a direita
	else:
		animation.scale.x = abs(animation.scale.x)  # Define a escala positiva, garantindo que olhe para a direita
		current_direction = -1  # Define a direção atual para a direita
	
# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:
	# Adiciona a gravidade
	
	
	scale.x = 1.2
	scale.y = 1.2
	if not can_jump:
		jump_timer -= delta
		if jump_timer <= 0:
			can_jump = true  # Permite pular novamente após o cooldown
	if not is_on_floor():
	
		velocity.y += GRAVITY * delta
	if type_player == 1:
		# Lógica para o pulo setas
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
		# Lógica para o pulo com W
		if Input.is_action_just_pressed("ui_w") and is_on_floor() and not is_attacking and can_jump:
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
			COMBO_WINDOW_DURATION = 0.4#resetando a janela de combo
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
				emit_signal("punch_activated_p2", "state1_p2")  # Emite sinal para ativar colisões de punch1
			elif attack_state == 1:
				animation.play("punch2")
				attack_state = 2
				emit_signal("punch_activated_p2", "state2_p2")  # Emite sinal para ativar colisões de punch2
			else:
				animation.play("punch3")
				attack_state = 0
				emit_signal("punch_activated_p2", "state3_p2")  # Emite sinal para ativar colisões de punch3
			
			combo_window = COMBO_WINDOW_DURATION  # Reinicia a janela de combo
			combo_ready = false  # Reseta combo_ready ao iniciar novo ataque
	else:
		# Lógica para ataque
		if Input.is_action_just_pressed("ui_J") and (not is_attacking or combo_ready):
			print("J foi pressionado")
			is_attacking = true  # Marca que o personagem está atacando
			velocity.x = 0  # Para o movimento horizontal durante o ataque
			
			# Alterna entre as animações de punch
			if attack_state == 0:
				animation.play("punch1")
				attack_state = 1 
				emit_signal("punch_activated_p2", "state1_p2")  # Emite sinal para ativar colisões de punch1
			elif attack_state == 1:
				
				animation.play("punch2")
				attack_state = 2
				emit_signal("punch_activated_p2", "state2_p2")  # Emite sinal para ativar colisões de punch2
			else:
				animation.play("punch3")
				attack_state = 0
				emit_signal("punch_activated_p2", "state3_p2")  # Emite sinal para ativar colisões de punch3
			
			combo_window = COMBO_WINDOW_DURATION  # Reinicia a janela de combo
			combo_ready = false  # Reseta combo_ready ao iniciar novo ataque
	
	if type_player == 1:
		# Lógica para o ataque opcional com teclado numerico
		if Input.is_action_just_pressed("ui_opcional") and not is_attacking and not opcional_attack:
			animation.play("opcional")
			emit_signal("punch_activated_p2", "opcional_p2") # Emite sinal para ativar colisões de opcional_2
			is_attacking = true
			opcional_attack = true  # Marca que o ataque opcional está em execução
			velocity.x = 0  # Para o movimento horizontal durante o ataque opcional
	else:
		# Lógica para o ataque opcional com k
		if Input.is_action_just_pressed("ui_K") and not is_attacking and not opcional_attack:
			animation.play("opcional")
			emit_signal("punch_activated_p2", "opcional_p2") # Emite sinal para ativar colisões de opcional_K
			is_attacking = true
			opcional_attack = true  # Marca que o ataque opcional está em execução
			velocity.x = 0  # Para o movimento horizontal durante o ataque opcional
			
	if type_player == 1:
		# Lógica para o ataque especial com teclado numerico
		if Input.is_action_just_pressed("ui_especial") and is_on_floor() and not using_special and not is_attacking and special_could:
			print("3 foi pressionado")
			if(power >= MaxPower): #Verificar se a barra de power ta cheia
				if current_direction == 1:
					animationEspecial.position.x = 630
					animationEspecial.flip_h = false
				else:
					animationEspecial.position.x = -599.175
					animationEspecial.flip_h = true
				
				power = 0
				animation.play("especial")
				SoltarEspecial()
				animationEspecial.play("especialNeemias")
				is_attacking = true
				using_special = true  # Marca o especial como usado
				velocity.x = 0  # Para o movimento horizontal durante o ataque especial
	else:
		# Lógica para o ataque especial com L
		if Input.is_action_just_pressed("ui_L") and is_on_floor() and not using_special and not is_attacking and special_could:
			print("L foi pressionado")
			if(power >= MaxPower): #Verificar se a barra de power ta cheia
				if current_direction == 1:
					animationEspecial.position.x = 630
					animationEspecial.flip_h = false
				else:
					animationEspecial.position.x = -599.175
					animationEspecial.flip_h = true
				
				power = 0
				animation.play("especial")
				
				SoltarEspecial()
				animationEspecial.play("especialNeemias")
				is_attacking = true
				using_special = true  # Marca o especial como usado
				velocity.x = 0  # Para o movimento horizontal durante o ataque especial
			
	if type_player == 1:
		
		if not is_round: # para funçao round
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
		else:
			animation.play("idle")			
					
		if not is_on_floor() and not is_attacking:
			animation.play("jump")
		move_and_slide()
	else:
		# Movimento só é permitido se não estiver atacando
		if not is_round:
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
		else:
			animation.play("idle")	
					
		if not is_on_floor() and not is_attacking:
			animation.play("jump")
		move_and_slide()
		
	if current_direction == 1: 
		$hitbox_neemias/opcionalePunch1.position.x = 169
		$hitbox_neemias/punch2.position.x = 191
		$hitbox_neemias/punch3.position.x = 173
	elif current_direction == -1:
		$hitbox_neemias/opcionalePunch1.position.x = -125
		$hitbox_neemias/punch2.position.x = -150
		$hitbox_neemias/punch3.position.x = -130
	# Lógica para animação de defesa
	if type_player != 1:
		# Defesa com a tecla "U" para o player com type_player != 1
		if Input.is_action_pressed("ui_U"):
			is_defending = true
			velocity.x = 0  # Impede movimento enquanto defende
			animation.play("defesa", false)  # Reproduz a animação de defesa sem looping
		else:
			is_defending = false  # Para a defesa quando a tecla for solta
	else:
		# Defesa com a tecla "4" para o player com type_player == 1
		if Input.is_action_pressed("ui_defesa"):
			is_defending = true
			velocity.x = 0  # Impede movimento enquanto defende
			animation.play("defesa", false)  # Reproduz a animação de defesa sem looping
		else:
			is_defending = false  # Para a defesa quando a tecla for solta

func SoltarEspecial()-> void:
	emit_signal("punch_activated_p2", "state4_p2")  # Emite sinal para ativar colisões de punch3


func VirarDeLado() -> void:
	current_direction = current_direction*-1
	animation.scale.x = abs(animation.scale.x) * current_direction

func KnockBack() -> void:
	if(current_direction==-1):
		velocity.x = move_toward(velocity.x, 0, 100)	
		
	else:
		velocity.x = move_toward(velocity.x, 0, 200)	

func _damage(damegeValue: int) -> void:
	is_attacking = true
	vida-= damegeValue
	power += 5
	power = clamp(power, 0, MaxPower)
	animation.play("damage")
	
	
func _start_round() -> void: is_round = true

func _desativar_start_round() -> void: is_round = false

# Função que é chamada automaticamente quando a animação termina
func _on_anim_animation_finished() -> void:
	# Verifica se a animação que acabou de terminar é de ataque
	
	if animation.animation in ["punch1", "punch2", "punch3", "especial", "opcional", "damage"]:
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
			COMBO_WINDOW_DURATION = 0.4
			
			#retirando as animações de particulas do personagem
	for child in get_parent().get_children():
		if child is Sprite2D:
			for grandchild in child.get_children():  # Itera sobre os filhos do Sprite2D
				grandchild.queue_free()
		
		if child is AnimatedSprite2D and child.animation == "fumaca_pulo":  # Verifica se é a animação de fumaça
			child.queue_free()  # Remove a animação do mundo		
			
			

			
