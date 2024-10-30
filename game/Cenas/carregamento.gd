extends Control

@export var cenaCarregada = ""  # Caminho do mapa a ser carregado
var scene_load_status = 0
var progress = []

func _ready() -> void:
	# Inicia o carregamento do mapa
	print(cenaCarregada)
	if cenaCarregada != "":
		ResourceLoader.load_threaded_request(cenaCarregada)

func _process(delta: float) -> void:
	# Monitora o status do carregamento
	if cenaCarregada != "":
		scene_load_status = ResourceLoader.load_threaded_get_status(cenaCarregada, progress)
		
		if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var novaCena = ResourceLoader.load_threaded_get(cenaCarregada)
			
			get_tree().change_scene_to_packed(novaCena)  # Troca para o mapa carregado
			queue_free()  # Libera a cena de carregamento
