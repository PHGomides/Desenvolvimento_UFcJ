extends VBoxContainer
var Personagem1 = 0
var Personagem2 = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func SelecionarPersonagem1(number: int)-> void:
	Personagem1 = number
	print(Personagem1)

func SelecionarPersonagem2(number: int)-> void:
	Personagem2 = number
	print(Personagem2)
