extends Camera2D

@export var move_speed = 30  # Camera position lerp speed
@export var zoom_speed = 3.0  # Camera zoom lerp speed
@export var min_zoom = 3  # Camera won't zoom closer than this
@export var max_zoom = 1  # Camera won't zoom farther than this
@export var margin = Vector2(400, 200)  # Include some buffer area around targets
@export var zoom_margin = Vector2(200, 100)  # Extra margin to anticipate zoom out

var targets = []
var focus_point = Vector2.ZERO  # Variable to store the focus point

@onready var screen_size = get_viewport_rect().size

func _process(delta):
	if !targets:
		return

	# Keep the camera centered among all targets
	var p = Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed * delta)

	# Find the zoom that will contain all targets
	var r = Rect2(position, Vector2.ONE)
	for target in targets:
		r = r.expand(target.position)
	
	# Grow the rectangle with both the default margin and the zoom_margin
	r = r.grow_individual(margin.x + zoom_margin.x, margin.y + zoom_margin.y, margin.x + zoom_margin.x, margin.y + zoom_margin.y)

	# Calculate the zoom based on the modified rectangle
	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = 1 / clamp(r.size.x / screen_size.x, max_zoom, min_zoom)
	else:
		z = 1 / clamp(r.size.y / screen_size.y, max_zoom, min_zoom)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed * delta)

	# For debug


func _draw() -> void:
	draw_circle(focus_point, 5, Color.RED)
	
func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.remove(t)
