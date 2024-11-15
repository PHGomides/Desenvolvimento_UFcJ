extends Control

@onready var tempo_label = $MarginContainer/Tempo_container/Tempo_label as Label
@onready var clocktimer = $clocktimer as Timer
@onready var round: Control = $"../Round"

var seconds = 0

@export_range(0,90) var default_seconds := 90

signal time_is_up()

func _ready() -> void:
	round.connect("reset_time", Callable(self, "inciartimer"))	
	tempo_label.text = str("%02d" % default_seconds)
	seconds = default_seconds


func _on_clocktimer_timeout() -> void:
	seconds -= 1
	tempo_label.text = str("%02d" % seconds)
	if seconds == 0:
		clocktimer.stop()  # Para o timer quando o tempo termina
		emit_signal("time_is_up")  # Emite o sinal de tempo esgotado
	
func iniciartimer():
	clocktimer.start()
	
func recomeco():
	clocktimer.stop()
	seconds = default_seconds
	tempo_label.text = str("%02d" % seconds)
	clocktimer.start()  # Reinicia o timer
	
