extends Area2D

@onready var hitbox_area: Area2D = $"."  # O caminho para o nó 'hitbox' dentro do player
var punch1e2: CollisionShape2D
var punch3eopcional: CollisionShape2D
var attack_time: float = 0.3  # Tempo de ataque em segundos
var attack_timer: float = 0.0
var attack_active: bool = false

func _ready():
	if hitbox_area == null:
		print("Erro: 'hitbox' não encontrado.")
		return

	# Tenta encontrar os filhos com base em índice ou tipo
	var children = hitbox_area.get_children()
	for child in children:
		if child is CollisionShape2D:
			if punch1e2 == null:
				punch1e2 = child  # Define o primeiro CollisionShape2D encontrado como punch1e2
			elif punch3eopcional == null:
				punch3eopcional = child  # Define o segundo CollisionShape2D encontrado como punch3eopcional

	# Verifica se os nós foram encontrados
	if punch1e2 == null or punch3eopcional == null:
		print("Erro: 'punch1e2' ou 'punch3eopcional' não encontrados dentro de hitbox.")
		return

	# Debug para listar os filhos de 'hitbox'
	print("Children of hitbox:", children)

	# Desativa as formas de colisão no início
	punch1e2.disabled = true
	punch3eopcional.disabled = true
	hitbox_area.monitoring = false  # Desativa a detecção da Area2D no início

	var player = get_parent()  # Acesse o nó pai (que deve ser o CharacterBody2D)

	# Verifica se o nó pai tem o sinal 'punch_activated' e se o método existe
	if player.has_signal("punch_activated"):
		player.connect("punch_activated", Callable(self, "_on_punch_activated"))
	else:
		print("Erro: O nó pai não possui o sinal 'punch_activated'.")


func _process(delta):
	# Verifica se o jogador pressionou a tecla de ataque
	if Input.is_action_just_pressed("ui_opcional"):
		activate_hitbox("punch3eopcional")  # Passa o nome da forma de colisão para ativar
	
	# Verifica se o ataque está ativo e o tempo de ataque está passando
	if attack_active:
		attack_timer += delta
		if attack_timer >= attack_time:
			deactivate_hitbox()

func _on_punch_activated(state: String) -> void:
	# Ativa a hitbox com base no estado do ataque
	if state == "state1" or state == "state2":
		activate_hitbox("punch1e2")
	elif state == "state3":
		activate_hitbox("punch3eopcional")
	elif Input.is_action_just_pressed("ui_opcional"):
		activate_hitbox("punch3eopcional")

func activate_hitbox(punch_name: String) -> void:
	if hitbox_area == null or punch1e2 == null or punch3eopcional == null:
		print("Erro: hitbox_area, punch1e2 ou punch3eopcional não inicializados.")
		return

	# Ativa a detecção de colisão e a forma de colisão especificada
	hitbox_area.monitoring = true

	if punch_name == "punch1e2":
		punch1e2.disabled = false
	elif (punch_name == "punch3eopcional"):
		punch3eopcional.disabled = false

	# Ativa o estado de ataque
	attack_active = true
	attack_timer = 0.0  # Reinicia o contador do timer

func deactivate_hitbox() -> void:
	# Desativa as formas de colisão e o monitoramento da área
	punch1e2.disabled = true
	punch3eopcional.disabled = true
	hitbox_area.monitoring = false

	# Desativa o estado de ataque
	attack_active = false
