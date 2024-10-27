extends Control


@onready var tempo_label = $MarginContainer/Tempo_container/Tempo_label as Label
@onready var clocktimer = $clocktimer as Timer

var seconds = 0
@export_range(0,90) var default_seconds := 90

signal time_is_up()
  # Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tempo_label.text = str("%02d" % default_seconds)
	reset_clock_timer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
  


func _on_clocktimer_timeout() -> void:
	seconds -= 1
	tempo_label.text = str("%02d" % seconds)
	
func  reset_clock_timer():
	seconds = default_seconds
