extends Camera2D

@export var focus: Node2D
@export var movement_smoothing_speed: float = 8.0
@export var zoom_speed: float = 10.0
@export var min_zoom: float = 0.5
@export var max_zoom: float = 8.0

var zoom_target: Vector2
var is_panning: bool
var pan_start_mouse_pos: Vector2
var pan_start_cam_pos: Vector2

func _ready() -> void:
	zoom_target = zoom
	is_panning = false
	pan_start_mouse_pos = Vector2.ZERO
	pan_start_cam_pos = Vector2.ZERO

func _process(delta: float) -> void:
	# Move camera towards focus.
	if !is_panning and focus:
		position = position.slerp(focus.global_position, movement_smoothing_speed * delta)
	
	# Zoom camera.
	if Input.is_action_just_pressed("zoom_in"):
		zoom_target *= 1.1
	elif Input.is_action_just_pressed("zoom_out"):
		zoom_target *= 0.9
	
	zoom_target = zoom_target.clampf(min_zoom, max_zoom)
	zoom = zoom.slerp(zoom_target, zoom_speed * delta)
	
	# Pan camera.
	if !is_panning and Input.is_action_just_pressed("camera_pan"):
		is_panning = true
		pan_start_cam_pos = position
		pan_start_mouse_pos = get_viewport().get_mouse_position()
	elif is_panning and Input.is_action_just_released("camera_pan"):
		is_panning = false
	elif is_panning:
		var move_vec := get_viewport().get_mouse_position() - pan_start_mouse_pos
		position = pan_start_cam_pos - move_vec * (1 / zoom.x)
