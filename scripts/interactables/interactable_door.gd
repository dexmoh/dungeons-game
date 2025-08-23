extends Interactable

@export var is_open: bool = false
@export var door_sprite: Sprite2D

@onready var open_sfx: AudioStreamPlayer2D = $DoorOpenAudio
@onready var close_sfx: AudioStreamPlayer2D = $DoorCloseAudio

func _ready() -> void:
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
		door_sprite.region_rect.position.x -= Globals.tile_size.x
		label_text = "Open"
		close_sfx.play()
		set_collision_layer_value(1, true)
	else:
		# Open the door.
		is_open = true
		door_sprite.region_rect.position.x += Globals.tile_size.x
		label_text = "Close"
		open_sfx.play()
		set_collision_layer_value(1, false)
	
	var navmesh = get_tree().get_first_node_in_group("nav_region")
	if navmesh is NavigationRegion2D:
		navmesh.bake_navigation_polygon()
