extends VideoStreamPlayer

# Caminho da nova cena que será carregada após o término do vídeo.
const NEXT_SCENE_PATH = "res://Cenas/main_menu.tscn"

# Chamado quando o nó entra na cena.
func _ready() -> void:
	# Conecta o sinal `finished` para detectar o término do vídeo.
	connect("finished",Callable(self, "_on_video_finished"))

# Função chamada quando o vídeo termina.
func _on_video_finished() -> void:
	# Muda para a próxima cena.
	var carregamento = load("res://Cenas/Carregamento.tscn").instantiate()
	carregamento.cenaCarregada = NEXT_SCENE_PATH
	get_tree().root.add_child(carregamento)
