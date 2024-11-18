extends Control
@export var mapa_atual = 1



func _on_mapaBtn_pressed(mapa_id: int) -> void:
	mapa_atual = mapa_id

func IniciarMapa() -> void:
	# Define o caminho da cena com base no mapa selecionado
	if mapa_atual == 1:
		Global.mapaEscolhido = "res://prefer/world.tscn"
	elif mapa_atual == 2:
		Global.mapaEscolhido = "res://prefer/fila_caj.tscn"
	elif mapa_atual == 4:
		Global.mapaEscolhido = "res://prefer/frente_ufj.tscn"
	elif mapa_atual == 5:
		Global.mapaEscolhido = "res://prefer/restaurante.tscn"
	else:
		print("Mapa aleatório selecionado")

	# Muda para a cena de carregamento e passa o mapa selecionado como um argumento
	if Global.mapaEscolhido != "":
		var carregamento = load("res://Cenas/Carregamento.tscn").instantiate()
		carregamento.cenaCarregada = Global.mapaEscolhido  # Passa o caminho do mapa
		get_tree().root.add_child(carregamento)
	else:
		print("Erro: cena para carregar não definida.")
