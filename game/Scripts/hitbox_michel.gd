extends Area2D

@onready var hitbox_area: Area2D = $"."
var punch1e2: CollisionShape2D
var punch3eopcional: CollisionShape2D

var attack_time: float = 0.3
var attack_timer: float = 0.0
var attack_active: bool = false

# Propriedade personalizada para o tipo de golpe
var hitbox_type: String

# Método para retornar o tipo de golpe
func get_hitbox_type() -> String:
	return hitbox_type

func _ready():
	if hitbox_area == null:
		print("Erro: 'hitbox' não encontrado.")
		return

	var children = hitbox_area.get_children()
	for child in children:
		if child is CollisionShape2D:
			if punch1e2 == null:
				punch1e2 = child
				hitbox_type = "punch1"  # Defina o tipo de golpe aqui
			elif punch3eopcional == null:
				punch3eopcional = child
				hitbox_type = "punch3"  # Defina o tipo de golpe aqui

	if punch1e2 == null or punch3eopcional == null:
		print("Erro: 'punch1e2' ou 'punch3eopcional' não encontrados dentro de hitbox.")
		return

	print("Children of hitbox:", children)

	punch1e2.disabled = true
	punch3eopcional.disabled = true
	hitbox_area.monitoring = false

	var player = get_parent()
	if player.has_signal("punch_activated"):
		player.connect("punch_activated", Callable(self, "_on_punch_activated"))
	else:
		print("Erro: O nó pai não possui o sinal 'punch_activated'.")

func _process(delta):
	if attack_active:
		attack_timer += delta
		if attack_timer >= attack_time:
			deactivate_hitbox()

func _on_punch_activated(state: String) -> void:
	if state == "state1" or state == "state2":
		activate_hitbox("punch1e2")
	elif state == "state3":
		activate_hitbox("punch3eopcional")
	elif state == "opcional":
		activate_hitbox("punch3eopcional")

func activate_hitbox(punch_name: String) -> void:
	print("Ativando hitbox:", punch_name)
	if hitbox_area == null or punch1e2 == null or punch3eopcional == null:
		print("Erro: hitbox_area, punch1e2 ou punch3eopcional não inicializados.")
		return

	hitbox_area.monitoring = true
	if punch_name == "punch1e2":
		punch1e2.disabled = false
		hitbox_type = "punch1"  # Atualiza o tipo de golpe ativo
	elif punch_name == "punch3eopcional":
		punch3eopcional.disabled = false
		hitbox_type = "punch3"  # Atualiza o tipo de golpe ativo

	attack_active = true
	attack_timer = 0.0

func deactivate_hitbox() -> void:
	print("Desativando hitboxes")
	punch1e2.disabled = true
	punch3eopcional.disabled = true
	hitbox_area.monitoring = false
	attack_active = false
