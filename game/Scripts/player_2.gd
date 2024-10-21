extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -400.0

# Variável para pulo
var is_jumping = false

# Variável booleana que indica se o personagem está atacando
var is_attacking = false
# Variável que alterna entre os estados da animação de ataque
var attack_state = 0

# Variável para decidir se o especial pode ser usado
var using_special = false
var special_could = true

# Variável para controlar o ataque opcional
var opcional_attack = false

# Referência ao nó AnimatedSprite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D

# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lógica para o pulo (W).
	if Input.is_action_just_pressed("ui_w") and is_on_floor() and not is_attacking:
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		is_jumping = false

	# Lógica para ataque de soco (J).
	if Input.is_action_just_pressed("ui_J") and not is_attacking:
		print("J foi pressionado")
		is_attacking = true  # Marca que o personagem está atacando
		velocity.x = 0  # Para o movimento horizontal durante o ataque
		
		# Alterna entre as animações de socos
		if attack_state == 0:
			animation.play("punch1")
			attack_state = 1 
		elif attack_state == 1:
			animation.play("punch2")
			attack_state = 2
		else:
			animation.play("punch3")
			attack_state = 0
	
	# Lógica para o chute (K)
	elif Input.is_action_just_pressed("ui_K") and not is_attacking and not opcional_attack:
		print("K foi pressionado")
		animation.play("kick")
		is_attacking = true
		opcional_attack = true  # Marca que o chute está em execução
		velocity.x = 0  # Para o movimento horizontal durante o chute

	# Lógica para o ataque especial (L)
	elif Input.is_action_just_pressed("ui_L") and is_on_floor() and not using_special and not is_attacking and special_could:
		print("L foi pressionado")
		animation.play("especial")
		is_attacking = true
		using_special = true  # Marca o especial como usado
		velocity.x = 0  # Para o movimento horizontal durante o ataque especial

	# Movimento só é permitido se não estiver atacando
	if not is_attacking:
		var direction := Input.get_axis("ui_A", "ui_D")
		
		if direction != 0:
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
	
	move_and_slide()

# Função que é chamada automaticamente quando a animação termina
func _on_anim_animation_finished() -> void:
	# Verifica se a animação que acabou de terminar é de ataque
	if animation.animation in ["punch1", "punch2", "punch3", "especial", "kick"]:
		is_attacking = false  # Permite que o personagem volte a se mover após o ataque
		
		if animation.animation == "especial":
			using_special = false  # Permite o uso do especial novamente
		elif animation.animation == "kick":
			opcional_attack = false  # Permite o uso do chute novamente
