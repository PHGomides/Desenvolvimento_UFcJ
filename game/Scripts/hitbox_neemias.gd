extends Area2D

@onready var hitbox_area: Area2D = $"."
var opcionalePunch1: CollisionShape2D
var punch2: CollisionShape2D
var punch3: CollisionShape2D
var attack_time: float = 0.3
var attack_timer: float = 0.0
var attack_active: bool = false

# Propriedade personalizada para o tipo de golpe
var hitbox_type: String

# Método para retornar o tipo do golpe
func get_hitbox_type() -> String:
	return hitbox_type

func _ready():
	if hitbox_area == null:
		print("Erro: 'hitbox' não encontrado.")
		return

	var children = hitbox_area.get_children()
	for child in children:
		if child is CollisionShape2D:
			if opcionalePunch1 == null:
				opcionalePunch1 = child
				hitbox_type = "punch1"  # Defina o tipo de golpe aqui
			elif punch2 == null:
				punch2 = child
				hitbox_type = "punch2"  # Defina o tipo de golpe aqui
			elif punch3 == null:
				punch3 = child
				hitbox_type = "punch3"  # Defina o tipo de golpe aqui

	if opcionalePunch1 == null or punch2 == null or punch3 == null:
		print("Erro: 'punch1e2' ou 'punch3eopcional' não encontrados dentro de hitbox.")
		return

	print("Children of hitbox:", children)

	opcionalePunch1.disabled = true
	punch2.disabled = true
	punch3.disabled = true
	hitbox_area.monitoring = false

	var player2 = get_parent()
	if player2.has_signal("punch_activated_p2"):
		player2.connect("punch_activated_p2", Callable(self, "_on_punch_activated_p2"))
	else:
		print("Erro: O nó pai não possui o sinal 'punch_activated_p2'.")

func _process(delta):
	if attack_active:
		attack_timer += delta
		if attack_timer >= attack_time:
			deactivate_hitbox()

func _on_punch_activated_p2(state: String) -> void:
	if state == "state1_p2":
		activate_hitbox("opcionalePunch1")
	elif state == "state2_p2":
		activate_hitbox("punch2")
	elif state == "state3_p2":
		activate_hitbox("punch3")
	elif state == "opcional_p2":
		activate_hitbox("opcionalePunch1")

func activate_hitbox(punch_name: String) -> void:
	print("Ativando hitbox:", punch_name)
	if hitbox_area == null or opcionalePunch1 == null or punch2 == null or punch3 == null:
		print("Erro: hitbox_area, punch1e2 ou punch3eopcional não inicializados.")
		return

	hitbox_area.monitoring = true
	if punch_name == "opcionalePunch1":
		opcionalePunch1.disabled = false
		hitbox_type = "punch1"
	elif punch_name == "punch2":
		punch2.disabled = false
		hitbox_type = "punch2"
	elif punch_name == "punch3":
		punch3.disabled = false
		hitbox_type = "punch3"

	attack_active = true
	attack_timer = 0.0

func deactivate_hitbox() -> void:
	print("Desativando hitboxes")
	opcionalePunch1.disabled = true
	punch2.disabled = true
	punch3.disabled = true
	hitbox_area.monitoring = false
	attack_active = false
