extends Control

@onready var tempo_label = $MarginContainer/Tempo_container/Tempo_label as Label
@onready var clocktimer = $clocktimer as Timer

var seconds = 0

@export_range(0,90) var default_seconds := 90

signal time_is_up()

func _ready() -> void:
	tempo_label.text = str("%02d" % default_seconds)
	reset_clock_timer()

func _process(delta: float) -> void:
	pass
  

func _on_clocktimer_timeout() -> void:
	seconds -= 1
	tempo_label.text = str("%02d" % seconds)
	if seconds == 0:
		clocktimer.stop()  # Para o timer quando o tempo termina
		emit_signal("time_is_up")  # Emite o sinal de tempo esgotado
	
func reset_clock_timer():
	seconds = default_seconds
	
func recomeco():
	clocktimer.start()  # Reinicia o timer
	
