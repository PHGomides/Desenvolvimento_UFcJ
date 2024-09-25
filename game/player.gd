extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Variável para pulo
var is_jumping = false

# Variável booleana que indica se o personagem está atacando
var is_attacking = false

# Referência ao nó AnimatedSprite2D, que controla as animações do personagem
@onready var animation := $anim as AnimatedSprite2D

# Função que processa a física do personagem a cada frame
func _physics_process(delta: float) -> void:
	# Adiciona a gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lógica para o pulo.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		is_jumping = false

	# Lógica para ataque.
	if Input.is_action_just_pressed("ui_punch") and not is_attacking:
		print("1 foi pressionado")
		animation.play("punch1")  # Reproduz a animação de soco
		is_attacking = true  # Marca que o personagem está atacando

	# Captura a direção horizontal com base na entrada do jogador (teclas esquerda/direita)
	var direction := Input.get_axis("ui_left", "ui_right")
	if !is_attacking:
	# Direita retorna 1, esquerda retorna -1
		if direction:
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
	# Verifica se a animação que acabou de terminar é a de soco
	if animation.animation == "punch1":
		is_attacking = false  # Permite que o personagem volte a se mover após o soco
