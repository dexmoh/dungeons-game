extends Interactable

@export var is_open: bool = false
@export var door_sprite: Sprite2D

@onready var open_sfx: AudioStreamPlayer2D = $DoorOpenAudio
@onready var close_sfx: AudioStreamPlayer2D = $DoorCloseAudio

var tile_size: Vector2

func _ready() -> void:
	tile_size = ProjectSettings.get_setting("global/tile_size")
	if is_open:
		is_open = !is_open
		open_and_close()

func interact(_src: Node2D):
	open_and_close()
	
# Open, or close the door.
func open_and_close():
	if is_open:
		# Close the door.
		is_open = false
		door_sprite.region_rect.position.x -= tile_size.x
		label_text = "Open"
		close_sfx.play()
		set_collision_layer_value(1, true)
	else:
		# Open the door.
		is_open = true
		door_sprite.region_rect.position.x += tile_size.x
		label_text = "Close"
		open_sfx.play()
		set_collision_layer_value(1, false)
