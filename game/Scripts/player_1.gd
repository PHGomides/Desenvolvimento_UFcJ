extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -300.0

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
var current_direction = 1

# Referência ao nó AnimatedSrite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D
@onready var animationEspecial := $especial as AnimatedSprite2D


# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lógica para o pulo.
	if Input.is_action_just_pressed("ui_cimaseta") and is_on_floor() and not is_attacking:
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		is_jumping = false

	# Lógica para ataque.
	if Input.is_action_just_pressed("ui_punch") and not is_attacking:
		print("1 foi pressionado")
		is_attacking = true  # Marca que o personagem está atacando
		velocity.x = 0  # Para o movimento horizontal durante o ataque
		
		# Alterna entre as animações de punch
		if attack_state == 0:
			animation.play("punch1")
			attack_state = 1 
		elif attack_state == 1:
			animation.play("punch2")
			attack_state = 2
		else:
			animation.play("punch3")
			attack_state = 0
	
	# Lógica para o ataque opcional
	elif Input.is_action_just_pressed("ui_opcional") and not is_attacking and not opcional_attack:
		print("2 foi pressionado")
		animation.play("opcional")
		is_attacking = true
		opcional_attack = true  # Marca que o ataque opcional está em execução
		velocity.x = 0  # Para o movimento horizontal durante o ataque opcional

	# Lógica para o ataque especial
	elif Input.is_action_just_pressed("ui_especial") and is_on_floor() and not using_special and not is_attacking and special_could:
		print("3 foi pressionado")
		if current_direction==1:
			animationEspecial.position.x = 691.109
		else:
			animationEspecial.position.x = -691.109
			
		animation.play("especial")
		
		
		
		animationEspecial.play("especialMichel")
		is_attacking = true
		using_special = true  # Marca o especial como usado
		velocity.x = 0  # Para o movimento horizontal durante o ataque especial

	# Movimento só é permitido se não estiver atacando
	if not is_attacking:
		var direction := Input.get_axis("ui_left", "ui_right")
		print(current_direction)

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
	
	move_and_slide()

# Função que é chamada automaticamente quando a animação termina
func _on_anim_animation_finished() -> void:
	# Verifica se a animação que acabou de terminar é de ataque
	if animation.animation in ["punch1", "punch2", "punch3", "especial", "opcional"]:
		is_attacking = false  # Permite que o personagem volte a se mover após o ataque
		
		if animation.animation == "especial":
			using_special = false  # Permite o uso do especial novamente
		elif animation.animation == "opcional":
			opcional_attack = false  # Permite o uso do ataque opcional novamente
